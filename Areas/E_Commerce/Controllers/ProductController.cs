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
	public class ProductController : BaseController<ResponseModel<EC_Product>>
	{
		public ActionResult Index()
		{
			List<EC_Product> list = GetList();

			if (list != null)
				foreach (EC_Product obj in list)
					obj.CategoryName = GetCategoryList().Where(x => x.Id == obj.CategoryId).Select(x => x.Name).FirstOrDefault();

			CommonViewModel.ObjList = list;

			return View("~/Areas/E_Commerce/Views/Product/Index.cshtml", CommonViewModel);
		}

		//[CustomAuthorizeAttribute(AccessType_Enum.Read)]
		public ActionResult Partial_AddEditForm(long Id = 0)
		{
			CommonViewModel.Obj = new EC_Product();

			List<EC_Product> list = GetList();

			if (Id > 0)
				CommonViewModel.Obj = list.Where(x => x.Id == Id).FirstOrDefault();

			CommonViewModel.SelectListItems = GetCategoryList().Where(x => x.IsActive == true && x.IsDeleted == false)
				.Select(x => new SelectListItem_Custom(Convert.ToString(x.Id), Convert.ToString(x.Name))).ToList();

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
							obj.IsActive = viewModel.IsActive;

							obj.CompanyId = viewModel.CompanyId;
							obj.BranchId = viewModel.BranchId;

							_context.Entry(obj).State = System.Data.Entity.EntityState.Modified;
						}
						else if (Common.IsAdmin())
							_context.Product.Add(viewModel);

						_context.SaveChanges();

						CommonViewModel.IsConfirm = true;
						CommonViewModel.IsSuccess = true;
						CommonViewModel.StatusCode = ResponseStatusCode.Success;
						CommonViewModel.Message = ResponseStatusMessage.Success;
						CommonViewModel.RedirectURL = Url.Action("Index", "Product", new { area = "Admin" });

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