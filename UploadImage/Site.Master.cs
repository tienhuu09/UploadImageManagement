using System;
using System.Web.DynamicData;
using System.Web.UI;

namespace UploadImage
{
    public partial class SiteMaster : MasterPage
    {
        public Account account { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) { }

            if (Page is Login loginPage)
            {
                loginPage.loginEvent += LoginPage_loginEvent;
            }

            if (Session["Account"] != null)
                account = Session["Account"] as Account;

            if (account != null)
            {
                Session["RoleAccount"] = account.RoleAccount;
                if (account.AccountInfo.IdImage != "empty")
                    imgUserMain.ImageUrl = account.AccountInfo.Image.Url;
                else
                    imgUserMain.ImageUrl = "/images/user.png";
            }


        }

        private void LoginPage_loginEvent(object sender, EventArgs e)
        {
            var item = sender as Login;
            account = item.account;
            
        }

        public string GetName()
        {
            if (account == null)
                return null;
            return account.Name.ToString();
        }

        public string GetRole()
        {
            if (account == null)
                return null;
            return account.RoleAccount;
        }

        protected void logout_Click(object sender, EventArgs e)
        {
            account = null;
            Session.Remove("Account");
            Session.Clear();
            Response.Redirect("/Views/SignIn/Login.aspx");
        }
    }
}