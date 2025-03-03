using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using UploadImage.Interface;

namespace UploadImage
{
    public class DocumentRepository : IRepository<Document>
    {
        public List<Document> lstDocument { get; set; }

        public DocumentRepository()
        {
            lstDocument = new List<Document>();
            Load();
        }

        public void Load()
        {
            DataProvider.Instance.Connect();

            string tSQL = "select * from Document";
            SqlDataReader reader = DataProvider.Instance.GetReader(CommandType.Text, tSQL);
            if (reader == null)
            {
                DataProvider.Instance.Disconnect();
                return;
            }

            Document document = null;
            while (reader.Read())
            {
                document = new Document();
                document.Id = int.Parse(reader["Id"].ToString());
                document.Title = reader["Title"].ToString();
                document.Url = reader["Url"].ToString();
                document.Type = reader["Type"].ToString();
                document.Size = reader["Size"].ToString();
                document.IdAccount = reader["IdAccount"].ToString();
                document.UploadDate = (DateTime)reader["UploadDate"];
                document.Summary = reader["Summary"].ToString();
                document.Status = bool.Parse(reader["Status"].ToString());

                lstDocument.Add(document);
            }

            DataProvider.Instance.Disconnect();
        }

        public void Add(Document item)
        {
            DataProvider.Instance.Connect();

            try
            {
                string tSql = "Insert into Document Values(@Title, @Url, @Type, @Size, @IdAccount, @UploadDate, @Summary, @Status) SELECT SCOPE_IDENTITY();";

                DataProvider.Instance.parameters = new string[] {"Title", "Url", "Type", "Size", "IdAccount", "UploadDate", "Summary", "Status" };
                DataProvider.Instance.values = new object[] { item.Title, item.Url, item.Type, item.Size, item.IdAccount, item.UploadDate, item.Summary, item.Status };

                //DataProvider.Instance.ExcuteNonQuery(CommandType.Text, tSql);
                object result = DataProvider.Instance.ExecuteScalar(CommandType.Text, tSql);
                int convert = Convert.ToInt32(result);
                item.Id = convert;
            }
            catch (SqlException) { }
            lstDocument.Add(item);

            DataProvider.Instance.Disconnect();
        }

        public void Delete(Document item)
        {
            DataProvider.Instance.Connect();

            try
            {
                string tSql = "Delete from Document Where Id=@Id";
                DataProvider.Instance.parameters = new string[] { "Id" };
                DataProvider.Instance.values = new object[] { item.Id };

                DataProvider.Instance.ExecuteScalar(CommandType.Text, tSql);
            }
            catch (SqlException) { }
            lstDocument.Remove(item);

            DataProvider.Instance.Disconnect();
        }

        public void Edit(Document item)
        {
            throw new NotImplementedException();
        }

        public Document GetById(string id)
        {
            return lstDocument.Where(x => string.Compare(x.Id.ToString(), id, true) == 0).FirstOrDefault();
        }

        public List<Document> Gets()
        {
            return lstDocument;
        }

        public void Update(Document item)
        {
            throw new NotImplementedException();
        }
    }
}