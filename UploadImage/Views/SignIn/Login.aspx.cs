using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Web;
using System.Web.Configuration;
using System.Web.Security;
using System.Web.Services.Description;
using System.Web.UI;
using System.Web.UI.WebControls;
using UploadImage;

namespace UploadImage
{
    public partial class Login : System.Web.UI.Page
    {
        public event EventHandler loginEvent;

        public AccountService AccountService { get; set; }
        public Account account { get; set; }

        public Login()
        {
            AccountService = new AccountService();
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void login_Click(object sender, EventArgs e)
        {
            var username = userName.Value;
            var passwork = passWord.Value;

            if (string.IsNullOrEmpty(username) && string.IsNullOrEmpty(passwork))
                return;

            account = AccountService.GetAccount(username, passwork);
            if (account != null)
            {
                Session["Username"] = account.Username.ToString();
                Session["RoleAccount"] = account.RoleAccount.ToString();
                Session["Account"] = account;

                loginEvent.Invoke(this, EventArgs.Empty);
                Response.Redirect("~/");
            }
            else
            {
                Session.Remove("Account");
                Session.Clear();
            }

        }

        protected void signUp_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Views/Login/SignUp.aspx");
        }
    }
}