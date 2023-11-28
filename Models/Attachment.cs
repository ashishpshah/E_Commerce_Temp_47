using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace BaseStructure_47
{
    public partial class Attachment
	{
		public long Id { get; set; }
		public string Name { get; set; }
		public string Extension { get; set; }
		public long Size { get; set; }
		public string TypeDocument { get; set; }
		public string TypeContent { get; set; }
		public string Path { get; set; }
		public string Remarks { get; set; }

	}
}
