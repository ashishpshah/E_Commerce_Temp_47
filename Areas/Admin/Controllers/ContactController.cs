using BaseStructure_47.Controllers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace BaseStructure_47.Areas.Admin.Controllers
{
	[RouteArea("Admin")]
	public class ContactController : BaseController<ResponseModel<Contact>>
	{
		// GET: Admin/Contact
		public ActionResult Index()
		{
			CommonViewModel.ObjList = _context.Contacts.AsNoTracking().ToList();

			return View(CommonViewModel);
		}

		//[CustomAuthorizeAttribute(AccessType_Enum.Read)]
		public ActionResult Partial_AddEditForm(long Id = 0)
		{
			CommonViewModel.Obj = new Contact();

			if (Id > 0)
				CommonViewModel.Obj = _context.Contacts.AsNoTracking().Where(x => x.Id == Id).FirstOrDefault();

			return PartialView("_Partial_AddEditForm", CommonViewModel);
		}

		[ValidateInput(false)]
		[HttpPost]
		//[CustomAuthorizeAttribute(AccessType_Enum.Write)]
		public ActionResult Save(Contact viewModel)
		{
			try
			{
				if (viewModel != null && viewModel != null)
				{
					#region Validation

					if (string.IsNullOrEmpty(viewModel.Body))
					{
						CommonViewModel.IsSuccess = false;
						CommonViewModel.StatusCode = ResponseStatusCode.Error;
						CommonViewModel.Message = "Please enter Body data.";

						return Json(CommonViewModel);
					}

					#endregion

					#region Database-Transaction

					//using (var transaction = _context.Database.BeginTransaction())
					//{
					try
					{

						Contact obj = _context.Contacts.AsNoTracking().Where(x => x.Id == viewModel.Id).FirstOrDefault();

						if (viewModel != null && !(viewModel.DisplayOrder > 0))
							viewModel.DisplayOrder = (_context.Contacts.AsNoTracking().Max(x => x.DisplayOrder) ?? 0) + 1;

						if (obj != null)
						{
							obj.Header = viewModel.Header;
							obj.Body = viewModel.Body;
							obj.DisplayOrder = viewModel.DisplayOrder;
							obj.IsActive = viewModel.IsActive;

							_context.Entry(obj).State = System.Data.Entity.EntityState.Modified;
						}
						else
							_context.Contacts.Add(viewModel);

						_context.SaveChanges();

						CommonViewModel.IsConfirm = true;
						CommonViewModel.IsSuccess = true;
						CommonViewModel.StatusCode = ResponseStatusCode.Success;
						CommonViewModel.Message = ResponseStatusMessage.Success;
						CommonViewModel.RedirectURL = Url.Action("Index", "Contact", new { area = "Admin" });

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
				if (_context.Contacts.AsNoTracking().Any(x => x.Id == Id))
				{
					var obj = _context.Contacts.AsNoTracking().Where(x => x.Id == Id).FirstOrDefault();

					_context.Entry(obj).State = System.Data.Entity.EntityState.Deleted;
					_context.SaveChanges();

					CommonViewModel.IsConfirm = true;
					CommonViewModel.IsSuccess = true;
					CommonViewModel.StatusCode = ResponseStatusCode.Success;
					CommonViewModel.Message = ResponseStatusMessage.Delete;

					CommonViewModel.RedirectURL = Url.Action("Index", "Contact", new { area = "Admin" });

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