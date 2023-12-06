using BaseStructure_47.Controllers;
using BaseStructure_47;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Policy;
using System.Web;
using System.Web.Mvc;
using System.ComponentModel.Design;
using System.Web.WebPages;
using System.Security.Cryptography;

namespace BaseStructure_47.Areas.E_Commerce.Controllers
{
	[RouteArea("Admin")]
	public class ProductController : BaseController<ResponseModel<EC_Product>>
	{
		public ActionResult Index()
		{
			List<EC_Product> list = GetList();

			if (list != null)
				foreach (EC_Product obj in list)
				{
					obj.CategoryName = GetCategoryList().Where(x => x.Id == obj.CategoryId).Select(x => x.Name).FirstOrDefault();
					obj.CategoryId = _context.ProductDtls.AsNoTracking().ToList().Where(x => x.ProductId == obj.Id && x.IsActive == true).Count();

				}

			CommonViewModel.ObjList = list;

			return View("~/Areas/E_Commerce/Views/Product/Index.cshtml", CommonViewModel);
		}

		//[CustomAuthorizeAttribute(AccessType_Enum.Read)]
		public ActionResult Partial_AddEditForm(long Id = 0)
		{
			var obj = new EC_Product();

			List<EC_Product> list = GetList();

			if (Id > 0)
				obj = list.Where(x => x.Id == Id).FirstOrDefault();

			var listCategory = GetCategoryList().Where(x => x.IsActive == true && x.IsDeleted == false)
				.Select(x => new SelectListItem_Custom(Convert.ToString(x.Id), Convert.ToString(x.Name), "C")).ToList();

			var listUnit = _context.Units.AsNoTracking().ToList().Where(x => x.IsActive == true).ToList()
							.Select(x => new SelectListItem_Custom(Convert.ToString(x.Id), Convert.ToString(x.Code) + " - " + Convert.ToString(x.Name), "U")).ToList();

			var listAttr = (from x in _context.Attributes.AsNoTracking().ToList()
							join y in _context.AttributeValues.AsNoTracking().ToList() on x.Id equals y.AttributeId
							where x.IsActive == true && y.IsActive == true
								   && (x.CompanyId == Common.Get_Session_Int(SessionKey.COMPANY_ID) || x.CompanyId == 0)
								   && (x.BranchId == Common.Get_Session_Int(SessionKey.BRANCH_ID) || x.BranchId == 0)
							orderby x.Name, y.Value, y.Display_Value
							select new { Id = x.Id + "|" + y.Id, AttributeName = x.Name, Option = y.Value + (string.IsNullOrEmpty(y.Display_Value) ? "" : " (" + y.Display_Value + ")") }).ToList()
							.Select(x => new SelectListItem_Custom(Convert.ToString(x.Id), Convert.ToString(x.AttributeName) + " - " + Convert.ToString(x.Option), "A")).ToList();

			CommonViewModel.SelectListItems = new List<SelectListItem_Custom>();

			if (listCategory != null)
				CommonViewModel.SelectListItems.AddRange(listCategory);

			if (listUnit != null)
				CommonViewModel.SelectListItems.AddRange(listUnit);

			if (listAttr != null)
				CommonViewModel.SelectListItems.AddRange(listAttr);


			if (obj == null)
				obj = new EC_Product();


			var listAttribute = new List<EC_Product_Attributes>();

			var listProduct_Dtls = _context.ProductDtls.AsNoTracking().ToList().Where(x => x.ProductId == obj.Id).ToList();

			if (listProduct_Dtls != null && listProduct_Dtls.Count() > 0)
			{
				var listVariant = _context.Variants.AsNoTracking().ToList()
						.Where(x => x.ProductId == obj.Id && x.CompanyId == Common.Get_Session_Int(SessionKey.COMPANY_ID)
							&& x.BranchId == Common.Get_Session_Int(SessionKey.BRANCH_ID)).ToList();

				if (listVariant != null && listVariant.Count > 0)
					listAttribute = listVariant.Where(x => x.AttributeId > 0 && x.AttributeValueId > 0 && x.VariantId > 0).GroupBy(x => x.VariantId).Select(x => new EC_Product_Attributes() { Id = x.Key, AttributeValue = string.Join("#", x.Select(z => z.AttributeId + "|" + z.AttributeValueId)) }).ToList();


				if (listAttribute != null && listAttribute.Count > 0)
					foreach (var item in listAttribute)
						item.SalePrice = listProduct_Dtls.Where(x => x.VariantId == item.Id).Select(x => x.SalePrice).FirstOrDefault();

			}

			obj.listAttribute = listAttribute;

			CommonViewModel.Obj = obj;

			return PartialView("~/Areas/E_Commerce/Views/Product/_Partial_AddEditForm.cshtml", CommonViewModel);
		}

