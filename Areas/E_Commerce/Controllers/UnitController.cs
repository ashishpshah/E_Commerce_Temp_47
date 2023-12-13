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
	public class UnitController : BaseController<ResponseModel<EC_Unit>>
	{
		public ActionResult Index()
		{
			CommonViewModel.ObjList = GetList();

			return View("~/Areas/E_Commerce/Views/Unit/Index.cshtml", CommonViewModel);
		}

		//[CustomAuthorizeAttribute(AccessType_Enum.Read)]
		public ActionResult Partial_AddEditForm(long Id = 0)
		{
			CommonViewModel.Obj = new EC_Unit();

			if (Id > 0)
				CommonViewModel.Obj = GetList().Where(x => x.Id == Id).FirstOrDefault();

			if (CommonViewModel.Obj != null && !(CommonViewModel.Obj.Multiplier > 0))
				CommonViewModel.Obj.Multiplier = 1;

			return PartialView("~/Areas/E_Commerce/Views/Unit/_Partial_AddEditForm.cshtml", CommonViewModel);
		}

		[HttpPost]
		//[CustomAuthorizeAttribute(AccessType_Enum.Write)]
		public ActionResult Save(EC_Unit viewModel)
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
						CommonViewModel.Message = "Please enter Unit name.";

						return Json(CommonViewModel);
					}

					if (_context.Units.AsNoTracking().ToList().Any(x => x.Name.ToLower().Replace(" ", "") == viewModel.Name.ToLower().Replace(" ", "") && x.Id != viewModel.Id))
					{
						CommonViewModel.IsSuccess = false;
						CommonViewModel.StatusCode = ResponseStatusCode.Error;
						CommonViewModel.Message = "Unit already exist. Please try another Unit name.";

						return Json(CommonViewModel);
					}

					#endregion

					#region Database-Transaction

					try
					{

						EC_Unit obj = _context.Units.AsNoTracking().ToList().Where(x => x.Id == viewModel.Id).FirstOrDefault();

						//if (viewModel != null && !(viewModel.DisplayOrder > 0))
						//	viewModel.DisplayOrder = (_context.Companies.AsNoTracking().Max(x => x.DisplayOrder) ?? 0) + 1;

						if (viewModel != null && !(viewModel.Multiplier > 0))
							viewModel.Multiplier = 1;

						if (obj != null && Common.IsAdmin())
						{
							obj.Name = viewModel.Name;
							obj.Code = viewModel.Code;
							obj.Multiplier = viewModel.Multiplier;

							_context.Entry(obj).State = System.Data.Entity.EntityState.Modified;
						}
						else if (Common.IsAdmin())
							_context.Units.Add(viewModel);

						_context.SaveChanges();

						CommonViewModel.IsConfirm = true;
						CommonViewModel.IsSuccess = true;
						CommonViewModel.StatusCode = ResponseStatusCode.Success;
						CommonViewModel.Message = ResponseStatusMessage.Success;
						CommonViewModel.RedirectURL = Url.Action("Index", "Unit", new { area = "Admin" });

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
				if (_context.Units.AsNoTracking().Any(x => x.Id == Id))
				{
					var obj = _context.Units.AsNoTracking().Where(x => x.Id == Id).FirstOrDefault();

					_context.Entry(obj).State = System.Data.Entity.EntityState.Deleted;
					_context.SaveChanges();

					CommonViewModel.IsConfirm = true;
					CommonViewModel.IsSuccess = true;
					CommonViewModel.StatusCode = ResponseStatusCode.Success;
					CommonViewModel.Message = ResponseStatusMessage.Delete;

					CommonViewModel.RedirectURL = Url.Action("Index", "Unit", new { area = "Admin" });

					return Json(CommonViewModel);
				}
			}
			catch (Exception ex) { }

			CommonViewModel.IsSuccess = false;
			CommonViewModel.StatusCode = ResponseStatusCode.Error;
			CommonViewModel.Message = ResponseStatusMessage.Unable_Delete;

			return Json(CommonViewModel);
		}


		private List<EC_Unit> GetList()
		{
			List<EC_Unit> list = _context.Units.AsNoTracking().ToList();
			return list;
		}

	}

}