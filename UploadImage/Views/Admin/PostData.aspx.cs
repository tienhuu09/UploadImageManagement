using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.IO;
using System.Linq;
using System.Security.Cryptography.X509Certificates;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace UploadImage
{
    public partial class PostData : System.Web.UI.Page
    {
        public PostService postService { get; set; }
        public PostDetailService postDetailService { get; set; }
        public ImageService imageService { get; set; }
        public ObservableCollection<Post> lstPost { get; set; }
        public ObservableCollection<Images> lstImage { get; set; }
        
        public Post selectedPost { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            postService = new PostService();
            postDetailService = new PostDetailService();
            imageService = new ImageService();
            lstImage = new ObservableCollection<Images>(imageService.Gets());
            lstPost = new ObservableCollection<Post>(postService.Gets());

            var item = (UploadImage.Account)Session["Account"];
            if (item == null)
                Response.Redirect("~/Views/SignIn/Login.aspx");

            //divlistImage.DataSource = lstImage;
            //divlistImage.DataBind();
        }

        protected void search_ServerClick(object sender, EventArgs e)
        {
            var str = inputSearch.Value;
            if (string.IsNullOrEmpty(str))
                return;
            lstPost = new ObservableCollection<Post>();
            foreach (var post in postService.Gets())
            {
                if (post.Title.ToLower().Contains(str))
                {
                    lstPost.Add(post);
                }
            }
        }

        protected void btnStatus_ServerClick(object sender, EventArgs e)
        {
            var btn = sender as HtmlButton;
        }

        protected void confirmCreate_ServerClick(object sender, EventArgs e)
        {
            var btn = sender as HtmlButton;
            if (btn != null)
            {
                for (int i = 0; i < Request.Files.Count; i++)
                {
                    HttpPostedFile file = Request.Files[i];
                    if (file != null && file.ContentLength > 0)
                    {
                        string fileName = file.FileName;
                        string fileExtension = Path.GetExtension(fileName);
                        string fileNameOriginal = Path.GetFileNameWithoutExtension(fileName);

                        string savePath = MapPath("~/images/") + fileName;
                        double fileSizeKb = Math.Round(file.ContentLength / 1024.0, 2);
                        var title = inputTitle.Value;

                        var account = Session["Account"] as Account;

                        Post post = new Post()
                        {
                            Id = postService.GetNewId(),
                            CreateDate = DateTime.Now,
                            IdAccount = account.Id,
                            Title = title,
                            Status = true
                        };
                        ////////////////////////////////////////////
                        Images images = new Images()
                        {
                            Id = imageService.GetNewId(),
                            Name = fileName,
                        };
                    }
                }
            }
        }

        protected void btnConfirmUpdate_ServerClick(object sender, EventArgs e)
        {
            string dataId = inputId.Value;
            Post post = postService.GetById(dataId);

            for (int i = 0; i < Request.Files.Count; i++)
            {
                HttpPostedFile file = Request.Files[i];
                if (file != null && file.ContentLength > 0)
                {
                    string fileName = file.FileName;
                    string fileExtension = Path.GetExtension(fileName);
                    string fileNameOriginal = Path.GetFileNameWithoutExtension(fileName);
                    double fileSizeKb = Math.Round(file.ContentLength / 1024.0, 2);

                    string randomUrl = Ulti.GenerateHashedString("Post", 16);
                    if (imageService.checkUrl(randomUrl))
                    {
                        string notify = "Could not initialize, this url already exists !";
                        ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + notify + "');", true);
                        return;
                    }

                    Images img = new Images()
                    {
                        Id = imageService.GetNewId(),
                        Name = fileNameOriginal,
                        CreateDate = DateTime.Now,
                        IdReference = post.Id,
                        Style = "Post",
                        Size = fileSizeKb.ToString(),
                        Status = true,
                        Url = imageService.CreateUrl(randomUrl, fileExtension)
                    };

                    PostDetail postDetail = new PostDetail()
                    {
                        Id = postDetailService.GetNewId(),
                        IdImage = img.Id,
                        IdPost = post.Id,
                        Position = post.lstPostDetail.Count + 1,
                        Status = true
                    };

                    var title = inputTitle.Value;

                    if (imageService.CheckUrlExisted(img))
                    {
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "Notification()", true);
                        return;
                    }

                    string savePath = MapPath("~/images/Post_") + randomUrl + fileExtension;
                    file.SaveAs(savePath);
                    imageService.Add(img);
                    post.lstImage.Add(img);
                    post.lstPostDetail.Add(postDetail);
                    postDetailService.Gets().Add(postDetail);
                    post.QuantityImage = post.lstImage.Count;
                }
            }
        }


    }
} 