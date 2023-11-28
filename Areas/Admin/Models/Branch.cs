using System.ComponentModel.DataAnnotations.Schema;

namespace BaseStructure_47
{
	public partial class Branch : EntitiesBase
	{
		public long CompanyId { get; set; }
		public string Name { get; set; }
		[NotMapped] public string CompanyName { get; set; }
		//public string Address { get; set; }
		//public string Location { get; set; }

	}
}
