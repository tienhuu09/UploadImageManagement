using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;
using System.Web.WebSockets;
using UploadImage.Interface;

namespace UploadImage
{
    public class AccountInfoRepository : IRepository<AccountInfo>
    {
        public List<AccountInfo> lstAccountInfo { get; set; }

        public AccountInfoRepository()
        {
            lstAccountInfo = new List<AccountInfo>();
            Load();
        }

        public void Load()
        {
            DataProvider.Instance.Connect();

            string tSQl = "select * from AccountInfos";
            SqlDataReader reader = DataProvider.Instance.GetReader(CommandType.Text, tSQl);

            AccountInfo accountInfo = null;
            while (reader.Read())
            {
                accountInfo = new AccountInfo();
                accountInfo.IdAccount = reader["IdAccount"].ToString();
                accountInfo.Address = reader["Address"].ToString();
                accountInfo.PhoneNumber = reader["PhoneNumber"].ToString();
                accountInfo.CreateDate = (DateTime)reader["CreateDate"];
                accountInfo.IdImage = reader["IdImage"].ToString();
                accountInfo.Image = new Images();
                lstAccountInfo.Add(accountInfo);
            }

            DataProvider.Instance.Disconnect();
        }

        public void Add(AccountInfo item)
        {
            DataProvider.Instance.Connect();

            try
            {
                string tSql = "Insert into AccountInfos Values(@IdAccount, @Address, @PhoneNumber, @CreateDate, @IdImage)";

                DataProvider.Instance.parameters = new string[] { "IdAccount", "Address", "PhoneNumber", "CreateDate", "IdImage" };
                DataProvider.Instance.values = new object[] { item.IdAccount, item.Address, item.PhoneNumber, item.CreateDate, item.IdImage };

                DataProvider.Instance.ExecuteScalar(CommandType.Text, tSql);
            } catch (Exception) { }

            lstAccountInfo.Add(item);
            DataProvider.Instance.Disconnect();
        }

        public void Delete(AccountInfo item)
        {
            throw new NotImplementedException();
        }

        public void Edit(AccountInfo item)
        {
            var acc = GetById(item.IdAccount);
            acc.IdImage = item.IdImage;
            acc.Image = item.Image;

            DataProvider.Instance.Connect();
            try
            {
                string tSQL = "UPDATE AccountInfos " +
                            "SET IdImage = @IdImage " +
                            "WHERE IdAccount = @IdAccount";
                DataProvider.Instance.parameters = new string[] { "IdImage", "IdAccount" };
                DataProvider.Instance.values = new object[] { item.IdImage, item.IdAccount };

                DataProvider.Instance.ExcuteNonQuery(CommandType.Text, tSQL);
            }
            catch (SqlException) { }

            DataProvider.Instance.Disconnect();
        }

        public AccountInfo GetById(string id)
        {
            return lstAccountInfo.Where(x => string.Compare(x.IdAccount, id, true) == 0).FirstOrDefault();
        }

        public List<AccountInfo> Gets()
        {
            return lstAccountInfo;
        }

        public void Update(AccountInfo item)
        {
            DataProvider.Instance.Connect();

            string tSQL = "UPDATE AccountInfos " +
                        "SET IdImage = @IdImage " +
                        "WHERE IdAccount = @IdAccount";
            DataProvider.Instance.parameters = new string[] { "IdImage", "IdAccount" };
            DataProvider.Instance.values = new object[] { item.IdImage, item.IdAccount };

            DataProvider.Instance.ExcuteNonQuery(CommandType.Text, tSQL);

            DataProvider.Instance.Disconnect();
        }
    }
}