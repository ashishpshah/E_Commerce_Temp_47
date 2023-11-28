using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace BaseStructure_47
{
    public class LoginViewModel
    {
        [Required(ErrorMessage = "Please enter user name.")] public string UserName { get; set; }
        [Required(ErrorMessage = "Please enter password.")] public string Password { get; set; }
        public long CompanyId { get; set; }
        [Required(ErrorMessage = "Please select branch.")] public long BranchId { get; set; }
        public string User_Type { get; set; }
        public bool RememberMe { get; set; }
    }
    public class RegisterViewModel
    {
        [Required]
        public string UserName { get; set; }
        [Required]
        public string Password { get; set; }
        [Required]
        [Compare("Password")]
        public string ConfirmPassword { get; set; }
        public string Role { get; set; }
    }
    public class ForgotPassword
    {
        public string User_Id { get; set; }
        public string User_Name { get; set; }
        public string Branch_Id { get; set; }
        public string Password { get; set; }
        public string User_Type { get; set; }
        public string Email { get; set; }
    }
}
