﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Web.Mvc;


namespace BaseStructure_47.Controllers
{
	public class HomeController : BaseController<ResponseModel<LoginViewModel>>
	{
		public ActionResult Index()
		{
			try
			{
				//var list = _context.Companies.ToList();

				//if (list == null || list.Count == 0)
				//{
				//	var company = new Company() { Name = "VK Jewellers", CreatedBy = 1 };
				//	_context.Companies.Add(company);
				//	_context.SaveChanges();
				//	_context.Entry(company).Reload();

				//	var branch = new Branch() { Name = "Branch 1", CreatedBy = 1 };
				//	//_context.Branches.Add(branch);
				//	//_context.SaveChanges();
				//	//_context.Entry(branch).Reload();

				//	var user = new User() { UserName = "Adnin", Password = Common.Encrypt("admin123"), CreatedBy = 1 };
				//	_context.Users.Add(user);
				//	_context.SaveChanges();
				//	_context.Entry(user).Reload();

				//	var role = new Role() { Name = "Super Admin", IsAdmin = true, CreatedBy = 1 };
				//	_context.Roles.Add(role);
				//	_context.SaveChanges();

				//	var userRole = new UserRoleMapping() { UserId = user.Id, RoleId = role.Id, CompanyId = company.Id, BranchId = branch.Id, CreatedBy = 1 };
				//	_context.UserRoleMappings.Add(userRole);
				//	_context.SaveChanges();

				//	user = new User() { UserName = "Admin", Password = Common.Encrypt("admin"), CreatedBy = 1 };
				//	_context.Users.Add(user);
				//	_context.SaveChanges();
				//	_context.Entry(user).Reload();

				//	role = new Role() { Name = "Admin", IsAdmin = true, CreatedBy = 1 };
				//	_context.Roles.Add(role);
				//	_context.SaveChanges();
				//	_context.Entry(role).Reload();

				//	userRole = new UserRoleMapping() { UserId = user.Id, RoleId = role.Id, CompanyId = company.Id, BranchId = branch.Id, CreatedBy = 1 };
				//	_context.UserRoleMappings.Add(userRole);
				//	_context.SaveChanges();

				//	var menu = new Menu() { ParentId = 0, Area = "", Controller = "", Name = "Company Master", DisplayOrder = 1, CreatedBy = 1 };
				//	_context.Menus.Add(menu);
				//	_context.SaveChanges();
				//	_context.Entry(menu).Reload();

				//	var userMenuAccess = new UserMenuAccess() { UserId = user.Id, RoleId = role.Id, CompanyId = company.Id, BranchId = branch.Id, MenuId = menu.Id, IsCreate = true, IsUpdate = true, IsRead = true, IsDelete = true, CreatedBy = 1 };
				//	_context.UserMenuAccesses.Add(userMenuAccess);
				//	_context.SaveChanges();

				//	List<Menu> listMenu_Child = new List<Menu>()
				//	{
				//		new Menu(){ ParentId = menu.Id, Area="Admin", Controller="Company", Name="Company", DisplayOrder = 1, CreatedBy = 1},
				//		new Menu(){ ParentId = menu.Id, Area="Admin", Controller="Branch", Name="Branch", DisplayOrder = 2, CreatedBy = 1},
				//		new Menu(){ ParentId = menu.Id, Area="Admin", Controller="User", Name="User", DisplayOrder = 3, CreatedBy = 1},
				//		new Menu(){ ParentId = menu.Id, Area="Admin", Controller="Role", Name="Role", DisplayOrder = 4, CreatedBy = 1},
				//		new Menu(){ ParentId = menu.Id, Area="Admin", Controller="Access", Name="User Access", DisplayOrder = 5, CreatedBy = 1},
				//		new Menu(){ ParentId = menu.Id, Area="Admin", Controller="Menu", Name="Menu", DisplayOrder = 6, CreatedBy = 1},
				//		new Menu(){ ParentId = 0, Area="", Controller="Employee", Name="Employee", DisplayOrder = 2, CreatedBy = 1},
				//		new Menu(){ ParentId = 0, Area="", Controller="Contact", Name="Contact Us", DisplayOrder = 3, CreatedBy = 1},
				//		new Menu(){ ParentId = 0, Area="", Controller="About", Name="About Us", DisplayOrder = 4, CreatedBy = 1}
				//	};

				//	foreach (var item in listMenu_Child)
				//	{
				//		_context.Menus.Add(item);
				//		_context.SaveChanges();
				//		_context.Entry(item).Reload();
				//	}

				//	foreach (var item in listMenu_Child.OrderBy(x => x.ParentId).ThenBy(x => x.Id).ToList())
				//	{
				//		var roleMenuAccess = new RoleMenuAccess() { RoleId = role.Id, MenuId = item.Id, IsCreate = true, IsUpdate = true, IsRead = true, IsDelete = true, CreatedBy = 1 };
				//		_context.RoleMenuAccesses.Add(roleMenuAccess);
				//		_context.SaveChanges();
				//	}

				//	foreach (var item in listMenu_Child.OrderBy(x => x.ParentId).ThenBy(x => x.Id).ToList())
				//	{
				//		userMenuAccess = new UserMenuAccess() { UserId = user.Id, RoleId = role.Id, CompanyId = company.Id, BranchId = branch.Id, MenuId = item.Id, IsCreate = true, IsUpdate = true, IsRead = true, IsDelete = true, CreatedBy = 1 };
				//		_context.UserMenuAccesses.Add(userMenuAccess);
				//		_context.SaveChanges();
				//	}
				//}

				if (Common.LoggedUser_Id() == 0)
					return RedirectToAction("Login", "Home", new { Area = "" });
				//else if (Common.IsAdmin())
				//{
				//	Common.Clear_Session();
				//	return RedirectToAction("Login", "Home", new { Area = "" });
				//}

			}
			catch (Exception ex)
			{
				LogEntry.InsertLogEntry(ex);
				return null;
			}

			return View();
		}

