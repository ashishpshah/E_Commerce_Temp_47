using System.ComponentModel.DataAnnotations.Schema;

namespace BaseStructure_47
{
	public partial class Contact : EntitiesBase
	{
		public override long Id { get; set; }
		public long CompanyId { get; set; }
		public long BranchId { get; set; }
		public string Header { get; set; }
		public string Body { get; set; }
		public int? DisplayOrder { get; set; }
	}


	public partial class About : EntitiesBase
	{
		public override long Id { get; set; }
		public long CompanyId { get; set; }
		public long BranchId { get; set; }
		public string Header { get; set; }
		public string Body { get; set; }
		public int? DisplayOrder { get; set; }
	}
}
