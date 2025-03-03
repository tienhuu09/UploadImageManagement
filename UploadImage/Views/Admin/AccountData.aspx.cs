using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using UploadImage;

namespace UploadImage
{
    public partial class AccountData : System.Web.UI.Page
    {
        public AccountService accountService { get; set; }
        public ImageService imageService { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            accountService = new AccountService();
            imageService = new ImageService();

            var item = (UploadImage.Account)Session["Account"];
            if (item == null || item.RoleAccount != "Admin")
            {
                string notify = "Bạn không có quyền truy cập trang web này";
                ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + notify + "');", true);
                Response.Redirect("~/Views/SignIn/Login.aspx");
            }
        }
    }
}