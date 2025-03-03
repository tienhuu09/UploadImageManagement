using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UploadImage
{
    public partial class Post1 : System.Web.UI.Page
    {
        public ImageService imageService { get; set; }
        public PostService postService { get; set; }
        public PostDetailService postDetailService { get; set; }

        public string urlAvatar { get; set; }
        public Account account { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            imageService = new ImageService();
            postService = new PostService();
            postDetailService = new PostDetailService();

            var item = (UploadImage.Account)Session["Account"];
            if (item == null)
                Response.Redirect("~/Views/SignIn/Login.aspx");

            account = Session["Account"] as Account; 
            if (account.AccountInfo.IdImage == "empty")
            {
                imagePostAvatarIcon.ImageUrl = "/images/user.png";
                imagePostAvatarIcon2.ImageUrl = "/images/user.png";
                urlAvatar = "/images/user.png";
            }
            else
            {
                imagePostAvatarIcon.ImageUrl = account.AccountInfo.Image.Url;
                imagePostAvatarIcon2.ImageUrl = account.AccountInfo.Image.Url;
                urlAvatar = account.AccountInfo.Image.Url;
            }
            LoadImage();
            DataBind();
        }

        public void LoadImage()
        {
            List<Images> lstImages = new List<Images>();
            foreach (var img in imageService.Gets())
            {
                if (lstImages.Count < 9)
                {
                    if (string.Compare(img.IdReference, account.Id, true) == 0)
                        lstImages.Add(img);
                }
            }
            RepeaterImages.DataSource = lstImages;
            RepeaterImages.DataBind();
        }

        protected void btnUpload_Click(object sender, EventArgs e)
        {
            if (fileUploadControl.HasFile)
            {
                imageService.update += ImageService_update;

                string fileName = fileUploadControl.FileName;

                string newfileName = inputfileName.Value;

                string fileExtension = null;
                if (string.IsNullOrEmpty(newfileName))
                    newfileName = fileUploadControl.FileName;
                else 
                    fileExtension = Path.GetExtension(fileUploadControl.FileName);

                Images image = new Images();

                image.Id = imageService.GetNewId();
                if (string.IsNullOrEmpty(inputName.Value))
                    image.Name = Path.GetFileNameWithoutExtension(fileUploadControl.FileName);
                else
                    image.Name = inputName.Value;
                if (string.IsNullOrEmpty(image.Name))
                    image.Name = inputfileName.Value;
                image.Style = inputStyle.Value.ToString();
                image.CreateDate = DateTime.Now;
                image.IdReference = account.Id;

                string finalFileName = account.Id + "_" + image.Id + "_" + newfileName + fileExtension;

                string savePath = MapPath("~/images/") + finalFileName;
                if (imageService.CheckUrl(finalFileName))
                {
                    string str = "This Url is existed";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + str + "');", true);
                    return;
                }

                HttpPostedFile httpPosted = fileUploadControl.PostedFile;
                long fileSize = httpPosted.ContentLength;
                double fileSizeInKb = Math.Round(httpPosted.ContentLength / 1024.0, 2);

                image.Size = fileSizeInKb.ToString();
                image.Url = ("/images/" + finalFileName);
                image.Summary = inputSummary.Value.ToString();
                if (string.IsNullOrEmpty(image.Summary))
                    image.Summary = "empty";

                // Save file and Add to List
                fileUploadControl.SaveAs(savePath);
                imageService.AddImageAndSetAccount(image, account);
                postService.AddAvatar(image, account);

                ResetValues();
            }
        }

        private void ResetValues()
        {
            inputfileName.Value = null;
            inputName.Value = null;
            inputSummary.Value = null;
            imageService.update -= ImageService_update;
            Response.Redirect("/Views/Post.aspx");
        }

        private void ImageService_update(object sender, EventArgs e)
        {
            var item = sender as Account;
            account = item;
            Session["Account"] = item;
        }

        protected void UpdateAvatar_Click(object sender, EventArgs e)
        {
            panelInput.Attributes.Remove("style");
            panelInput.Attributes.Add("style", "visibility: visible");
        }

        protected void btnUploadMultiple_Click(object sender, EventArgs e)
        {
            if (Request.Files.Count > 0)
            {
                Post post = new Post()
                {
                    IdAccount = account.Id,
                    Id = postService.GetNewId(),
                    CreateDate = DateTime.Now,
                    lstPostDetail = new List<PostDetail>(),
                    lstImage = new List<Images>()
                };

                for (int i = 0; i < Request.Files.Count; i++)
                {
                    HttpPostedFile uploadedFile = Request.Files[i];

                    PostDetail postDetail = null;
                    if (uploadedFile != null && uploadedFile.ContentLength > 0)
                    {
                        string fileName = uploadedFile.FileName;

                        string fileExtension = Path.GetExtension(uploadedFile.FileName);
                        string fileNameOriginal = Path.GetFileNameWithoutExtension(uploadedFile.FileName);
                        string newFileName = post.Id + "_" + "img" + i + "_" + fileNameOriginal + fileExtension;

                        string finalFileName = newFileName;

                        //////////////////////////////////////////////////////////////
                        string savePath = MapPath("~/images/") + finalFileName;
                        
                        Images image = new Images();
                        image.Id = imageService.GetNewId();
                        image.Name = fileNameOriginal;
                        image.Style = "Post";
                        image.CreateDate = DateTime.Now;
                        image.IdReference = post.Id;

                        //long fileSize = uploadedFile.ContentLength;
                        //double fileSizeInKb = fileSize / 1024.0; // Kb

                        double fileSizeInKb = Math.Round(uploadedFile.ContentLength / 1024.0, 2);
                        image.Size = fileSizeInKb.ToString();
                        image.Url = ("/images/" + finalFileName);
                        image.Summary = "empty";

                        postDetail = new PostDetail()
                        {
                            Id = postDetailService.GetNewId(post.lstPostDetail.Count),
                            IdPost = post.Id,
                            IdImage = image.Id
                        };

                        try
                        {
                            uploadedFile.SaveAs(savePath);
                            post.lstImage.Add(image);
                            post.lstPostDetail.Add(postDetail);
                            imageService.Add(image);
                        }
                        catch(SqlException) { }
                    }
                }
                post.QuantityImage = post.lstPostDetail.Count;
                postService.Add(post);
            }
            Response.Redirect("/Views/Post.aspx");
        }

        protected void removePost_Click(object sender, EventArgs e)
        {
            LinkButton linkBtn = sender as LinkButton;

            if (linkBtn != null)
            {
                Control parentContainer = linkBtn.NamingContainer;
                Image imageControl = parentContainer.FindControl("imgSlide") as Image;

                if (imageControl != null)
                {
                    string imageUrlFromControl = imageControl.ImageUrl;
                    Session["Url"] = imageUrlFromControl;
                }

            }
        }

        protected void btnfileDocument_Click(object sender, EventArgs e)
        {

        }
    }
}