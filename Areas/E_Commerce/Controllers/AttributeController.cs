using BaseStructure_47.Controllers;
using BaseStructure_47;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Policy;
using System.Web;
using System.Web.Mvc;
using System.Web.WebPages;
using Microsoft.Ajax.Utilities;

namespace BaseStructure_47.Areas.E_Commerce.Controllers
{
	[RouteArea("Admin")]
	public class AttributeController : BaseController<ResponseModel<EC_Product_Attributes>>
	{
		public ActionResult Index()
		{
			List<EC_Product_Attributes> list = GetList();
			List<EC_Product_Attribute_Value> listVal = GetValueList();

			if (list != null)
				foreach (EC_Product_Attributes obj in list)
					obj.AttributeValue = string.Join(",", listVal.Where(x => x.AttributeId == obj.Id).Select(x => x.Value).ToArray());

			CommonViewModel.ObjList = list;

			return View("~/Areas/E_Commerce/Views/Attribute/Index.cshtml", CommonViewModel);
		}

		//[CustomAuthorizeAttribute(AccessType_Enum.Read)]
		public ActionResult Partial_AddEditForm(long Id = 0)
		{
			CommonViewModel.Obj = new EC_Product_Attributes();

			List<EC_Product_Attributes> list = GetList();

			if (Id > 0)
			{
				CommonViewModel.Obj = list.Where(x => x.Id == Id).FirstOrDefault();

				if (CommonViewModel.Obj != null)
					CommonViewModel.Obj.AttributeValue = string.Join(",", GetValueList(Id).Select(x => x.Value).ToArray());

			}

			return PartialView("~/Areas/E_Commerce/Views/Attribute/_Partial_AddEditForm.cshtml", CommonViewModel);
		}

		[HttpPost]
		//[CustomAuthorizeAttribute(AccessType_Enum.Write)]
		public ActionResult Save(EC_Product_Attributes viewModel)
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
						CommonViewModel.Message = "Please enter Attribute name.";

						return Json(CommonViewModel);
					}

					if (_context.Attributes.AsNoTracking().ToList().Any(x => x.Name.ToLower().Replace(" ", "") == viewModel.Name.ToLower().Replace(" ", "")
									&& x.Id != viewModel.Id && x.CompanyId == Common.Get_Session_Int(SessionKey.COMPANY_ID) && x.BranchId == Common.Get_Session_Int(SessionKey.BRANCH_ID)))
					{
						CommonViewModel.IsSuccess = false;
						CommonViewModel.StatusCode = ResponseStatusCode.Error;
						CommonViewModel.Message = "Attribute already exist. Please try another Attribute name.";

						return Json(CommonViewModel);
					}

					#endregion

					#region Database-Transaction

