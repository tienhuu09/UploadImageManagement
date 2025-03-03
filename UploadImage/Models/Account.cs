using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace UploadImage
{
    public class Account
    {
        public string Id { get; set; }
        public string Name { get; set; }
        public string Username { get; set; }
        public string Password { get; set; }
        public string RoleAccount { get; set; }
        public AccountInfo AccountInfo { get; set; }
        public List<Post> lstPost { get; set; }
    }
}