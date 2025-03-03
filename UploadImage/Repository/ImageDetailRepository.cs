using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using UploadImage.Interface;
using System.Security.Cryptography.X509Certificates;

namespace UploadImage
{
    public class ImageDetailRepository : IRepository<ImageDetail>
    {
        public List<ImageDetail> lstImageDetail { get; set; }

        public ImageDetailRepository()
        {
            lstImageDetail = new List<ImageDetail>();
            Load();
        }

        public void Load()
        {
            DataProvider.Instance.Connect();

            string tSQL = "select * from ImageDetails";
            SqlDataReader reader = DataProvider.Instance.GetReader(CommandType.Text, tSQL);
            if (reader == null)
            {
                DataProvider.Instance.Disconnect();
                return;
            }

            ImageDetail imageDetail = null;
            while (reader.Read())
            {
                imageDetail = new ImageDetail();
                imageDetail.Id = int.Parse(reader["Id"].ToString());
                imageDetail.IdImage = reader["IdImage"].ToString();
                imageDetail.Style = reader["Style"].ToString();
                imageDetail.IdReference = reader["IdReference"].ToString();
                imageDetail.CreateDate = (DateTime)reader["CreateDate"];
                imageDetail.Status = bool.Parse(reader["Status"].ToString());

                lstImageDetail.Add(imageDetail);
            }

            DataProvider.Instance.Disconnect();
        }

        public void Add(ImageDetail item)
        {
            DataProvider.Instance.Connect();

            try
            {
                string tSql = "Insert into ImageDetails Values(@Id, @IdImage, @Style, @IdReference, @CreateDate, @Status)";

                DataProvider.Instance.parameters = new string[] { "Id", "IdImage", "Style", "IdReference", "CreateDate", "Status" };
                DataProvider.Instance.values = new object[] { item.Id, item.IdImage, item.Style, item.IdReference, item.CreateDate, item.Status};

                DataProvider.Instance.ExcuteNonQuery(CommandType.Text, tSql);
            }
            catch (SqlException) { }

            lstImageDetail.Add(item);
            DataProvider.Instance.Disconnect();
        }

        public void Delete(ImageDetail item)
        {
            throw new NotImplementedException();
        }

        public void Edit(ImageDetail item)
        {
            throw new NotImplementedException();
        }

        public ImageDetail GetById(string id)
        {
            return lstImageDetail.Where(x => string.Compare(x.Id.ToString(), id, true) == 0).FirstOrDefault();
        }

        public List<ImageDetail> Gets()
        {
            return lstImageDetail;
        }

        public void Update(ImageDetail item)
        {
            throw new NotImplementedException();
        }
    }
}