		[HttpPost]
		//[CustomAuthorizeAttribute(AccessType_Enum.Write)]
		public ActionResult Save(EC_Product viewModel)
		{
			try
			{
				if (viewModel != null && viewModel != null)
				{
					#region Validation

					if (!Common.IsAdmin())
					{
						CommonViewModel.IsSuccess = false;
						CommonViewModel.StatusCode = ResponseStatusCode.Error;
						CommonViewModel.Message = ResponseStatusMessage.UnAuthorize;

						return Json(CommonViewModel);
					}

					if (string.IsNullOrEmpty(viewModel.Name))
					{
						CommonViewModel.IsSuccess = false;
						CommonViewModel.StatusCode = ResponseStatusCode.Error;
						CommonViewModel.Message = "Please enter Product name.";

						return Json(CommonViewModel);
					}

					if (viewModel.CategoryId <= 0)
					{
						CommonViewModel.IsSuccess = false;
						CommonViewModel.StatusCode = ResponseStatusCode.Error;
						CommonViewModel.Message = "Please select Category.";

						return Json(CommonViewModel);
					}

					if (_context.Product.AsNoTracking().ToList().Any(x => x.Name.ToLower().Replace(" ", "") == viewModel.Name.ToLower().Replace(" ", "")
									&& x.CategoryId != viewModel.CategoryId && x.Id != viewModel.Id
									&& x.CompanyId == Common.Get_Session_Int(SessionKey.COMPANY_ID)
									&& x.BranchId == Common.Get_Session_Int(SessionKey.BRANCH_ID)))
					{
						CommonViewModel.IsSuccess = false;
						CommonViewModel.StatusCode = ResponseStatusCode.Error;
						CommonViewModel.Message = "Product already exist. Please try another Product name.";

						return Json(CommonViewModel);
					}

					#endregion

					#region Database-Transaction

					try
					{
						viewModel.CompanyId = Common.Get_Session_Int(SessionKey.COMPANY_ID);
						viewModel.BranchId = Common.Get_Session_Int(SessionKey.BRANCH_ID);

						EC_Product obj = new EC_Product();

						obj = _context.Product.AsNoTracking().ToList().Where(x => x.Id == viewModel.Id
									&& x.CompanyId == Common.Get_Session_Int(SessionKey.COMPANY_ID)
									&& x.BranchId == Common.Get_Session_Int(SessionKey.BRANCH_ID)).FirstOrDefault();

						//if (viewModel != null && !(viewModel.DisplayOrder > 0))
						//	viewModel.DisplayOrder = (_context.Companies.AsNoTracking().Max(x => x.DisplayOrder) ?? 0) + 1;

						if (obj != null && Common.IsAdmin())
						{
							obj.Name = viewModel.Name;
							obj.CategoryId = viewModel.CategoryId;
							obj.UnitId = viewModel.UnitId;
							obj.MRP = viewModel.MRP;
							obj.IsActive = viewModel.IsActive;

							obj.CompanyId = viewModel.CompanyId;
							obj.BranchId = viewModel.BranchId;

							_context.Entry(obj).State = System.Data.Entity.EntityState.Modified;
							_context.SaveChanges();
						}
						else if (Common.IsAdmin())
						{
							_context.Product.Add(viewModel);
							_context.SaveChanges();
							_context.Entry(viewModel).Reload();
						}


						if (viewModel.listAttribute == null)
							viewModel.listAttribute = new List<EC_Product_Attributes>();

						viewModel.listAttribute.Add(new EC_Product_Attributes()
						{
							AttributeValue = "0|0",
							SalePrice = viewModel.MRP
						});

						if (viewModel.listVariant == null)
							viewModel.listVariant = new List<EC_Product_Variant>();

						foreach (var item in viewModel.listAttribute.Where(x => !string.IsNullOrEmpty(x.AttributeValue) && x.IsDeleted == false).ToList())
						{
							var maxId = viewModel.listVariant.OrderByDescending(x => x.Id).Select(x => x.Id).FirstOrDefault() + 1;

							if (item.AttributeValue.Contains("#"))
							{
								foreach (var attr in item.AttributeValue.Split('#').ToList())
								{
									viewModel.listVariant.Add(new EC_Product_Variant()
									{
										Id = maxId,
										ProductId = viewModel.Id,
										AttributeId = attr.Contains("|") ? Convert.ToInt32(attr.Split('|')[0]) : 0,
										AttributeValueId = attr.Contains("|") ? Convert.ToInt32(attr.Split('|')[1]) : 0,
										SalePrice = item.SalePrice,
										CompanyId = Common.Get_Session_Int(SessionKey.COMPANY_ID),
										BranchId = Common.Get_Session_Int(SessionKey.BRANCH_ID),
									});
								}
							}
							else
							{
								viewModel.listVariant.Add(new EC_Product_Variant()
								{
									Id = maxId,
									ProductId = viewModel.Id,
									AttributeId = item.AttributeValue.Contains("|") ? Convert.ToInt32(item.AttributeValue.Split('|')[0]) : 0,
									AttributeValueId = item.AttributeValue.Contains("|") ? Convert.ToInt32(item.AttributeValue.Split('|')[1]) : 0,
									SalePrice = item.SalePrice,
									CompanyId = Common.Get_Session_Int(SessionKey.COMPANY_ID),
									BranchId = Common.Get_Session_Int(SessionKey.BRANCH_ID)
								});
							}
						}


						var listVariant = _context.Variants.AsNoTracking().ToList()
								.Where(x => x.ProductId == viewModel.Id && x.CompanyId == Common.Get_Session_Int(SessionKey.COMPANY_ID)
									&& x.BranchId == Common.Get_Session_Int(SessionKey.BRANCH_ID)).ToList();

						if (listVariant != null && listVariant.Count() > 0)
							foreach (var varient in listVariant.ToList())
							{
								try
								{
									_context.Entry(varient).State = System.Data.Entity.EntityState.Deleted;
									_context.SaveChanges();
								}
								catch { continue; }
							}

						foreach (var id in viewModel.listVariant.Where(x => x.Id > -1).GroupBy(x => x.Id).Select(x => x.Key).ToList())
						{
							var maxVariantId = (_context.Variants.Where(x => x.VariantId > 0).OrderByDescending(x => x.VariantId).Select(x => x.VariantId).FirstOrDefault() + 1);

							foreach (var variant in viewModel.listVariant.Where(x => x.Id == id).ToList())
							{
								try
								{
									variant.VariantId = maxVariantId;

									_context.Variants.Add(variant);
									_context.SaveChanges();
									_context.Entry(variant).Reload();

									viewModel.listVariant[viewModel.listVariant.FindIndex(x => x.AttributeId == variant.AttributeId && x.AttributeValueId == variant.AttributeValueId)].VariantId = variant.VariantId;
								}
								catch { continue; }
							}

						}


						var listProduct_Dtls = _context.ProductDtls.AsNoTracking().ToList().Where(x => x.ProductId == viewModel.Id).ToList();


						if (listProduct_Dtls != null && listProduct_Dtls.Count() > 0)
							foreach (var p_dtls in listProduct_Dtls.Where(x => !viewModel.listVariant.Any(z => z.VariantId == x.VariantId)).ToList())
							{
								try
								{
									_context.Entry(p_dtls).State = System.Data.Entity.EntityState.Deleted;
									_context.SaveChanges();
								}
								catch { continue; }
							}

						foreach (var variant in viewModel.listVariant.Where(x => x.VariantId > 0).GroupBy(x => new { Id = x.VariantId, SalePrice = x.SalePrice }).ToList())
						{
							try
							{
								if (listProduct_Dtls != null && listProduct_Dtls.Any(x => x.VariantId == variant.Key.Id))
								{
									var old = listProduct_Dtls.Where(x => x.VariantId == variant.Key.Id).FirstOrDefault();

									old.SalePrice = variant.Key.SalePrice == 0 ? viewModel.MRP : variant.Key.SalePrice;

									_context.Entry(old).State = System.Data.Entity.EntityState.Modified;
									_context.SaveChanges();
								}
								else
								{
									var p_dtls = new EC_Product_Dtls();

									p_dtls.ProductId = viewModel.Id;
									p_dtls.SalePrice = variant.Key.SalePrice == 0 ? viewModel.MRP : variant.Key.SalePrice;
									p_dtls.VariantId = variant.Key.Id;

									_context.ProductDtls.Add(p_dtls);

									_context.SaveChanges();
								}
							}
							catch { continue; }
						}

						CommonViewModel.IsConfirm = true;
						CommonViewModel.IsSuccess = true;
						CommonViewModel.StatusCode = ResponseStatusCode.Success;
						CommonViewModel.Message = ResponseStatusMessage.Success;
						//CommonViewModel.RedirectURL = Url.Action("Index", "Product", new { area = "Admin" });
						CommonViewModel.Data1 = viewModel.Id;

						return Json(CommonViewModel);
					}
					catch (Exception ex) { }

					#endregion
				}
			}
			catch (Exception ex) { }

			CommonViewModel.Message = ResponseStatusMessage.Error;
			CommonViewModel.IsSuccess = false;
			CommonViewModel.StatusCode = ResponseStatusCode.Error;

			return Json(CommonViewModel);
		}

