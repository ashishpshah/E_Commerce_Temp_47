
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace BaseStructure_47
{
    public partial class Company : EntitiesBase
	{
		public override long Id { get; set; }
		//[Display(Name = "Full Name")]
		//public string FullName
		//{
		//    get { return LastName + ", " + FirstMidName; }
		//}
		[Display(Name = "Company Name")]
        [Required]
        [StringLength(50, MinimumLength = 2)]
        [RegularExpression(@"^[A-Z]+[a-zA-Z0-9\s_]*$")]
		public string Name { get; set; }

		[NotMapped] public List<Attachment> listDocuments { get; set; }
    }
   
}
