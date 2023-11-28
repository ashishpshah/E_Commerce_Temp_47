using System;

namespace BaseStructure_47
{
	public partial class Employee : EntitiesBase
	{
		public override long Id { get; set; }
		public long CompanyId { get; set; }
		public long BranchId { get; set; }
		public long UserId { get; set; }
		public long RoleId { get; set; }
		public string FirstName { get; set; }
		public string LastName { get; set; }
		public string MiddleName { get; set; }
		public string Address { get; set; }
		public long? CityId { get; set; }
		public long? StateId { get; set; }
		public long? CountryId { get; set; }
		public string Gender { get; set; }
		public string Position { get; set; }
		public string ContactNo { get; set; }
		public string BloodGroup { get; set; }
		public DateTime? BirthDate { get; set; }
		public DateTime? HireDate { get; set; }
	}
}