		[HttpPost]
		//[CustomAuthorizeAttribute(AccessType_Enum.Delete)]
		public ActionResult DeleteConfirmed(long Id)
		{
			try
			{
				if (_context.Product.AsNoTracking().Any(x => x.Id == Id))
				{
					var obj = _context.Product.AsNoTracking().Where(x => x.Id == Id).FirstOrDefault();

					_context.Entry(obj).State = System.Data.Entity.EntityState.Deleted;
					_context.SaveChanges();

					CommonViewModel.IsConfirm = true;
					CommonViewModel.IsSuccess = true;
					CommonViewModel.StatusCode = ResponseStatusCode.Success;
					CommonViewModel.Message = ResponseStatusMessage.Delete;

					CommonViewModel.RedirectURL = Url.Action("Index", "Product", new { area = "Admin" });

					return Json(CommonViewModel);
				}
			}
			catch (Exception ex) { }

			CommonViewModel.IsSuccess = false;
			CommonViewModel.StatusCode = ResponseStatusCode.Error;
			CommonViewModel.Message = ResponseStatusMessage.Unable_Delete;

			return Json(CommonViewModel);
		}


		private List<EC_Product> GetList()
		{
			List<EC_Product> list = _context.Product.AsNoTracking().ToList()
									.Where(x => x.CompanyId == Common.Get_Session_Int(SessionKey.COMPANY_ID)
										&& x.BranchId == Common.Get_Session_Int(SessionKey.BRANCH_ID)).ToList();
			return list;
		}


		private List<EC_Category> GetCategoryList()
		{
			List<EC_Category> list = _context.Category.AsNoTracking().ToList()
									.Where(x => x.CompanyId == Common.Get_Session_Int(SessionKey.COMPANY_ID)
										&& x.BranchId == Common.Get_Session_Int(SessionKey.BRANCH_ID)).ToList();
			return list;
		}

	}

}