		public ActionResult About()
		{
			ViewBag.Message = "Your application description page.";

			return View();
		}

		public ActionResult Contact()
		{
			ViewBag.Message = "Your contact page.";

			return View();
		}

		public ActionResult Login()
		{
			Common.Clear_Session();

			return View();
		}


		[HttpPost]
		//[ValidateAntiForgeryToken]
		public JsonResult Login(LoginViewModel viewModel)
		{
			try
			{
				if (!string.IsNullOrEmpty(viewModel.UserName) && viewModel.UserName.Length > 0 && _context.Users.AsNoTracking().Any(x => x.UserName == viewModel.UserName))
				{
					viewModel.Password = Common.Encrypt(viewModel.Password);

					var obj = _context.Users.AsNoTracking().Where(x => x.UserName == viewModel.UserName && x.Password == viewModel.Password).FirstOrDefault();

					if (obj != null && obj.IsActive == true && obj.IsDeleted == false)
					{
						var userRoles = _context.UserRoleMappings.AsNoTracking().Where(x => x.UserId == obj.Id).ToList();

						if (userRoles != null && userRoles.Any(x => x.CompanyId == viewModel.CompanyId && x.BranchId == viewModel.BranchId))
						{
							obj.CompanyId = viewModel.CompanyId;
							obj.BranchId = viewModel.BranchId;
							obj.RoleId = userRoles.Select(x => x.RoleId).FirstOrDefault();
						}
						else if (userRoles != null && !userRoles.Any(x => x.CompanyId == viewModel.CompanyId && x.BranchId == viewModel.BranchId) && userRoles.Count() == 1)
						{
							obj.CompanyId = userRoles.Select(x => x.CompanyId).FirstOrDefault();
							obj.BranchId = userRoles.Select(x => x.BranchId).FirstOrDefault();
							obj.RoleId = userRoles.Select(x => x.RoleId).FirstOrDefault();
						}
						else{

							CommonViewModel.IsSuccess = false;
							CommonViewModel.StatusCode = ResponseStatusCode.Error;
							CommonViewModel.Message = "Please select valid Company or Branch";

							return Json(CommonViewModel);
						}

						List<UserMenuAccess> listMenuAccess = new List<UserMenuAccess>();
						List<UserMenuAccess> listMenuPermission = new List<UserMenuAccess>();

						Role role = _context.Roles.AsNoTracking().Where(x => x.Id == obj.RoleId).FirstOrDefault();

						if (role != null && role.Id == 1)
						{
							listMenuAccess = (from y in _context.Menus.AsNoTracking().ToList()
											  where y.IsActive == true && y.IsDeleted == false
											  select new UserMenuAccess() { Id = y.Id, ParentMenuId = y.ParentId, Area = y.Area, Controller = y.Controller, MenuName = y.Name, IsCreate = true, IsUpdate = true, IsRead = true, IsDelete = true, DisplayOrder = y.DisplayOrder, IsActive = y.IsActive, IsDeleted = y.IsDeleted }).ToList();
						}
						else if (role != null && role.IsAdmin)
						{

							listMenuAccess = (from x in _context.UserMenuAccesses.AsNoTracking().ToList()
											  join y in _context.Menus.AsNoTracking().ToList() on x.MenuId equals y.Id
											  where x.UserId == obj.Id && x.CompanyId == obj.CompanyId && x.BranchId == obj.BranchId && x.RoleId == obj.RoleId
											  && y.IsActive == true && y.IsDeleted == false && x.IsActive == true && x.IsDeleted == false && y.Name != "Menu"
											  && x.IsRead == true
											  select new UserMenuAccess() { Id = y.Id, ParentMenuId = y.ParentId, Area = y.Area, Controller = y.Controller, MenuName = y.Name, DisplayOrder = y.DisplayOrder, IsActive = x.IsActive, IsDeleted = x.IsDeleted }).ToList();
						}
						else if (role != null && !role.IsAdmin && role.IsActive && !role.IsDeleted)
						{
							listMenuAccess = (from x in _context.UserMenuAccesses.AsNoTracking().ToList()
											  join y in _context.Menus.AsNoTracking().ToList() on x.MenuId equals y.Id
											  where x.UserId == obj.Id && x.CompanyId == obj.CompanyId && x.BranchId == obj.BranchId && x.RoleId == obj.RoleId
											  && y.IsActive == true && y.IsDeleted == false && x.IsActive == true && x.IsDeleted == false && y.Id != 1 && y.ParentId != 1 && y.Name != "Menu"
											  && x.IsRead == true
											  select new UserMenuAccess() { Id = y.Id, ParentMenuId = y.ParentId, Area = y.Area, Controller = y.Controller, MenuName = y.Name, DisplayOrder = y.DisplayOrder, IsActive = x.IsActive, IsDeleted = x.IsDeleted }).ToList();
						}

						if (role != null && role.Id == 1)
							listMenuPermission = listMenuAccess;
						else
							listMenuPermission = (from x in _context.UserMenuAccesses.AsNoTracking().ToList()
												  join y in _context.Menus.AsNoTracking().ToList() on x.MenuId equals y.Id
												  where x.UserId == obj.Id && x.CompanyId == obj.CompanyId && x.BranchId == obj.BranchId && y.IsActive == true && y.IsDeleted == false && x.IsActive == true && x.IsDeleted == false
												  && listMenuAccess.Any(z => z.Id == y.Id)
												  select new UserMenuAccess() { MenuId = y.Id, ParentMenuId = y.ParentId, Area = y.Area, Controller = y.Controller, MenuName = y.Name, IsCreate = x.IsCreate, IsUpdate = x.IsUpdate, IsRead = x.IsRead, IsDelete = x.IsDelete, IsActive = x.IsActive, IsDeleted = x.IsDeleted }).ToList();

						Common.Configure_UserMenuAccess(listMenuAccess.Where(x => x.IsActive == true && x.IsDeleted == false).ToList(), listMenuPermission.Where(x => x.IsActive == true && x.IsDeleted == false).ToList());

						Common.Set_Session_Int(SessionKey.USER_ID, obj.Id);
						Common.Set_Session_Int(SessionKey.ROLE_ID, obj.RoleId);
						Common.Set_Session_Int(SessionKey.COMPANY_ID, obj.CompanyId);
						Common.Set_Session_Int(SessionKey.BRANCH_ID, obj.BranchId);

						Common.Set_Session(SessionKey.USER_NAME, obj.UserName);
						Common.Set_Session(SessionKey.ROLE_NAME, role.Name);
						Common.Set_Session_Int(SessionKey.ROLE_ADMIN, (role.IsAdmin ? 1 : 0));
						Common.Set_Session_Int(SessionKey.IS_SUPER_USER_KEY, (obj.RoleId == 1 ? 1 : 0));


						CommonViewModel.IsSuccess = true;
						CommonViewModel.StatusCode = ResponseStatusCode.Success;
						CommonViewModel.Message = ResponseStatusMessage.Success;

						CommonViewModel.RedirectURL = Url.Content("~/") + this.ControllerContext.RouteData.Values["Controller"].ToString() + "/Index";

						return Json(CommonViewModel);
					}
				}

				CommonViewModel.IsSuccess = false;
				CommonViewModel.StatusCode = ResponseStatusCode.Error;
				CommonViewModel.Message = "User Id and Password does not Match";

			}
			catch (Exception ex)
			{
				CommonViewModel.IsSuccess = false;
				CommonViewModel.StatusCode = ResponseStatusCode.Error;
				CommonViewModel.Message = ResponseStatusMessage.Error + " | " + ex.Message;
			}

			return Json(CommonViewModel);
		}


