using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Web;

namespace BaseStructure_47
{
	public class EC_Category : EntitiesBase
	{
		public override long Id { get; set; }
		public long CompanyId { get; set; }
		public long BranchId { get; set; }
		public long ParentId { get; set; }
		public string Name { get; set; }
		public string Desc { get; set; }
		[NotMapped] public string ParentCategoryName { get; set; }
	}

	public class EC_Product : EntitiesBase
	{
		public override long Id { get; set; }
		public long CompanyId { get; set; }
		public long BranchId { get; set; }
		public long CategoryId { get; set; }
		public long BrandId { get; set; }
		public long UnitId { get; set; }
		public string Name { get; set; }
		public string Primary_Desc { get; set; }
		public string Secondary_Desc { get; set; }
		public decimal MRP { get; set; }
		public string Primary_Images { get; set; }
		public string Secondary_Images { get; set; }
		[NotMapped] public string CategoryName { get; set; }
		[NotMapped] public List<EC_Product_Attributes> listAttribute { get; set; }
		[NotMapped] public List<EC_Product_Variant> listVariant { get; set; }
		[NotMapped] public List<Attachment> listAttachment { get; set; }
		[NotMapped] public HttpPostedFileBase filePrimary { get; set; }
		[NotMapped] public HttpPostedFileBase fileSecondary { get; set; }
	}

	public class EC_Product_Dtls : EntitiesBase
	{
		public override long Id { get; set; }
		public long ProductId { get; set; }
		public long VariantId { get; set; }
		public decimal SalePrice { get; set; }
		public string Primary_Desc { get; set; }
		public string Secondary_Desc { get; set; }
		public string Primary_Images { get; set; }
		public string Secondary_Images { get; set; }
	}

	public class EC_Product_Variant : EntitiesBase
	{
		public override long Id { get; set; }
		public long CompanyId { get; set; }
		public long BranchId { get; set; }
		public long VariantId { get; set; }
		public long ProductId { get; set; }
		public long AttributeId { get; set; }
		public long AttributeValueId { get; set; }
		[NotMapped] public decimal SalePrice { get; set; }
	}


	public class EC_Product_Attribute_Value : EntitiesBase
	{
		public override long Id { get; set; }
		public long CompanyId { get; set; }
		public long BranchId { get; set; }
		public long AttributeId { get; set; }
		public string Value { get; set; }
		public string Display_Value { get; set; }
	}


	public class EC_Product_Attributes : EntitiesBase
	{
		public override long Id { get; set; }
		public long CompanyId { get; set; }
		public long BranchId { get; set; }
		public string Name { get; set; }
		[NotMapped] public string AttributeValue { get; set; }
		[NotMapped] public decimal SalePrice { get; set; }
	}

	public class EC_Unit : EntitiesBase
	{
		public override long Id { get; set; }
		public string Name { get; set; }
		public decimal Multiplier { get; set; }
		public string Code { get; set; }
	}

}