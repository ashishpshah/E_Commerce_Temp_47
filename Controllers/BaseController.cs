using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using static System.Collections.Specialized.BitVector32;

namespace BaseStructure_47.Controllers
{
	public class BaseController<T> : Controller where T : class
	{
		public readonly DataContext _context;
		public dynamic CommonViewModel = default(T);

		public bool IsLogActive = false;

		public readonly DateTime? nullDateTime = null;

		public BaseController()
		{
			_context = new DataContext();
			CommonViewModel = (dynamic)Activator.CreateInstance(typeof(T));
		}

		public BaseController(DataContext context)
		{
			_context = context;
			CommonViewModel = (dynamic)Activator.CreateInstance(typeof(T));
		}

		protected override void OnActionExecuting(ActionExecutingContext context)
		{
			var areaName = "";
			var controllerName = Convert.ToString(context.RouteData.Values["controller"]);
			var actionName = Convert.ToString(context.RouteData.Values["action"]);

			if (context.RouteData.DataTokens != null)
				areaName = Convert.ToString(context.RouteData.DataTokens["area"]);


			Common.Set_SessionState(context.HttpContext.Session);
			Common.Set_Controller_Action(controllerName + '_' + actionName);

			IsLogActive = Convert.ToBoolean(ConfigurationManager.AppSettings["IsLogActive"]);

			List<UserMenuAccess> listMenuAccess = Common.GetUserMenuPermission();

			if (listMenuAccess != null && listMenuAccess.Count > 0)
			{
				if (listMenuAccess.FindIndex(x => x.Controller == controllerName) > -1)
				{
					CommonViewModel.IsCreate = listMenuAccess[listMenuAccess.FindIndex(x => x.Controller == controllerName)].IsCreate;
					CommonViewModel.IsRead = listMenuAccess[listMenuAccess.FindIndex(x => x.Controller == controllerName)].IsRead;
					CommonViewModel.IsUpdate = listMenuAccess[listMenuAccess.FindIndex(x => x.Controller == controllerName)].IsUpdate;
					CommonViewModel.IsDelete = listMenuAccess[listMenuAccess.FindIndex(x => x.Controller == controllerName)].IsDelete;
				}
			}

			if (!Common.IsUserLogged() && Convert.ToString(controllerName).ToLower() != "home" && Convert.ToString(actionName).ToLower() != "login")
			{
				context.Result = new RedirectResult(Url.Content("~/") + (string.IsNullOrEmpty(areaName) ? "" : areaName + "/") + "Home/Login");
				return;
			}
			else if (Common.IsUserLogged() && !Common.IsAdmin() && !string.IsNullOrEmpty(areaName))
			{
				context.Result = new RedirectResult(Url.Content("~/") + "Home/Login");
				return;
			}

			//if (!AppHttpContextAccessor.IsLogged() && Convert.ToString(controllerName).ToLower() != "home" && Convert.ToString(actionName).ToLower() != "login")
			//{
			//    var listRoleMenuAccess = new List<UserRoleAccess>();

			//    if (!string.IsNullOrEmpty(AppHttpContextAccessor.GetSession(SessionKey.LOGGED_USER_MENU_ACCESS)))
			//    {
			//        listRoleMenuAccess = JsonConvert.DeserializeObject<List<UserRoleAccess>>(AppHttpContextAccessor.GetSession(SessionKey.LOGGED_USER_MENU_ACCESS));
			//    }
			//    else
			//    {
			//        //listRoleMenuAccess = _context.Role.OracleQuery_SelectAll_RoleMenu(AppHttpContextAccessor.GetSessionInt(SessionKey.COMPANY_ID), AppHttpContextAccessor.GetSessionInt(SessionKey.BRANCH_ID), AppHttpContextAccessor.GetSessionInt(SessionKey.USER_ID));

			//        //AppHttpContextAccessor.SetSession(SessionKey.LOGGED_USER_MENU_ACCESS, JsonConvert.SerializeObject(listRoleMenuAccess));
			//    }

			//    if (listRoleMenuAccess.Any(x => x.RoleId == AppHttpContextAccessor.GetSessionInt(SessionKey.ROLE_ID)))
			//    {
			//        if (!listRoleMenuAccess.Where(x => x.RoleId == AppHttpContextAccessor.GetSessionInt(SessionKey.ROLE_ID)).FirstOrDefault().Menus.Any(x => x.Action.ToLower() == actionName.ToLower() && x.Controller.ToLower() == controllerName.ToLower() && x.IsActive == true && x.IsDeleted == false))
			//        {
			//            var values = new RouteValueDictionary(new
			//            {
			//                action = "UnAuthorized",
			//                controller = "Home",
			//                code = "1"
			//            });

			//            context.Result = new RedirectToRouteResult(values);

			//            context.Result = new RedirectResult(@Url.Content("~/") + "Home/Login");
			//        }
			//    }
			//}
		}

	}
}