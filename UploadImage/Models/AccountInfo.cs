using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace UploadImage
{
    public class AccountInfo
    {
        public string IdAccount { get; set; }
        public string Address { get; set; }
        public string PhoneNumber { get; set; }
        public DateTime CreateDate { get; set; }
        public string IdImage { get; set; }
        public Images Image { get; set; }
    }
}