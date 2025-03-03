using System;
using System.CodeDom;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Caching;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace UploadImage
{
    public partial class ImageData : System.Web.UI.Page
    {
        public ImageService ImageService { get; set; }
        public ObservableCollection<Images> lstImageAvatar { get; set; }
        public ObservableCollection<Images> lstImagePost { get; set; }

        public Account account { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ImageService = new ImageService();
                Session["ImageService"] = ImageService;
                BindGridView();
            }
            else
            {
                ImageService = (ImageService)Session["ImageService"];
                lstImageAvatar = (ObservableCollection<Images>)Session["lstImageAvatar"];
                lstImagePost = (ObservableCollection<Images>)Session["lstImagePost"];
            } 
            var account = (UploadImage.Account)Session["Account"];
            
            if (account == null || account.RoleAccount != "Admin")
                Response.Redirect("~/Views/SignIn/Login.aspx");
        }

        public void BindGridView()
        {
            lstImageAvatar = new ObservableCollection<Images>();
            lstImagePost = new ObservableCollection<Images>();
            foreach (var item in ImageService.Gets())
            {
                switch(item.Style)
                {
                    case "Avatar":
                        lstImageAvatar.Add(item);
                        break;
                    case "Post":
                        lstImagePost.Add(item);
                        break;
                }
            }
            avatarTable.DataSource = lstImageAvatar;
            avatarTable.DataBind();
            Session["lstImageAvatar"] = lstImageAvatar;

            postTable.DataSource = lstImagePost;
            postTable.DataBind();
            Session["lstImagePost"] = lstImagePost;
        }

        protected void search_ServerClick(object sender, EventArgs e)
        {
            var str = inputSearch.Value;
            if (string.IsNullOrEmpty(str))
                return;

            lstImageAvatar = new ObservableCollection<Images>();
            lstImagePost = new ObservableCollection<Images>();
            foreach (var item in ImageService.Gets())
            {
                if (item.Name.ToLower().Contains(str))
                {
                    switch(item.Style)
                    {
                        case "Avatar":
                            lstImageAvatar.Add(item);
                            break;
                        case "Post":
                            lstImagePost.Add(item);
                            break;
                    }
                }
            }
            avatarTable.DataSource = lstImageAvatar;
            avatarTable.DataBind();
            postTable.DataSource = lstImagePost;
            postTable.DataBind();
        }

        protected void btnConfirm_ServerClick(object sender, EventArgs e)
        {
            if (fileImage.PostedFile != null && fileImage.PostedFile.ContentLength > 0)
            {
                HttpPostedFile httpPostedFile = fileImage.PostedFile;

                string fileName = httpPostedFile.FileName;
                string fileExtension = Path.GetExtension(fileName);

                var name = inputName.Value;
                if (string.IsNullOrWhiteSpace(name))
                    name = Path.GetFileNameWithoutExtension(httpPostedFile.FileName);
                var size = Math.Round(httpPostedFile.ContentLength / 1024.0, 2).ToString();
                var style = "Post";
                var date = DateTime.Now;
                var summary = inputSummary.Value;

                string randomUrl = Ulti.GenerateHashedString("Post", 8);

                string id = ImageService.GetNewId();
                Images img = new Images()
                {
                    Id = id,
                    Name = name,
                    Url = "/images/Post_" + randomUrl + fileExtension,
                    Size = size,
                    Style = style,
                    IdReference = "",
                    CreateDate = date,
                    Summary = summary,
                    Status = true
                };
                string savePath = MapPath("~/images/Post_") + randomUrl + fileExtension;
                httpPostedFile.SaveAs(savePath);
                ImageService.Gets().Add(img);
                lstImagePost.Add(img);
                postTable.DataSource = lstImagePost;
                postTable.DataBind();
                //ImageService.Add(img);
            }
            fileImage = null;

            Response.Redirect(Request.Url.AbsoluteUri);
        }

        protected void ConfirmDelete_Command(object sender, CommandEventArgs e)
        {
            string itemId = Convert.ToString(e.CommandArgument);

            var item = lstImagePost.Where(x => x.Id.CompareTo(itemId) == 0).FirstOrDefault();
            var itemService = ImageService.Gets().Where(x => x.Id.CompareTo(itemId) == 0).FirstOrDefault();
            if (item == null)
                item = lstImageAvatar.Where(x => x.Id.CompareTo(itemId) == 0).FirstOrDefault();

            if (item == null)
                return;

            if (item.Status == true)
                item.Status = false;
            else
                item.Status = true;
            itemService.Status = item.Status;
            ImageService.UpdateStatus(itemService);
            Response.Redirect(Request.Url.AbsoluteUri);

        }
    }
}