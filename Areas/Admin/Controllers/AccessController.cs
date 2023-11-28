using BaseStructure_47.Controllers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Policy;
using System.Web;
using System.Web.Mvc;

namespace BaseStructure_47.Areas.Admin.Controllers
{
	[RouteArea("Admin")]
	public class AccessController : BaseController<ResponseModel<UserMenuAccess>>
	{
		// GET: Admin/UserMenuAccess
		//[CustomAuthorizeAttribute(AccessType_Enum.Read)]
		public ActionResult Index()
		{
			CommonViewModel.ObjList = new List<UserMenuAccess>();
			CommonViewModel.SelectListItems = _context.Companies.AsNoTracking().ToList().OrderBy(x => x.Name).Select(x => new SelectListItem_Custom(x.Id.ToString(), x.Name)).Distinct().ToList();

			CommonViewModel.Data1 = _context.Roles.AsNoTracking().ToList().Where(x => x.Id > 1).OrderBy(x => x.DisplayOrder).Select(x => new SelectListItem_Custom(x.Id.ToString(), x.Name)).Distinct().ToList();

			return View(CommonViewModel);
		}

		[HttpPost]
		[AllowAnonymous]
		public JsonResult GetSelectList_Branch(long CompanyId = 0)
		{
			if (CompanyId > 0)
			{
				List<SelectListItem> list = (from x in _context.Branches.AsNoTracking().ToList()
											 where x.CompanyId == CompanyId
											 select new SelectListItem { Value = x.Id.ToString(), Text = x.Name }).Distinct().ToList();

				return Json(list);
			}

			return Json(new List<SelectListItem>());
		}

		[HttpPost]
		[AllowAnonymous]
		public JsonResult GetSelectList_User(long CompanyId = 0, long BranchId = 0, long RoleId = 0, bool IsActive = false)
		{
			if (CompanyId > 0 && BranchId == 0 && RoleId == 0)
			{
				List<SelectListItem> list = (from x in _context.UserRoleMappings.AsNoTracking().ToList()
											 join y in _context.Users.AsNoTracking().ToList() on x.UserId equals y.Id
											 where x.CompanyId == CompanyId && y.IsActive == IsActive && x.RoleId > 1
											 select new SelectListItem { Value = x.Id.ToString(), Text = y.UserName }).Distinct().ToList();

				return Json(list);
			}
			else if (CompanyId > 0 && BranchId > 0 && RoleId == 0)
			{
				List<SelectListItem> list = (from x in _context.UserRoleMappings.AsNoTracking().ToList()
											 join y in _context.Users.AsNoTracking().ToList() on x.UserId equals y.Id
											 where x.CompanyId == CompanyId && x.BranchId == BranchId && y.IsActive == IsActive && x.RoleId > 1
											 select new SelectListItem { Value = x.Id.ToString(), Text = y.UserName }).Distinct().ToList();

				return Json(list);
			}
			else if (CompanyId > 0 && BranchId > 0 && RoleId > 0)
			{
				List<SelectListItem> list = (from x in _context.UserRoleMappings.AsNoTracking().ToList()
											 join y in _context.Users.AsNoTracking().ToList() on x.UserId equals y.Id
											 where x.RoleId == RoleId && x.CompanyId == CompanyId && x.BranchId == BranchId && y.IsActive == IsActive && x.RoleId > 1
											 select new SelectListItem { Value = x.Id.ToString(), Text = y.UserName }).Distinct().ToList();

				return Json(list);
			}
			else if (CompanyId > 0 && BranchId == 0 && RoleId > 0)
			{
				List<SelectListItem> list = (from x in _context.UserRoleMappings.AsNoTracking().ToList()
											 join y in _context.Users.AsNoTracking().ToList() on x.UserId equals y.Id
											 where x.RoleId == RoleId && x.CompanyId == CompanyId && y.IsActive == IsActive && x.RoleId > 1
											 select new SelectListItem { Value = x.Id.ToString(), Text = y.UserName }).Distinct().ToList();

				return Json(list);
			}

			return Json(new List<SelectListItem>());
		}

