using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;
using UploadImage.Interface;

namespace UploadImage
{
    public class AccountRepository : IRepository<Account>
    {
        public List<Account> lstAccount { get; set; }

        public AccountRepository()
        {
            lstAccount = new List<Account>();
            Load();
        }

        public void Load()
        {
            DataProvider.Instance.Connect();

            string tSQl = "select * from Accounts";
            SqlDataReader reader = DataProvider.Instance.GetReader(CommandType.Text, tSQl);

            Account account = null;
            while (reader.Read())
            {
                account = new Account();
                account.Id = reader["Id"].ToString();
                account.Name = reader["Name"].ToString();
                account.Username = reader["Username"].ToString();
                account.Password = reader["Password"].ToString();
                account.RoleAccount = reader["RoleAccount"].ToString();
                account.AccountInfo = new AccountInfo();
                account.lstPost = new List<Post>();
                lstAccount.Add(account);
            }

            DataProvider.Instance.Disconnect();
        }

        public void Add(Account item)
        {
            DataProvider.Instance.Connect();
            try
            {
                string tSql = "Insert into Accounts Values(@Id, @Name, @Username, @Password, @RoleAccount)";

                DataProvider.Instance.parameters = new string[] { "Id", "Name", "Username", "Password", "RoleAccount" };
                DataProvider.Instance.values = new object[] { item.Id, item.Name, item.Username, item.Password, item.RoleAccount };

                DataProvider.Instance.ExcuteNonQuery(CommandType.Text, tSql);
            }
            catch (Exception) { }

            lstAccount.Add(item);
            DataProvider.Instance.Disconnect();
        }

        public void Delete(Account item)
        {
            throw new NotImplementedException();
        }

        public void Edit(Account item)
        {
            throw new NotImplementedException();
        }

        public Account GetById(string id)
        {
            return lstAccount.Where(x => string.Compare(x.Id, id, true) == 0).FirstOrDefault();
        }

        public List<Account> Gets()
        {
            return lstAccount;
        }

        public void Update(Account item)
        {
            throw new NotImplementedException();
        }
    }
}