		[HttpPost]
		[AllowAnonymous]
		public JsonResult GetCompany(string UserName = null)
		{
			if (!string.IsNullOrEmpty(UserName))
			{
				var obj = _context.Users.AsNoTracking().Where(x => x.UserName == UserName).FirstOrDefault();

				List<UserRoleMapping> userRole = obj != null ? _context.UserRoleMappings.AsNoTracking().Where(x => x.UserId == obj.Id).ToList() : null;

				List<SelectListItem> list = userRole != null ? (from x in _context.Companies.AsNoTracking().ToList()
																join y in userRole on x.Id equals y.CompanyId
																where x.IsActive == true
																select new SelectListItem { Value = x.Id.ToString(), Text = x.Name }).Distinct().ToList() : null;

				if (list != null && list.Count() > 0)
					return Json(list);
			}

			return Json(new List<SelectListItem>());
		}


		[HttpPost]
		[AllowAnonymous]
		public JsonResult GetBranch(long CompanyId = 0, string UserName = null)
		{
			if (CompanyId > 0)
			{
				List<UserRoleMapping> userRole = null;

				if (!string.IsNullOrEmpty(UserName))
				{
					var obj = _context.Users.AsNoTracking().Where(x => x.UserName == UserName).FirstOrDefault();

					userRole = obj != null ? _context.UserRoleMappings.AsNoTracking().Where(x => x.UserId == obj.Id).ToList() : null;
				}

				List<SelectListItem> list = userRole != null ? (from x in _context.Branches.AsNoTracking().ToList()
																join y in userRole on x.Id equals y.BranchId
																where x.IsActive == true && x.CompanyId == CompanyId
																select new SelectListItem { Value = x.Id.ToString(), Text = x.Name }).Distinct().ToList() : null;

				if (list != null && list.Count() > 0)
					return Json(list);
			}

			return Json(new List<SelectListItem>());
		}


		public ActionResult Logout()
		{
			Common.Clear_Session();

			return RedirectToAction("Login", "Home", new { Area = "" });
		}

	}
}