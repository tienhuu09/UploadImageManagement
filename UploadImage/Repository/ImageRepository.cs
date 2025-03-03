using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Security.Policy;
using System.Web;
using System.Web.UI.WebControls;
using System.Xml.Linq;
using UploadImage.Interface;

namespace UploadImage
{
    public class ImageRepository : IRepository<Images>
    {
        public List<Images> lstImage { get; set; }

        public ImageRepository()
        {
            lstImage = new List<Images>();
            Load();
        }

        public void Load()
        {
            DataProvider.Instance.Connect();

            string tSQL = "select * from Images";
            SqlDataReader reader = DataProvider.Instance.GetReader(CommandType.Text, tSQL);
            if (reader == null)
            {
                DataProvider.Instance.Disconnect();
                return;
            }

            Images image = new Images();
            while (reader.Read())
            {
                image = new Images();
                image.Id = reader["Id"].ToString();
                image.Name = reader["Name"].ToString();
                image.Url = reader["Url"].ToString();
                image.Size = reader["Size"].ToString();
                image.Style = reader["Style"].ToString();
                image.IdReference = reader["IdReference"].ToString();
                image.CreateDate = (DateTime)reader["CreateDate"];
                image.Summary = reader["Summary"].ToString();
                image.Status = bool.Parse(reader["Status"].ToString());

                image.lstImageDetails = new List<ImageDetail>();
                lstImage.Add(image);
            }

            DataProvider.Instance.Disconnect();
        }

        public void Add(Images item)
        {
            DataProvider.Instance.Connect();
            lstImage.Add(item);

            try
            {
                string tSQL = "Insert into Images Values(@Id, @Name, @Url, @Size, @Style, @IdReference, @CreateDate, @Summary)";

                DataProvider.Instance.parameters = new string[] { "Id", "Name", "Url", "Size", "Style", "IdReference", "CreateDate", "Summary" };
                DataProvider.Instance.values = new object[] { item.Id, item.Name, item.Url, item.Size, item.Style, item.IdReference, item.CreateDate, item.Summary };

                DataProvider.Instance.ExcuteNonQuery(CommandType.Text, tSQL);
            }
            catch (SqlException) { }

            DataProvider.Instance.Disconnect();
        }

        public void Edit(Images item)
        {
            throw new NotImplementedException();
        }

        public void Update(Images item)
        {
            DataProvider.Instance.Connect();

            string tSql = "Update Images" +
                " set Status = @Status" +
                " where Id = @Id";

            DataProvider.Instance.parameters = new string[] { "Id", "Status" };
            DataProvider.Instance.values = new object[] { item.Id, item.Status };

            DataProvider.Instance.ExcuteNonQuery(CommandType.Text, tSql);
            Images entity = lstImage.Where(x => string.Compare(x.Id, item.Id, true) == 0).FirstOrDefault();
            entity.Status = item.Status;

            DataProvider.Instance.Disconnect();
        }

        public void Delete(Images item)
        {
            DataProvider.Instance.Connect();

            string tSql = "Delete from Images where Id = @Id";
            DataProvider.Instance.parameters = new string[] { "Id" };
            DataProvider.Instance.values = new object[] { item.Id };

            DataProvider.Instance.ExcuteNonQuery(CommandType.Text, tSql);

            lstImage.Remove(item);
            DataProvider.Instance.Disconnect();
        }

        public Images GetById(string id)
        {
            return lstImage.Where(x => string.Compare(x.Id, id, true) == 0).FirstOrDefault();
        }

        public List<Images> Gets()
        {
            return lstImage;
        }
    }
}