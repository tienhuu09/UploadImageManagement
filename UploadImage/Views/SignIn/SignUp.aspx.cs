using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using UploadImage;

namespace UploadImage
{
    public partial class SignUp : System.Web.UI.Page
    {
        public AccountService accoutService { get; set; }
        
        
        protected void Page_Load(object sender, EventArgs e)
        {
            accoutService = new AccountService();
        }

        protected void signUp_Click(object sender, EventArgs e)
        {
            string name = inputName.Value;
            string userame = inputUserName.Value;
            string password = inputPassWord.Value;
            string address = inputAddress.Value;
            string phone = inputPhone.Value;

            if (string.IsNullOrEmpty(name) ||
                string.IsNullOrEmpty(userame) || string.IsNullOrEmpty(password) || 
                string.IsNullOrEmpty(address) || string.IsNullOrEmpty(phone))
            {
                string str = "Please enter complete information. Please try again!";
                ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + str + "');", true);
                return;
            }
            if (accoutService.CheckUsername(userame))
            {
                string notify = "Username is existed. Please try again!";
                inputUserName.Value = "";
                ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + notify + "');", true);
                return;
            }
            Account accont = new Account
            {
                Id = accoutService.getNewId(),
                Name = name,
                Username = userame,
                Password = password,
                RoleAccount = "User"
            };
            accont.lstPost = new List<Post>();

            AccountInfo accontInfo = new AccountInfo()
            {
                IdAccount = accont.Id,
                Address = address,
                PhoneNumber = phone,
                CreateDate = DateTime.Now,
                IdImage = "empty"
            };
            accont.AccountInfo = accontInfo;
            
            accoutService.Add(accont);
            Session["Account"] = accont;

            string strSuccess = "Registration successfully";
            ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + strSuccess + "');", true);

            Response.Redirect("/Views/Post.aspx");
        }
    }
}