		//[CustomAuthorizeAttribute(AccessType_Enum.Read)]
		public ActionResult Partial_AddEditForm(long CompanyId = 0, long BranchId = 0, long RoleId = 0, long UserId = 0)
		{
			CommonViewModel.IsSuccess = true;

			CommonViewModel.Obj = new UserMenuAccess() { CompanyId = CompanyId, BranchId = BranchId, RoleId = RoleId, UserId = UserId };
			CommonViewModel.ObjList = new List<UserMenuAccess>();

			var loggedUser_UserId = Common.LoggedUser_Id();

			var loggedUser_CompanyId = Common.Get_Session_Int(SessionKey.COMPANY_ID);
			var loggedUser_BranchId = Common.Get_Session_Int(SessionKey.BRANCH_ID);

			if (CompanyId == 0)
			{
				CommonViewModel.IsSuccess = false;
				CommonViewModel.StatusCode = ResponseStatusCode.Error;
				CommonViewModel.Message = "Please select Company.";

				return PartialView("_Partial_AddEditForm", CommonViewModel);
			}

			List<Branch> list = (from x in _context.Branches.AsNoTracking().ToList()
								 join y in _context.Users.AsNoTracking().ToList() on UserId equals y.Id
								 join z in _context.UserRoleMappings.AsNoTracking().ToList() on y.Id equals z.UserId
								 where x.Id == z.BranchId
								 select new Branch { Id = x.Id, Name = x.Name }).Distinct().ToList();

			if (list != null && list.Count() > 0 && BranchId == 0)
			{
				CommonViewModel.IsSuccess = false;
				CommonViewModel.StatusCode = ResponseStatusCode.Error;
				CommonViewModel.Message = "Please select Branch.";

				return PartialView("_Partial_AddEditForm", CommonViewModel);
			}

			if (RoleId == 0)
			{
				CommonViewModel.IsSuccess = false;
				CommonViewModel.StatusCode = ResponseStatusCode.Error;
				CommonViewModel.Message = "Please select Role.";

				return PartialView("_Partial_AddEditForm", CommonViewModel);
			}

			List<Role> listRole = (from x in _context.Roles.AsNoTracking().ToList()
								   join y in _context.Users.AsNoTracking().ToList() on UserId equals y.Id
								   join z in _context.UserRoleMappings.AsNoTracking().ToList() on y.Id equals z.UserId
								   where x.Id == z.RoleId
								   select new Role { Id = x.Id, Name = x.Name, IsAdmin = x.IsAdmin }).Distinct().ToList();

			if (listRole != null && listRole.Count() > 0 && RoleId == 0)
			{
				CommonViewModel.IsSuccess = false;
				CommonViewModel.StatusCode = ResponseStatusCode.Error;
				CommonViewModel.Message = "Please select Role.";

				return PartialView("_Partial_AddEditForm", CommonViewModel);
			}

			if (UserId == 0)
			{
				CommonViewModel.IsSuccess = false;
				CommonViewModel.StatusCode = ResponseStatusCode.Error;
				CommonViewModel.Message = "Please select User.";

				return PartialView("_Partial_AddEditForm", CommonViewModel);
			}

			if (UserId == loggedUser_UserId)
			{
				CommonViewModel.IsSuccess = false;
				CommonViewModel.StatusCode = ResponseStatusCode.Error;
				CommonViewModel.Message = "You do not change your own access. Please contact administrator.";

				return PartialView("_Partial_AddEditForm", CommonViewModel);
			}

			listRole = (from x in _context.Roles.AsNoTracking().ToList()
						join y in _context.Users.AsNoTracking().ToList() on UserId equals y.Id
						join z in _context.UserRoleMappings.AsNoTracking().ToList() on y.Id equals z.UserId
						where x.Id == RoleId
						select new Role { Id = x.Id, Name = x.Name, IsAdmin = x.IsAdmin }).Distinct().ToList();

			var listMenu = new List<Menu>();

			listMenu = _context.Menus.AsNoTracking().ToList().ToList();

			foreach (var item in listMenu.Where(x => x.ParentId > 0).ToList())
				item.ParentMenuName = listMenu.Where(x => x.Id == item.ParentId).Select(x => x.Name).FirstOrDefault();

			CommonViewModel.ObjList = (from x in listMenu.ToList()
									   select new UserMenuAccess()
									   {
										   MenuId = x.Id,
										   ParentMenuId = x.ParentId,
										   Area = x.Area,
										   Controller = x.Controller,
										   MenuName = x.Name,
										   ParentMenuName = x.ParentMenuName,
										   DisplayOrder = x.DisplayOrder,
										   IsActive = x.IsActive,
										   IsDeleted = x.IsDeleted
									   }).ToList();

			if (CompanyId > 0 && RoleId > 1 && UserId > 0)
			{
				//CommonViewModel.ObjList = (from x in _context.UserMenuAccess.AsNoTracking().ToList()
				//                         join y in _context.Menus.AsNoTracking().ToList() on x.MenuId equals y.Id
				//                         where x.UserId == UserId && x.RoleId == RoleId && x.CompanyId == CompanyId && x.BranchId == BranchId
				//                         select new UserMenuAccess() { MenuId = y.Id, ParentMenuId = y.ParentId, Area = y.Area, Controller = y.Controller, MenuName = y.Name, IsWrite = x.IsWrite, IsRead = x.IsRead, IsDelete = x.IsDelete, IsActive = y.IsActive, IsDeleted = y.IsDeleted }).ToList();

				foreach (var item in CommonViewModel.ObjList)
				{
					if (_context.UserMenuAccesses.AsNoTracking().ToList().Any(x => x.UserId == UserId && x.RoleId == RoleId && x.CompanyId == CompanyId && x.BranchId == BranchId && x.MenuId == item.MenuId && x.RoleId > 1))
					{
						var access = _context.UserMenuAccesses.AsNoTracking().ToList().Where(x => x.UserId == UserId && x.RoleId == RoleId && x.CompanyId == CompanyId && x.BranchId == BranchId && x.MenuId == item.MenuId && x.RoleId > 1).FirstOrDefault();

						item.IsCreate = access.IsCreate;
						item.IsUpdate = access.IsUpdate;
						item.IsRead = access.IsRead;
						item.IsDelete = access.IsDelete;
						item.IsActive = access.IsActive;
						item.IsDeleted = access.IsDeleted;
					}
				}
			}

			//CommonViewModel.Data1 = listMenu.Distinct().ToList();

			List<Role> loggedUser_Roles = (from x in _context.UserRoleMappings.AsNoTracking().ToList()
										   join y in _context.Roles.AsNoTracking().ToList() on (x.RoleId, x.IsActive, x.IsDeleted) equals (y.Id, true, false)
										   where x.UserId == loggedUser_UserId && x.CompanyId == loggedUser_CompanyId && x.BranchId == loggedUser_BranchId
										   && y.IsActive == true && y.IsDeleted == false && x.IsActive == true && x.IsDeleted == false
										   select y).ToList();

			if (loggedUser_Roles.Any(x => x.IsAdmin == true && x.Id != 1) && listRole.Any(x => x.Id != 1))
				((List<UserMenuAccess>)CommonViewModel.ObjList).RemoveAll(x => x.MenuName == "Menu" || x.ParentMenuName == "Menu");

			if (listRole.Any(x => x.IsAdmin != true))
				((List<UserMenuAccess>)CommonViewModel.ObjList).RemoveAll(x => x.MenuName == "Menu" || x.ParentMenuName == "Menu" || x.MenuId == 1 || x.ParentMenuId == 1);

			return PartialView("_Partial_AddEditForm", CommonViewModel);
		}

