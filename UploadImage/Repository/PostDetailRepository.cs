using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using UploadImage.Interface;

namespace UploadImage
{
    public class PostDetailRepository : IRepository<PostDetail>
    {
        public List<PostDetail> lstPostDetail { get; set; }

        public PostDetailRepository()
        {
            lstPostDetail = new List<PostDetail>();
            Load();
        }

        public void Load()
        {
            DataProvider.Instance.Connect();

            string tSQL = "select * from PostDetails";
            SqlDataReader reader = DataProvider.Instance.GetReader(CommandType.Text, tSQL);
            if (reader == null)
            {
                DataProvider.Instance.Disconnect();
                return;
            }

            PostDetail postDetail = null;
            while (reader.Read())
            {
                postDetail = new PostDetail();
                postDetail.Id = Int32.Parse(reader["Id"].ToString());
                postDetail.IdPost = reader["IdPost"].ToString();
                postDetail.IdImage = reader["IdImage"].ToString();
                postDetail.Position = Int32.Parse(reader["Position"].ToString());
                postDetail.Status = bool.Parse(reader["Status"].ToString());
                lstPostDetail.Add(postDetail);
            }

            DataProvider.Instance.Disconnect();
        }

        public void Add(PostDetail item)
        {
            DataProvider.Instance.Connect();

            try
            {
                string tSql = "Insert into PostDetails Values(@Id, @IdPost, @IdImage)";

                DataProvider.Instance.parameters = new string[] { "Id", "IdPost", "IdImage" };
                DataProvider.Instance.values = new object[] { item.Id, item.IdPost, item.IdImage };

                DataProvider.Instance.ExcuteNonQuery(CommandType.Text, tSql);
            }
            catch (SqlException) { }

            lstPostDetail.Add(item);
            DataProvider.Instance.Disconnect();
        }

        public void Edit(PostDetail item)
        {
            throw new NotImplementedException();
        }

        public void Update(PostDetail item)
        {
            throw new NotImplementedException();
        }

        public void Delete(PostDetail item)
        {
            DataProvider.Instance.Connect();

            string tSql = "Delete from PostDetails where Id = @Id";

            DataProvider.Instance.parameters = new string[] { "Id" };
            DataProvider.Instance.values = new object[] { item.Id };

            DataProvider.Instance.ExcuteNonQuery(CommandType.Text, tSql);

            lstPostDetail.Remove(item);
            DataProvider.Instance.Disconnect();
        }

        public PostDetail GetById(string id)
        {
            var postDetail = lstPostDetail.Where(x => string.Compare(x.Id.ToString(), id, true) == 0).FirstOrDefault();
            return postDetail;
        }

        public List<PostDetail> Gets()
        {
            return lstPostDetail;
        }
    }
}