					try
					{
						viewModel.CompanyId = Common.Get_Session_Int(SessionKey.COMPANY_ID);
						viewModel.BranchId = Common.Get_Session_Int(SessionKey.BRANCH_ID);

						EC_Product_Attributes obj = _context.Attributes.AsNoTracking().ToList().Where(x => x.Id == viewModel.Id
									&& x.CompanyId == Common.Get_Session_Int(SessionKey.COMPANY_ID)
									&& x.BranchId == Common.Get_Session_Int(SessionKey.BRANCH_ID)).FirstOrDefault();

						//if (viewModel != null && !(viewModel.DisplayOrder > 0))
						//	viewModel.DisplayOrder = (_context.Companies.AsNoTracking().Max(x => x.DisplayOrder) ?? 0) + 1;

						if (obj != null && Common.IsAdmin())
						{
							obj.Name = viewModel.Name;
							obj.IsActive = viewModel.IsActive;

							obj.CompanyId = viewModel.CompanyId;
							obj.BranchId = viewModel.BranchId;

							_context.Entry(obj).State = System.Data.Entity.EntityState.Modified;
						}
						else if (Common.IsAdmin())
							_context.Attributes.Add(viewModel);

						_context.SaveChanges();

						try
						{
							var list = GetValueList(viewModel.Id).ToList();

							var attributeValues = string.IsNullOrEmpty(viewModel.AttributeValue) ? null : viewModel.AttributeValue.Split(',');

							if (attributeValues != null && attributeValues.Length > 0)
							{
								foreach (var val in attributeValues)
								{
									try
									{
										if (list != null && list.Any(x => x.Value.ToLower().Trim() == val.ToLower().Trim()))
										{
											var attributeValue = list.Where(x => x.Value.ToLower().Trim() == val.ToLower().Trim()).FirstOrDefault();

											attributeValue.Value = val.Trim();
											attributeValue.IsActive = true;
											attributeValue.CompanyId = viewModel.CompanyId;
											attributeValue.BranchId = viewModel.BranchId;

											_context.Entry(attributeValue).State = System.Data.Entity.EntityState.Modified;
										}
										else
										{
											EC_Product_Attribute_Value attributeValue = new EC_Product_Attribute_Value();

											attributeValue.Value = val.Trim();
											attributeValue.IsActive = true;
											attributeValue.AttributeId = viewModel.Id;
											attributeValue.CompanyId = viewModel.CompanyId;
											attributeValue.BranchId = viewModel.BranchId;

											_context.AttributeValues.Add(attributeValue);
										}

										_context.SaveChanges();
									}
									catch { continue; }
								}

								list = list.Where(x => !attributeValues.Any(y => y.ToLower().Trim() == x.Value.ToLower().Trim())).ToList();
							}


							if (list != null && list.Count > 0)
								foreach (var item in list)
								{
									try
									{
										_context.Entry(item).State = System.Data.Entity.EntityState.Deleted;
										_context.SaveChanges();
									}
									catch { continue; }
								}
						}
						catch (Exception ex) { }

						CommonViewModel.IsConfirm = true;
						CommonViewModel.IsSuccess = true;
						CommonViewModel.StatusCode = ResponseStatusCode.Success;
						CommonViewModel.Message = ResponseStatusMessage.Success;
						CommonViewModel.RedirectURL = Url.Action("Index", "Attribute", new { area = "Admin" });

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
				if (_context.Attributes.AsNoTracking().Any(x => x.Id == Id))
				{
					var obj = _context.Attributes.AsNoTracking().Where(x => x.Id == Id).FirstOrDefault();

					_context.Entry(obj).State = System.Data.Entity.EntityState.Deleted;
					_context.SaveChanges();

					CommonViewModel.IsConfirm = true;
					CommonViewModel.IsSuccess = true;
					CommonViewModel.StatusCode = ResponseStatusCode.Success;
					CommonViewModel.Message = ResponseStatusMessage.Delete;

					CommonViewModel.RedirectURL = Url.Action("Index", "Attribute", new { area = "Admin" });

					return Json(CommonViewModel);
				}
			}
			catch (Exception ex) { }

			CommonViewModel.IsSuccess = false;
			CommonViewModel.StatusCode = ResponseStatusCode.Error;
			CommonViewModel.Message = ResponseStatusMessage.Unable_Delete;

			return Json(CommonViewModel);
		}


		private List<EC_Product_Attributes> GetList()
		{
			List<EC_Product_Attributes> list = _context.Attributes.AsNoTracking().ToList()
									.Where(x => (x.CompanyId == 0 || x.CompanyId == Common.Get_Session_Int(SessionKey.COMPANY_ID))
										&& (x.BranchId == 0 || x.BranchId == Common.Get_Session_Int(SessionKey.BRANCH_ID))).ToList();
			return list;
		}


		private List<EC_Product_Attribute_Value> GetValueList(long Id = 0)
		{
			List<EC_Product_Attribute_Value> list = new List<EC_Product_Attribute_Value>();

			if (Id > 0)
				list = _context.AttributeValues.AsNoTracking().ToList()
									.Where(x => x.AttributeId == Id && x.CompanyId == Common.Get_Session_Int(SessionKey.COMPANY_ID)
										&& x.BranchId == Common.Get_Session_Int(SessionKey.BRANCH_ID)).ToList();
			else
				list = _context.AttributeValues.AsNoTracking().ToList()
									.Where(x => x.CompanyId == Common.Get_Session_Int(SessionKey.COMPANY_ID)
										&& x.BranchId == Common.Get_Session_Int(SessionKey.BRANCH_ID)).ToList();

			return list;
		}

	}

}