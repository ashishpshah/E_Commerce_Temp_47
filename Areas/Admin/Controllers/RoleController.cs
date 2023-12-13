using BaseStructure_47.Controllers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace BaseStructure_47.Areas.Admin.Controllers
{
	[RouteArea("Admin")]
	public class RoleController : BaseController<ResponseModel<Role>>
	{
		// GET: Admin/Role
		public ActionResult Index()
		{
			if (Common.IsSuperAdmin() && Common.IsAdmin())
				CommonViewModel.ObjList = _context.Roles.AsNoTracking().Where(x => x.Id > 1).ToList();

			return View(CommonViewModel);
		}

		//[CustomAuthorizeAttribute(AccessType_Enum.Read)]
		public ActionResult Partial_AddEditForm(long Id = 0)
		{
			CommonViewModel.Obj = new Role();

			if (Common.IsSuperAdmin() && Common.IsAdmin() && Id > 1)
				CommonViewModel.Obj = _context.Roles.AsNoTracking().Where(x => x.Id > 1 && x.Id == Id).FirstOrDefault();

			return PartialView("_Partial_AddEditForm", CommonViewModel);
		}

		[HttpPost]
		//[CustomAuthorizeAttribute(AccessType_Enum.Write)]
		public ActionResult Save(Role viewModel)
		{
			try
			{
				if (viewModel != null && viewModel != null)
				{
					#region Validation

					if (!Common.IsSuperAdmin() || !Common.IsAdmin())
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
						CommonViewModel.Message = "Please enter Role name.";

						return Json(CommonViewModel);
					}

					if (_context.Roles.AsNoTracking().Any(x => x.Name.ToLower().Replace(" ", "") == viewModel.Name.ToLower().Replace(" ", "") && x.Id != viewModel.Id) || viewModel.Id == 1)
					{
						CommonViewModel.IsSuccess = false;
						CommonViewModel.StatusCode = ResponseStatusCode.Error;
						CommonViewModel.Message = "Role already exist. Please try another Role.";

						return Json(CommonViewModel);
					}

					#endregion

					#region Database-Transaction

					//using (var transaction = _context.Database.BeginTransaction())
					//{
					try
					{

						Role obj = _context.Roles.AsNoTracking().Where(x => x.Id > 1 && x.Id == viewModel.Id).FirstOrDefault();

						if (viewModel != null && !(viewModel.DisplayOrder > 0))
							viewModel.DisplayOrder = (_context.Roles.AsNoTracking().Max(x => x.DisplayOrder) ?? 0) + 1;

						if (Common.IsSuperAdmin() && Common.IsAdmin() && obj != null)
						{
							obj.Name = viewModel.Name;
							obj.DisplayOrder = viewModel.DisplayOrder;
							obj.IsAdmin = Common.IsSuperAdmin() ? viewModel.IsAdmin : false;
							obj.IsActive = viewModel.IsActive;

							_context.Entry(obj).State = System.Data.Entity.EntityState.Modified;
							_context.SaveChanges();
						}
						else if (Common.IsSuperAdmin() && Common.IsAdmin())
						{
							viewModel.IsAdmin = Common.IsSuperAdmin() ? viewModel.IsAdmin : false;

							_context.Roles.Add(viewModel);
							_context.SaveChanges();
						}

						CommonViewModel.IsConfirm = true;
						CommonViewModel.IsSuccess = true;
						CommonViewModel.StatusCode = ResponseStatusCode.Success;
						CommonViewModel.Message = ResponseStatusMessage.Success;
						CommonViewModel.RedirectURL = Url.Action("Index", "Role", new { area = "Admin" });

						//transaction.Commit();

						return Json(CommonViewModel);
					}
					catch (Exception ex)
					{ /*transaction.Rollback();*/ }
					//}

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
				if (!Common.IsSuperAdmin() || !Common.IsAdmin())
				{
					CommonViewModel.IsSuccess = false;
					CommonViewModel.StatusCode = ResponseStatusCode.Error;
					CommonViewModel.Message = ResponseStatusMessage.UnAuthorize;

					return Json(CommonViewModel);
				}

				if (Common.IsSuperAdmin() && Common.IsAdmin() && !_context.UserRoleMappings.AsNoTracking().Any(x => x.Id > 1 && x.RoleId == Id)
					&& _context.Roles.AsNoTracking().Any(x => x.Id > 1 && x.Id == Id))
				{
					var obj = _context.Roles.AsNoTracking().Where(x => x.Id == Id).FirstOrDefault();

					_context.Entry(obj).State = System.Data.Entity.EntityState.Deleted;
					_context.SaveChanges();

					CommonViewModel.IsConfirm = true;
					CommonViewModel.IsSuccess = true;
					CommonViewModel.StatusCode = ResponseStatusCode.Success;
					CommonViewModel.Message = ResponseStatusMessage.Delete;

					CommonViewModel.RedirectURL = Url.Action("Index", "Role", new { area = "Admin" });

					return Json(CommonViewModel);
				}
			}
			catch (Exception ex)
			{ }

			CommonViewModel.IsSuccess = false;
			CommonViewModel.StatusCode = ResponseStatusCode.Error;
			CommonViewModel.Message = ResponseStatusMessage.Unable_Delete;

			return Json(CommonViewModel);
		}

	}
}