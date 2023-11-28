namespace BaseStructure_47
{
	public partial class UserRole : EntitiesBase
	{
		public override long Id { get; set; }
		public long CompanyId { get; set; }
		public long BranchId { get; set; }
		public string Name { get; set; }
	}
}
