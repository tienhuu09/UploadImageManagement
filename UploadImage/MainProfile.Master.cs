using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Principal;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UploadImage
{
    public partial class MainProfile : System.Web.UI.MasterPage
    {
        public Account account { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            var item = (UploadImage.Account)Session["Account"];
            if (item == null)
                Response.Redirect("~/Views/SignIn/Login.aspx");

            account = Session["Account"] as Account;
            if (string.Compare(account.AccountInfo.IdImage, "empty", true) == 0)
                Image1.ImageUrl = "/images/user.png";
            else
                Image1.ImageUrl = account.AccountInfo.Image.Url;

            if (account != null)
            {
                Session["RoleAccount"] = account.RoleAccount;
                if (account.AccountInfo.IdImage != "empty")
                    imgUserMain.ImageUrl = account.AccountInfo.Image.Url;
                else
                    imgUserMain.ImageUrl = "/images/user.png";
            }
            string currentPage = System.IO.Path.GetFileName(Request.Url.AbsolutePath).ToLower();

            switch (currentPage)
            {
                case "post":
                    postLink.Attributes.Add("class", "active");
                    break;
                case "about.aspx":
                    introduceLink.Attributes.Add("class", "active");
                    break;
                case "friends.aspx":
                    freindLink.Attributes.Add("class", "active");
                    break;
                case "imagepage":
                    imageLink.Attributes.Add("class", "active");
                    break;
                case "videos.aspx":
                    videoLink.Attributes.Add("class", "active");
                    break;
            }

            DataBind();
        }

        private void LoginPage_loginEvent(object sender, EventArgs e)
        {
            var item = sender as Login;
            account = item.account;
        }

        protected void lnkLogout_Click(object sender, EventArgs e)
        {
            account = null;
            Session.Remove("Account");
            Session.Clear();
            Response.Redirect("/Views/SignIn/Login.aspx");
        }
    }
}