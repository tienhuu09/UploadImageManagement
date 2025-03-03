using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace UploadImage
{
    public partial class DocumentData : System.Web.UI.Page
    {
        public DocumentService DocumentService { get; set; }
        public ObservableCollection<Document> lstDocument { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            DocumentService = new DocumentService();
            lstDocument = new ObservableCollection<Document>(DocumentService.Gets());

            var item = (UploadImage.Account)Session["Account"];

            if (item == null || item.RoleAccount != "Admin")
                Response.Redirect("~/Views/SignIn/Login.aspx");

            var flag = Session["flag"];
            if (flag != null)
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "AddedSuccess()", true);
                Session["flag"] = null;
            }
            gridDocument.DataSource = lstDocument;
            gridDocument.DataBind();
        }

        protected void btnfileDocument_Click(object sender, EventArgs e)
        {
            if (lstDocument == null)
                lstDocument = new ObservableCollection<Document>();

            string jsonData = hfTableData.Value;
            List<string> tableData = null;
            if (!string.IsNullOrEmpty(jsonData))
            {
                tableData = Newtonsoft.Json.JsonConvert.DeserializeObject<List<string>>(jsonData);
            }

            for (int i = 0; i < Request.Files.Count; i++)
            {
                HttpPostedFile file = Request.Files[i];

                if (file != null && file.ContentLength > 0)
                {
                    string fileName = file.FileName;
                    string fileExtension = Path.GetExtension(file.FileName);
                    string fileNameOriginals = Path.GetFileNameWithoutExtension(file.FileName);
                    double fileSizeInKb = Math.Round(file.ContentLength / 1024.0, 2);

                    string urlRandom = Ulti.GenerateHashedString("Document", 16);

                    string summary = tableData[i];
                    
                    var acc = Session["Account"] as Account;
                    Document document = new Document()
                    {
                        Id = DocumentService.GetNewId(),
                        Title = fileNameOriginals,
                        Url = "/files/" + urlRandom + fileExtension,
                        Type = fileExtension,
                        Size = fileSizeInKb.ToString(),
                        UploadDate = DateTime.Now,
                        IdAccount = acc.Id,
                        Summary = summary,
                        Status = true
                    };

                    if (DocumentService.CheckUrlExisted(document.Url))
                    {
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "NotificationUrlExisted()", true);
                        continue;
                    }


                    string savePath = MapPath("~/files/") + urlRandom + fileExtension;
                    file.SaveAs(savePath);

                    lstDocument.Add(document);
                    DocumentService.Add(document);
                }
            }
            gridDocument.DataSource = lstDocument;
            gridDocument.DataBind();

            //////////////////
            Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "AddedSuccess()", true);
            Response.Redirect("~/Views/Admin/DocumentData.aspx");
        }

        protected void removeDoc_ServerClick(object sender, EventArgs e)
        {
            var button = sender as HtmlButton;
             if (button != null)
            {
                int id = Int32.Parse(button.Attributes["data-id"]);
                Document doc = DocumentService.Get(id);

                if (doc != null)
                {
                    lstDocument.Remove(doc);
                    DocumentService.Remove(id);

                    string notify = "Deleted successfully!!";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + notify + "');", true);

                    Response.Redirect("~/Views/Admin/DocumentData.aspx");

                }
            }
        }

        protected void search_ServerClick(object sender, EventArgs e)
        {
            lstDocument = new ObservableCollection<Document>();
            var str = inputSearch.Value.ToLower();
            foreach (var item in DocumentService.Gets())
            {
                if (item.Title.ToLower().Contains(str))
                {
                    lstDocument.Add(item);
                }
            }
            gridDocument.DataSource = lstDocument;
            gridDocument.DataBind();
        }
    }
}