using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;

namespace UploadImage
{
    public class Ulti
    {
        public static string spec = "#,##0đ"; /* specifier */
        public static string spec2 = "#,##0"; /* specifier */
        public static string doubleText = "0.00 'Kb'";
        public static string date = "dd/MM/yyyy HH:mm:ss";
        public static string date2 = "dd/MM/yyyy";
        public static string date3 = "dd, 'month' MM, 'year' yyyy";
        public static string date4 = "dd-MM-yyyy HH:mm tt";
        public static string product = "# product";

        public static string GenerateHashedString(string input, int length = 8)
        {
            string timestamp = DateTime.UtcNow.ToString("yyyyMMddHHmmssffff");
            string uniqueInput = input + timestamp;

            using (var sha256 = System.Security.Cryptography.SHA256.Create())
            {
                byte[] hashBytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(uniqueInput));
                return BitConverter.ToString(hashBytes).Replace("-", "").Substring(0, length);
            }
        }

        public static string randomCharacter(int length = 16)
        {
            var chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
            var output = new StringBuilder();
            var random = new Random();
            for (int i = 0; i < length; i++)
            {
                output.Append(chars[random.Next(chars.Length)]);
            }
            return output.ToString();
        }
    }
}