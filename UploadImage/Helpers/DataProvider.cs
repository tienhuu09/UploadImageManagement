using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace UploadImage
{
    public class DataProvider
    {
        #region Singleton
        private static readonly object Instancelock = new object();

        private static DataProvider _Instance;
        public static DataProvider Instance
        {
            get
            {
                lock (Instancelock)
                {
                    if (_Instance == null)
                        _Instance = new DataProvider();
                }
                return _Instance;
            }
        }
        #endregion
        public SqlConnection connn { get; set; }

        string connStr = ConfigurationManager.ConnectionStrings["ImageDbContext"].ConnectionString;
        public SqlConnection conn { get; set; }
        public SqlCommand cmd { get; set; }
        public SqlDataReader reader { get; set; }
        public string[] parameters { get; set; }
        public object[] values { get; set; }

        public void Connect()
        {
            try
            {
                if (conn == null)
                {
                    conn = new SqlConnection(connStr);
                }

                if (conn.State == ConnectionState.Open)
                {

                }
                else
                {
                    conn.Open();
                }
            }
            catch (SqlException)
            {
                //MessageBox.Show(ex.Message);
            }
        }

        public void Disconnect()
        {
            if (conn?.State == ConnectionState.Closed)
            {
            }
            else
            {
                conn?.Close();
            }
        }

        public SqlCommand GetParameters(CommandType cmdType, string tSQL)
        {
            cmd = new SqlCommand(tSQL, conn);
            cmd.CommandType = cmdType;
            if (parameters != null && values != null)
            {
                for (int i = 0; i < parameters.Length; i++)
                {
                    cmd.Parameters.AddWithValue("@" + parameters[i], values[i]);
                }
            }
            return cmd;
        }

        public object ExecuteScalar(CommandType cmdType, string tSQL)
        {
            object data = 0;
            try
            {
                Connect();
                cmd = new SqlCommand(tSQL, conn);
                cmd = GetParameters(cmdType, tSQL);
                data = cmd.ExecuteScalar();
            }
            catch (SqlException)
            {
                //MessageBox.Show("Error Generated. Details: " + ex.ToString());
            }
            finally
            {
                Disconnect();
            }
            return data;
        }

        public int ExcuteNonQuery(CommandType cmdType, string tSQL)
        {
            int nRow = -1;
            try
            {
                Connect();
                cmd = GetParameters(cmdType, tSQL);
                nRow = cmd.ExecuteNonQuery();
            }
            catch (SqlException)
            {
                //MessageBox.Show("Error Generated. Details: " + ex.ToString());
            }
            finally
            {
                Disconnect();
            }
            return nRow;
        }

        public int ExecuteNonQuery(CommandType cmdType, string tSQL, SqlParameter parameter)
        {
            int nRows = -1;
            try
            {
                Connect();
                cmd = GetParameters(cmdType, tSQL);
                // add thêm 1 parameter              
                cmd.Parameters.Add(parameter);
                nRows = cmd.ExecuteNonQuery();
            }
            catch (SqlException)
            {
                //MessageBox.Show("Error generated details: " + ex.ToString());
            }
            finally
            {
                Disconnect();
            }
            return nRows;
        }

        public SqlDataReader GetReader(CommandType cmdType, string tSQL)
        {
            try
            {
                Connect();
                cmd = GetParameters(cmdType, tSQL);
                reader = cmd.ExecuteReader();
                if (reader.HasRows)
                    return reader; // lấy 1 bảng 
                Disconnect();
            }
            catch (SqlException)
            {
                //MessageBox.Show("Error Generated Details: " + ex.ToString());
            }
            return null;
        }
    }

}