		[HttpPost]
		//[CustomAuthorizeAttribute(AccessType_Enum.Write)]
		public ActionResult Save(ResponseModel<UserMenuAccess> viewModel)
		{
			try
			{
				if (viewModel != null && viewModel.Obj != null)
				{
					if (viewModel.Obj.CompanyId == 0)
					{
						CommonViewModel.IsSuccess = false;
						CommonViewModel.StatusCode = ResponseStatusCode.Error;
						CommonViewModel.Message = "Please select Company.";

						return Json(CommonViewModel);
					}

					var listBranch = _context.Branches.AsNoTracking().ToList().Where(x => x.CompanyId == viewModel.Obj.CompanyId).ToList();

					if (viewModel.Obj.CompanyId > 0 && listBranch != null && listBranch.Count() > 0 && viewModel.Obj.BranchId == 0)
					{
						CommonViewModel.IsSuccess = false;
						CommonViewModel.StatusCode = ResponseStatusCode.Error;
						CommonViewModel.Message = "Please select Branch.";

						return Json(CommonViewModel);
					}

					if (viewModel.Obj.RoleId == 0)
					{
						CommonViewModel.IsSuccess = false;
						CommonViewModel.StatusCode = ResponseStatusCode.Error;
						CommonViewModel.Message = "Please select Role.";

						return Json(CommonViewModel);
					}

					if (viewModel.Obj.UserId == 0)
					{
						CommonViewModel.IsSuccess = false;
						CommonViewModel.StatusCode = ResponseStatusCode.Error;
						CommonViewModel.Message = "Please select User.";

						return Json(CommonViewModel);
					}


					var loggedUser_UserId = Common.LoggedUser_Id();

					var loggedUser_CompanyId = Common.Get_Session_Int(SessionKey.COMPANY_ID);
					var loggedUser_BranchId = Common.Get_Session_Int(SessionKey.BRANCH_ID);

					List<Role> roles = (from x in _context.UserRoleMappings.AsNoTracking().ToList()
										join y in _context.Roles.AsNoTracking().ToList() on (x.RoleId, x.IsActive, x.IsDeleted) equals (y.Id, true, false)
										where x.UserId == loggedUser_UserId && x.CompanyId == loggedUser_CompanyId && x.BranchId == loggedUser_BranchId
										&& y.IsActive == true && y.IsDeleted == false && x.IsActive == true && x.IsDeleted == false
										select y).ToList();

					if (roles == null || roles.Count == 0 || !roles.Any(x => x.IsAdmin == true))
					{
						CommonViewModel.IsSuccess = false;
						CommonViewModel.StatusCode = ResponseStatusCode.Error;
						CommonViewModel.Message = "You are not authorized to perform this action.";

						return Json(CommonViewModel);
					}

					var listParentMenu = new List<UserMenuAccess>();

					foreach (var parentMenuId in viewModel.ObjList.Where(x => x.ParentMenuId > 0).Select(x => x.ParentMenuId).Distinct().ToList())
					{
						var parentMenu = new UserMenuAccess()
						{
							MenuId = parentMenuId,
							IsCreate = viewModel.ObjList.Any(x => x.ParentMenuId == parentMenuId && x.IsCreate == true),
							IsUpdate = viewModel.ObjList.Any(x => x.ParentMenuId == parentMenuId && x.IsUpdate == true),
							IsRead = viewModel.ObjList.Any(x => x.ParentMenuId == parentMenuId && x.IsRead == true),
							IsDelete = viewModel.ObjList.Any(x => x.ParentMenuId == parentMenuId && x.IsDelete == true),
						};
						listParentMenu.Add(parentMenu);
					}
					if (listParentMenu != null && listParentMenu.Count > 0)
						viewModel.ObjList.AddRange(listParentMenu);

					List<UserMenuAccess> listUserMenuAccess = _context.UserMenuAccesses.AsNoTracking().ToList().Where(x => x.UserId == viewModel.Obj.UserId && x.CompanyId == viewModel.Obj.CompanyId && x.BranchId == viewModel.Obj.BranchId && x.RoleId == viewModel.Obj.RoleId).ToList();

					foreach (var menu in viewModel.ObjList.ToList())
					{
						try
						{
							var obj = listUserMenuAccess.Where(x => x.MenuId == menu.MenuId).FirstOrDefault();

							if (obj != null)
							{
								obj.CompanyId = viewModel.Obj.CompanyId;
								obj.BranchId = viewModel.Obj.BranchId;
								obj.UserId = viewModel.Obj.UserId;
								obj.RoleId = viewModel.Obj.RoleId;

								//obj.IsSetDefault = true;
								obj.IsActive = true;
								obj.IsCreate = menu.IsCreate;
								obj.IsUpdate = menu.IsUpdate;
								obj.IsRead = menu.IsRead;
								obj.IsDelete = menu.IsDelete;

								_context.Entry(obj).State = System.Data.Entity.EntityState.Modified;
								_context.SaveChanges();
							}
							else
							{
								menu.CompanyId = viewModel.Obj.CompanyId;
								menu.BranchId = viewModel.Obj.BranchId;
								menu.UserId = viewModel.Obj.UserId;
								menu.RoleId = viewModel.Obj.RoleId;

								//menu.IsSetDefault = true;
								menu.IsActive = true;

								_context.UserMenuAccesses.Add(menu);
								_context.SaveChanges();
							}
						}
						catch (Exception ex)
						{ continue; }
					}


					foreach (var menu in listUserMenuAccess.ToList())
					{
						try
						{
							var obj = viewModel.ObjList.ToList().Where(x => x.MenuId == menu.MenuId).FirstOrDefault();

							if (obj == null)
							{
								obj = new UserMenuAccess();

								obj.CompanyId = viewModel.Obj.CompanyId;
								obj.BranchId = viewModel.Obj.BranchId;
								obj.UserId = viewModel.Obj.UserId;
								obj.RoleId = viewModel.Obj.RoleId;

								//obj.IsSetDefault = true;
								obj.IsActive = true;

								obj.IsCreate = false;
								obj.IsUpdate = false;
								obj.IsRead = false;
								obj.IsDelete = false;

								_context.UserMenuAccesses.Add(obj);
								_context.SaveChanges();
							}
						}
						catch (Exception ex)
						{ continue; }
					}


					CommonViewModel.IsConfirm = true;
					CommonViewModel.IsSuccess = true;
					CommonViewModel.StatusCode = ResponseStatusCode.Success;
					CommonViewModel.Message = "Record saved successfully ! ";

					CommonViewModel.RedirectURL = Url.Action("Index", "Access", new { area = "Admin" }) + "/Index";

					return Json(CommonViewModel);
				}
			}
			catch (Exception ex)
			{ }

			CommonViewModel.IsSuccess = false;
			CommonViewModel.StatusCode = ResponseStatusCode.Error;
			CommonViewModel.Message = ResponseStatusMessage.Error;

			return Json(CommonViewModel);
		}

	}
}