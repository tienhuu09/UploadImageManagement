using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Security.Permissions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using UploadImage;

namespace UploadImage
{
    public partial class Profile : System.Web.UI.Page
    {
        public ImageService imageService { get; set; }
        public PostService postService { get; set; }

        public Account account { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) { }

            imageService = new ImageService();
            postService = new PostService();

            //var item = (UploadImage.Account)Session["Account"];
            //if (item == null)
            //    Response.Redirect("~/Login.aspx");

            //account = Session["Account"] as Account;
            //imgUserMain.ImageUrl = account.AccountInfo.Image.Url;
            //if (account.AccountInfo.IdImage == "empty")
            //    imagePostAvatarIcon.ImageUrl = "/images/user.png";
            //else
            //    imagePostAvatarIcon.ImageUrl = account.AccountInfo.Image.Url;
            //DataBind();
        }

        protected void ChangeAvatar_Click(object sender, EventArgs e)
        {
                //panelInput.Attributes.Remove("style");
                //panelInput.Attributes.Add("style", "visibility: visible");
        }

        protected void btnUpload_Click(object sender, EventArgs e)
        {
            //if (fileUploadControl.HasFile)
            //{
            //    imageService.update += ImageService_update;

            //    string fileName = fileUploadControl.FileName;

            //    string newfileName = inputfileName.Value;

            //    if (string.IsNullOrEmpty(newfileName))
            //        newfileName = fileUploadControl.FileName;

            //    string fileExtension = Path.GetExtension(fileUploadControl.FileName);

            //    string finalFileName = newfileName + fileExtension;

            //    string savePath = MapPath("~/images/") + finalFileName;

            //    Images image = new Images();
                
            //    image.Id = imageService.GetNewId();
            //    image.Name = inputfileName.Value;
            //    if (string.IsNullOrEmpty(image.Name))
            //        image.Name = fileUploadControl.FileName;
            //    image.Style = inputStyle.Value.ToString();
            //    image.CreateDate = DateTime.Now;
            //    image.IdReference = account.Id;

            //    HttpPostedFile httpPosted = fileUploadControl.PostedFile;
            //    long fileSize = httpPosted.ContentLength;
            //    double fileSizeInKb = fileSize / 1024.0; // Kb

            //    image.Size = fileSizeInKb.ToString();
            //    image.Url = ("/images/" + finalFileName);
            //    image.Summary = inputSummary.Value.ToString();
                
            //    // Save file and Add to List
            //    fileUploadControl.SaveAs(savePath);
            //    imageService.Add(image, account);
            //    postService.AddAvatar(image, account);

            //    ResetValues();
            //}
        }

        private void ResetValues()
        {
            //inputfileName.Value = null;
            //inputName.Value = null;
            //inputSummary.Value = null;
            //imageService.update -= ImageService_update;
            //Response.Redirect("Profile.aspx");
        }

        private void ImageService_update(object sender, EventArgs e)
        {
            //var item = sender as Account;
            //account = item;
            //Session["Account"] = item;
        }
    }
}