
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace BaseStructure_47
{
	public partial class User : EntitiesBase
	{
		public override long Id { get; set; }

		[NotMapped] public string UserId { get; set; }
		public string UserName { get; set; }
		public string Password { get; set; }
		//public string EmailId { get; set; }
		//public string MobileNo { get; set; }
		//public long? RoleId { get; set; }

		public Nullable<int> No_Of_Wrong_Password_Attempts { get; set; }
		public Nullable<DateTime> Next_Change_Password_Date { get; set; }

		[NotMapped] public string User_Role { get; set; }
		[NotMapped] public long User_Role_Id { get; set; }
		[NotMapped] public long RoleId { get; set; }
		[NotMapped] public long CompanyId { get; set; }
		[NotMapped] public long BranchId { get; set; }
		[NotMapped] public string CompanyName { get; set; }
		[NotMapped] public string BranchName { get; set; }
		[NotMapped] public bool IsPassword_Reset { get; set; }
		[NotMapped] public DateTime? Date { get; set; }
		[NotMapped] public string Date_Text { get; set; }
	}
}