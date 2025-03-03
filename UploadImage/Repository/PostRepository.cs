using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using UploadImage.Interface;
using System.Web.UI.WebControls;

namespace UploadImage
{
    public class PostRepository : IRepository<Post>
    {
        public List<Post> lstPost { get; set; }

        public PostRepository()
        {
            lstPost = new List<Post>();
            Load();
        }

        public void Load()
        {
            DataProvider.Instance.Connect();

            string tSQL = "select * from Posts";
            SqlDataReader reader = DataProvider.Instance.GetReader(CommandType.Text, tSQL);
            if (reader == null)
            {
                DataProvider.Instance.Disconnect();
                return;
            }

            Post post = null;
            while (reader.Read())
            {
                post = new Post();
                post.lstImage = new List<Images>();
                post.Id = reader["Id"].ToString();
                post.Title = reader["Title"].ToString();
                post.IdAccount = reader["IdAccount"].ToString();
                post.QuantityImage = Int32.Parse(reader["QuantityImage"].ToString());
                post.CreateDate = (DateTime)reader["CreateDate"];
                post.lstPostDetail = new List<PostDetail>();
                post.Status = bool.Parse(reader["Status"].ToString());

                lstPost.Add(post);
            }

            DataProvider.Instance.Disconnect();
        }

        public void Add(Post item)
        {
            DataProvider.Instance.Connect();

            try
            {
                string tSql = "Insert into Posts Values(@Id, @IdAccount, @QuantityImage, @CreateDate)";

                DataProvider.Instance.parameters = new string[] { "Id", "IdAccount", "QuantityImage", "CreateDate" };
                DataProvider.Instance.values = new object[] { item.Id, item.IdAccount, item.QuantityImage, item.CreateDate };

                DataProvider.Instance.ExcuteNonQuery(CommandType.Text, tSql);
            }
            catch (SqlException) { }
            lstPost.Add(item);
            DataProvider.Instance.Disconnect();
        }

        public void Edit(Post item)
        {
            throw new NotImplementedException();
        }

        public void Update(Post item)
        {
            DataProvider.Instance.Connect();

            try
            {
                string tSql = "Update Posts Set QuantityImage = @QuantityImage where Id = @Id";

                DataProvider.Instance.parameters = new string[] { "QuantityImage", "Id" };
                DataProvider.Instance.values = new object[] { item.QuantityImage, item.Id };

                DataProvider.Instance.ExcuteNonQuery(CommandType.Text, tSql);
            }
            catch(SqlException) { }

            DataProvider.Instance.Disconnect();
        }

        public void Delete(Post item)
        {
            DataProvider.Instance.Connect();

            string tSql = "Delete from Posts where Id = @Id";

            DataProvider.Instance.parameters = new string[] { "Id" };
            DataProvider.Instance.values = new string[] { item.Id };

            DataProvider.Instance.ExcuteNonQuery(CommandType.Text, tSql);

            lstPost.Remove(item);

            DataProvider.Instance.Disconnect();
        }

        public Post GetById(string id)
        {
            var post = lstPost.Where(x => string.Compare(x.Id, id, true) == 0).FirstOrDefault();
            return post;
        }

        public List<Post> Gets()
        {
            return lstPost;
        }
    }
}