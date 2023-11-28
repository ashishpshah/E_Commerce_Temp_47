using BaseStructure_47;

namespace BaseStructure_47
{
    public partial class Login : EntitiesBase
    {
       
        public string UserName { get; set; }
        public string UserId { get; set; }
        public string Password { get; set; }
        public long CompanyId { get; set; }
        public string CompanyName { get; set; }

        public long BranchId { get; set; }
        public string BranchName { get; set; }

        public bool RememberMe { get; set; }
    }
}
