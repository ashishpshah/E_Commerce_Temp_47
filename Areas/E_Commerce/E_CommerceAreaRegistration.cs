using System.Web.Mvc;

namespace BaseStructure_47.Areas.E_Commerce
{
	public class E_CommerceAreaRegistration : AreaRegistration
	{
		public override string AreaName { get { return "Admin"; } }

		public override void RegisterArea(AreaRegistrationContext context)
		{
			context.MapRoute(
				"Category_default",
				"Admin/Category/{action}/{id}",
				new { controller = "Category", action = "Index", id = UrlParameter.Optional },
				namespaces: new string[] { "BaseStructure_47.Areas.E_Commerce.Controllers" }
			);

			context.MapRoute(
				"Product_default",
				"Admin/Product/{action}/{id}",
				new { controller = "Product", action = "Index", id = UrlParameter.Optional },
				namespaces: new string[] { "BaseStructure_47.Areas.E_Commerce.Controllers" }
			);

			context.MapRoute(
				"Attribute_default",
				"Admin/Attribute/{action}/{id}",
				new { controller = "Attribute", action = "Index", id = UrlParameter.Optional },
				namespaces: new string[] { "BaseStructure_47.Areas.E_Commerce.Controllers" }
			);

			context.MapRoute(
				"Unit_default",
				"Admin/Unit/{action}/{id}",
				new { controller = "Unit", action = "Index", id = UrlParameter.Optional },
				namespaces: new string[] { "BaseStructure_47.Areas.E_Commerce.Controllers" }
			);

		}
	}
}