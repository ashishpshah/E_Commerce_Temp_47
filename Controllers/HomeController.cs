using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web.Mvc;


namespace BaseStructure_47.Controllers
{
	public class HomeController : BaseController<ResponseModel<LoginViewModel>>
	{
		public ActionResult Index()
		{
			try
			{
				var list = _context.Companies.ToList();

				if (list == null || list.Count == 0)
				{
					var company = new Company() { Name = "VK Jewellers", CreatedBy = 1 };
					_context.Companies.Add(company);
					_context.SaveChanges();
					_context.Entry(company).Reload();

					var branch = new Branch() { Name = "Branch 1", CreatedBy = 1 };
					//_context.Branches.Add(branch);
					//_context.SaveChanges();
					//_context.Entry(branch).Reload();

					var user = new User() { UserName = "Adnin", Password = Common.Encrypt("admin123"), CreatedBy = 1 };
					_context.Users.Add(user);
					_context.SaveChanges();
					_context.Entry(user).Reload();

					var role = new Role() { Name = "Super Admin", IsAdmin = true, CreatedBy = 1 };
					_context.Roles.Add(role);
					_context.SaveChanges();

					var userRole = new UserRoleMapping() { UserId = user.Id, RoleId = role.Id, CompanyId = company.Id, BranchId = branch.Id, CreatedBy = 1 };
					_context.UserRoleMappings.Add(userRole);
					_context.SaveChanges();

					user = new User() { UserName = "Admin", Password = Common.Encrypt("admin"), CreatedBy = 1 };
					_context.Users.Add(user);
					_context.SaveChanges();
					_context.Entry(user).Reload();

					role = new Role() { Name = "Admin", IsAdmin = true, CreatedBy = 1 };
					_context.Roles.Add(role);
					_context.SaveChanges();
					_context.Entry(role).Reload();

					userRole = new UserRoleMapping() { UserId = user.Id, RoleId = role.Id, CompanyId = company.Id, BranchId = branch.Id, CreatedBy = 1 };
					_context.UserRoleMappings.Add(userRole);
					_context.SaveChanges();

					var menu = new Menu() { ParentId = 0, Area = "", Controller = "", Name = "Company Master", DisplayOrder = 1, CreatedBy = 1 };
					_context.Menus.Add(menu);
					_context.SaveChanges();
					_context.Entry(menu).Reload();

					var userMenuAccess = new UserMenuAccess() { UserId = user.Id, RoleId = role.Id, CompanyId = company.Id, BranchId = branch.Id, MenuId = menu.Id, IsCreate = true, IsUpdate = true, IsRead = true, IsDelete = true, CreatedBy = 1 };
					_context.UserMenuAccesses.Add(userMenuAccess);
					_context.SaveChanges();

					List<Menu> listMenu_Child = new List<Menu>()
					{
						new Menu(){ ParentId = menu.Id, Area="Admin", Controller="Company", Name="Company", DisplayOrder = 1, CreatedBy = 1},
						new Menu(){ ParentId = menu.Id, Area="Admin", Controller="Branch", Name="Branch", DisplayOrder = 2, CreatedBy = 1},
						new Menu(){ ParentId = menu.Id, Area="Admin", Controller="User", Name="User", DisplayOrder = 3, CreatedBy = 1},
						new Menu(){ ParentId = menu.Id, Area="Admin", Controller="Role", Name="Role", DisplayOrder = 4, CreatedBy = 1},
						new Menu(){ ParentId = menu.Id, Area="Admin", Controller="Access", Name="User Access", DisplayOrder = 5, CreatedBy = 1},
						new Menu(){ ParentId = menu.Id, Area="Admin", Controller="Menu", Name="Menu", DisplayOrder = 6, CreatedBy = 1},
						new Menu(){ ParentId = 0, Area="", Controller="Employee", Name="Employee", DisplayOrder = 2, CreatedBy = 1},
						new Menu(){ ParentId = 0, Area="", Controller="Contact", Name="Contact Us", DisplayOrder = 3, CreatedBy = 1},
						new Menu(){ ParentId = 0, Area="", Controller="About", Name="About Us", DisplayOrder = 4, CreatedBy = 1}
					};

					foreach (var item in listMenu_Child)
					{
						_context.Menus.Add(item);
						_context.SaveChanges();
						_context.Entry(item).Reload();
					}

					foreach (var item in listMenu_Child.OrderBy(x => x.ParentId).ThenBy(x => x.Id).ToList())
					{
						var roleMenuAccess = new RoleMenuAccess() { RoleId = role.Id, MenuId = item.Id, IsCreate = true, IsUpdate = true, IsRead = true, IsDelete = true, CreatedBy = 1 };
						_context.RoleMenuAccesses.Add(roleMenuAccess);
						_context.SaveChanges();
					}

					foreach (var item in listMenu_Child.OrderBy(x => x.ParentId).ThenBy(x => x.Id).ToList())
					{
						userMenuAccess = new UserMenuAccess() { UserId = user.Id, RoleId = role.Id, CompanyId = company.Id, BranchId = branch.Id, MenuId = item.Id, IsCreate = true, IsUpdate = true, IsRead = true, IsDelete = true, CreatedBy = 1 };
						_context.UserMenuAccesses.Add(userMenuAccess);
						_context.SaveChanges();
					}
				}

				//if (HttpContext.Session[SessionKey.USER_ID] == null)
				if (Common.LoggedUser_Id() == 0)
					return RedirectToAction("Login", "Home", new { Area = "Admin" });

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

			return View(new ResponseModel<LoginViewModel>());
		}


		[HttpPost]
		//[ValidateAntiForgeryToken]
		public JsonResult Login(LoginViewModel viewModel)
		{
			try
			{
				if (!string.IsNullOrEmpty(viewModel.UserName) && viewModel.UserName.Length > 0 && _context.Users.Any(x => x.UserName == viewModel.UserName))
				{
					viewModel.Password = Common.Encrypt(viewModel.Password);

					var obj = _context.Users.AsNoTracking().Where(x => x.UserName == viewModel.UserName && x.Password == viewModel.Password).FirstOrDefault();

					if (obj != null && obj.IsActive == true && obj.IsDeleted == false)
					{
						var userRole = _context.UserRoleMappings.AsNoTracking().Where(x => x.UserId == obj.Id).FirstOrDefault();

						obj.CompanyId = userRole != null ? userRole.CompanyId : 0;
						obj.BranchId = userRole != null ? userRole.BranchId : 0;
						obj.RoleId = userRole != null ? userRole.RoleId : 0;

						List<UserMenuAccess> listMenuAccess = new List<UserMenuAccess>();
						List<UserMenuAccess> listMenuPermission = new List<UserMenuAccess>();

						Role role = _context.Roles.AsNoTracking().Where(x => x.Id == obj.RoleId).FirstOrDefault();

						if (role != null && role.Id == 1)
						{
							listMenuAccess = (from y in _context.Menus.AsNoTracking().ToList()
											  where y.IsActive == true && y.IsDeleted == false
											  select new UserMenuAccess() { Id = y.Id, ParentMenuId = y.ParentId, Area = y.Area, Controller = y.Controller, MenuName = y.Name, DisplayOrder = y.DisplayOrder, IsActive = y.IsActive, IsDeleted = y.IsDeleted }).ToList();
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
												  select new UserMenuAccess() { MenuId = y.Id, Controller = y.Controller, MenuName = y.Name, IsCreate = x.IsCreate, IsUpdate = x.IsUpdate, IsRead = x.IsRead, IsDelete = x.IsDelete, IsActive = x.IsActive, IsDeleted = x.IsDeleted }).ToList();

						Common.Configure_UserMenuAccess(listMenuAccess.Where(x => x.IsActive == true && x.IsDeleted == false).ToList(), listMenuPermission.Where(x => x.IsActive == true && x.IsDeleted == false).ToList());

						Common.Set_Session_Int(SessionKey.USER_ID, obj.Id);
						Common.Set_Session_Int(SessionKey.ROLE_ID, obj.RoleId);
						Common.Set_Session_Int(SessionKey.COMPANY_ID, obj.CompanyId);
						Common.Set_Session_Int(SessionKey.BRANCH_ID, obj.BranchId);

						Common.Set_Session(SessionKey.USER_AUTH, obj.UserName);
						Common.Set_Session(SessionKey.ROLE_NAME, role.Name);
						Common.Set_Session_Int(SessionKey.IS_SUPER_USER_KEY, (obj.RoleId == 1 ? 1 : 0));


						CommonViewModel.IsSuccess = true;
						CommonViewModel.StatusCode = ResponseStatusCode.Success;
						CommonViewModel.Message = ResponseStatusMessage.Success;

						CommonViewModel.RedirectURL = Url.Content("~/") + this.ControllerContext.RouteData.Values["Controller"].ToString() + "/Index";

						return Json(CommonViewModel);
					}

					//DataTable dt = _context.GetSQLQuery("SELECT USER_ID, 'C' USER_TYPE, '' IS_ADMIN FROM APR_REGISTRATION_MASTER where USER_ID = '" + responseViewModel.Obj.UserId + "' " +
					//	"UNION ALL SELECT TO_CHAR(USER_ID)USER_ID, 'I' USER_TYPE, IS_ADMIN FROM APR_EMP_ACCESS where TO_CHAR(USER_ID) = '" + responseViewModel.Obj.UserId + "' ");

					//if (dt != null && dt.Rows != null && dt.Rows.Count > 0)
					//{
					//	var user_type = dt.Rows[0]["USER_TYPE"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["USER_TYPE"]) : null;
					//	var is_admin = dt.Rows[0]["IS_ADMIN"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["IS_ADMIN"]) : null;

					//	dt = _context.GetSQLQuery("select HRMSADM.FC_CHECK_PASSWORD('" + responseViewModel.Obj.UserId + "', '" + responseViewModel.Obj.Password + "') ISVALID from dual");

					//	if (dt != null && dt.Rows != null && dt.Rows.Count > 0 && !string.IsNullOrEmpty(user_type))
					//	{
					//		string check = dt.Rows[0]["ISVALID"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["ISVALID"]) : null;

					//		if (!string.IsNullOrEmpty(check) && check.Equals("1"))
					//		{
					//			AppHttpContextAccessor.SetSession(SessionKey.USER_ID, responseViewModel.Obj.UserId);
					//			AppHttpContextAccessor.SetSession(SessionKey.USER_TYPE, user_type ?? "");
					//			AppHttpContextAccessor.SetSession(SessionKey.USER_IS_ADMIN, is_admin ?? "");

					//			CommonViewModel.IsSuccess = true;
					//			CommonViewModel.StatusCode = ResponseStatusCode.Success;
					//			CommonViewModel.Message = ResponseStatusMessage.Success;

					//			if (user_type.Equals("I"))
					//			{
					//				CommonViewModel.RedirectURL = Url.Content("~/") + "Admin/" + this.ControllerContext.RouteData.Values["Controller"].ToString() + "/Index";
					//			}
					//			else
					//			{
					//				CommonViewModel.RedirectURL = Url.Content("~/") + this.ControllerContext.RouteData.Values["Controller"].ToString() + "/Profile";
					//			}

					//			return Json(CommonViewModel);
					//		}
					//	}
					//}
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


		public ActionResult Logout()
		{
			Common.Clear_Session();

			return RedirectToAction("Login", "Home", new { Area = "" });
		}

	}
}