using BaseStructure_47.Controllers;
using BaseStructure_47;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Policy;
using System.Web;
using System.Web.Mvc;

namespace BaseStructure_47.Areas.E_Commerce.Controllers
{
	[RouteArea("Admin")]
	public class TagsController : BaseController<ResponseModel<EC_Tags>>
	{
		public ActionResult Index()
		{
			List<EC_Tags> list = GetList();

			CommonViewModel.ObjList = list;

			return View("~/Areas/E_Commerce/Views/Tags/Index.cshtml", CommonViewModel);
		}

		//[CustomAuthorizeAttribute(AccessType_Enum.Read)]
		public ActionResult Partial_AddEditForm(long Id = 0)
		{
			var obj = new EC_Tags();

			List<EC_Tags> list = GetList();

			if (Id > 0)
				obj = list.Where(x => x.Id == Id).FirstOrDefault();

			var listCategory = GetCategoryList().Where(x => x.IsActive == true && x.IsDeleted == false)
				.Select(x => new SelectListItem_Custom(Convert.ToString(x.Id), Convert.ToString(x.Name), "C")).ToList();

			var listProduct = GetProductList().Where(x => x.IsActive == true && x.IsDeleted == false)
				.Select(x => new SelectListItem_Custom(Convert.ToString(x.Id), Convert.ToString(x.Name), "P")).ToList();

			CommonViewModel.SelectListItems = new List<SelectListItem_Custom>();

			if (listCategory != null && listCategory.Count > 0)
				CommonViewModel.SelectListItems.AddRange(listCategory);

			if (listProduct != null && listProduct.Count > 0)
				CommonViewModel.SelectListItems.AddRange(listProduct);

			CommonViewModel.Obj = obj;


			return PartialView("~/Areas/E_Commerce/Views/Tags/_Partial_AddEditForm.cshtml", CommonViewModel);
		}

		[HttpPost]
		//[CustomAuthorizeAttribute(AccessType_Enum.Write)]
		public ActionResult Save(EC_Tags viewModel)
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
						CommonViewModel.Message = "Please enter Tags name.";

						return Json(CommonViewModel);
					}

					if (_context.Tags.AsNoTracking().ToList().Any(x => x.Name.ToLower().Replace(" ", "") == viewModel.Name.ToLower().Replace(" ", "")
									&& x.Id != viewModel.Id
									&& x.CompanyId == Common.Get_Session_Int(SessionKey.COMPANY_ID)
									&& x.BranchId == Common.Get_Session_Int(SessionKey.BRANCH_ID)))
					{
						CommonViewModel.IsSuccess = false;
						CommonViewModel.StatusCode = ResponseStatusCode.Error;
						CommonViewModel.Message = "Tag name already exist. Please try another Tag name.";

						return Json(CommonViewModel);
					}

					#endregion

					#region Database-Transaction

					try
					{

						viewModel.CompanyId = Common.Get_Session_Int(SessionKey.COMPANY_ID);
						viewModel.BranchId = Common.Get_Session_Int(SessionKey.BRANCH_ID);

						EC_Tags obj = _context.Tags.AsNoTracking().ToList().Where(x => x.Id == viewModel.Id
									&& x.CompanyId == Common.Get_Session_Int(SessionKey.COMPANY_ID)
									&& x.BranchId == Common.Get_Session_Int(SessionKey.BRANCH_ID)).FirstOrDefault();

						//if (viewModel != null && !(viewModel.DisplayOrder > 0))
						//	viewModel.DisplayOrder = (_context.Companies.AsNoTracking().Max(x => x.DisplayOrder) ?? 0) + 1;

						if (obj != null && Common.IsAdmin())
						{
							obj.Name = viewModel.Name;
							obj.Desc = viewModel.Desc;
							obj.Products = viewModel.Products;
							obj.Categories = viewModel.Categories;
							obj.IsActive = viewModel.IsActive;

							obj.CompanyId = viewModel.CompanyId;
							obj.BranchId = viewModel.BranchId;

							_context.Entry(obj).State = System.Data.Entity.EntityState.Modified;
						}
						else if (Common.IsAdmin())
							_context.Tags.Add(viewModel);

						_context.SaveChanges();

						CommonViewModel.IsConfirm = true;
						CommonViewModel.IsSuccess = true;
						CommonViewModel.StatusCode = ResponseStatusCode.Success;
						CommonViewModel.Message = ResponseStatusMessage.Success;
						CommonViewModel.RedirectURL = Url.Action("Index", "Tags", new { area = "Admin" });

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
				if (_context.Tags.AsNoTracking().Any(x => x.Id == Id))
				{
					var obj = _context.Tags.AsNoTracking().Where(x => x.Id == Id).FirstOrDefault();

					_context.Entry(obj).State = System.Data.Entity.EntityState.Deleted;
					_context.SaveChanges();

					CommonViewModel.IsConfirm = true;
					CommonViewModel.IsSuccess = true;
					CommonViewModel.StatusCode = ResponseStatusCode.Success;
					CommonViewModel.Message = ResponseStatusMessage.Delete;

					CommonViewModel.RedirectURL = Url.Action("Index", "Tags", new { area = "Admin" });

					return Json(CommonViewModel);
				}
			}
			catch (Exception ex) { }

			CommonViewModel.IsSuccess = false;
			CommonViewModel.StatusCode = ResponseStatusCode.Error;
			CommonViewModel.Message = ResponseStatusMessage.Unable_Delete;

			return Json(CommonViewModel);
		}


		private List<EC_Tags> GetList()
		{
			List<EC_Tags> list = _context.Tags.AsNoTracking().ToList()
									.Where(x => x.CompanyId == Common.Get_Session_Int(SessionKey.COMPANY_ID)
										&& x.BranchId == Common.Get_Session_Int(SessionKey.BRANCH_ID)).ToList();
			return list;
		}


		private List<EC_Product> GetProductList()
		{
			List<EC_Product> list = _context.Product.AsNoTracking().ToList().Where(x => x.IsActive == true)
									.Where(x => x.CompanyId == Common.Get_Session_Int(SessionKey.COMPANY_ID)
										&& x.BranchId == Common.Get_Session_Int(SessionKey.BRANCH_ID)).ToList();

			List<EC_Category> listCategory = GetCategoryList();

			foreach (var item in list.OrderBy(x => x.Id).ToList())
			{
				if (item.CategoryId > 0)
					item.CategoryName = listCategory.Where(x => x.Id == item.CategoryId).Select(x => x.Name).FirstOrDefault();

				if (item.CategoryId > 0)
					item.Name = item.Name + " ( " + item.CategoryName.Trim() + " ) ";
			}

			return list;
		}


		private List<EC_Category> GetCategoryList()
		{
			List<EC_Category> list = _context.Category.AsNoTracking().ToList().Where(x => x.IsActive == true)
									.Where(x => x.CompanyId == Common.Get_Session_Int(SessionKey.COMPANY_ID)
										&& x.BranchId == Common.Get_Session_Int(SessionKey.BRANCH_ID)).ToList();

			foreach (var item in list.OrderBy(x => x.Id).ThenBy(x => x.ParentId).ToList())
			{
				if (item.ParentId > 0)
					item.ParentCategoryName = list.Where(x => x.Id == item.ParentId).Select(x => x.Name).FirstOrDefault();

				if (item.ParentId > 0)
					item.Name = item.ParentCategoryName.Trim() + " > " + item.Name;
			}

			return list.Where(x => x.IsActive == true).ToList();
		}

	}

}