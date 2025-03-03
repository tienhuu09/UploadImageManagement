using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace UploadImage
{
    public partial class ImagePage : System.Web.UI.Page
    {
        public ImageService imageService { get; set; }
        public PostService postService { get; set; }
        public AccountInfoService accountInfoService { get; set; }

        public Account account { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            var item = (UploadImage.Account)Session["Account"];
            if (item == null)
                Response.Redirect("~/Views/SignIn/Login.aspx");

            imageService = new ImageService();
            postService = new PostService();
            accountInfoService = new AccountInfoService();

            account = Session["Account"] as Account;

            string eventTarget = Request.Form["__EVENTTARGET"];
            string eventArgument = Request.Form["__EVENTARGUMENT"];
            if (eventTarget == "ConfirmResult")
            {
                if (eventArgument == "Yes")
                {
                    Remove();
                }
            }
            LoadImage();
            DataBind();
        }

        public void LoadImage()
        {
            List<Images> lstImage = new List<Images>();
            foreach (var post in account.lstPost)
            {
                foreach (var image in post.lstImage)
                {
                    lstImage.Add(image);
                }
            }
            RepeaterImages.DataSource = lstImage;
            RepeaterImages.DataBind();
        }

        protected void ButtonRemove_Click(object sender, EventArgs e)
        {
            string script = "var result = confirm('Are you sure to continue?');" +
                    "if (result) { __doPostBack('ConfirmResult', 'Yes'); }" +
                    "else { __doPostBack('ConfirmResult', 'No'); }";

            ClientScript.RegisterStartupScript(this.GetType(), "ConfirmBox", script, true);

            LinkButton linkButton = sender as LinkButton;

            if (linkButton != null)
            {
                Control parentContainer = linkButton.NamingContainer;
                Image imageControl = parentContainer.FindControl("myImg") as Image;

                if (imageControl != null)
                {
                    string imageUrlFromControl = imageControl.ImageUrl;
                    Session["Url"] = imageUrlFromControl;
                }
            }
        }

        public void Remove()
        {
            var url = Session["Url"].ToString();
            Images image = imageService.GetByUrl(url);
            imageService.Delete(image, account);
            Response.Redirect("/Views/Admin/ImagePage.aspx");
            string script = @"toastr.success('Remove successfully!', 'Notification');";
            ClientScript.RegisterStartupScript(this.GetType(), "ToastNotification", script, true);
        }

        protected void SetAvtProfile_Click(object sender, EventArgs e)
        {
            LinkButton linkButton = sender as LinkButton;
            if (linkButton != null)
            {
                Control parentContainer = linkButton.NamingContainer;
                Image imageControl = parentContainer.FindControl("myImg") as Image;

                if (imageControl != null)
                {
                    string imageUrlFromControl = imageControl.ImageUrl;
                    Session["Url"] = imageUrlFromControl;
                }
            }

            var url = Session["Url"].ToString();
            Images image = imageService.GetByUrl(url);
            account.AccountInfo.IdImage = image.Id;
            account.AccountInfo.Image = image;
            accountInfoService.Update(account.AccountInfo);
            Session["Account"] = account;

            var acc = Session["Account"] as Account;

            Response.Redirect("/Views/Post.aspx");
        }

        protected void RepeaterImages_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                HtmlGenericControl myDiv = e.Item.FindControl("myDiv") as HtmlGenericControl;
                // you can just pass "this" instead of "myDiv.ClientID" and get the ID from the DOM element
                myDiv.Attributes.Add("onmouseover", "doStuff('" + myDiv.ClientID + "');");
            }
        }
    }
}