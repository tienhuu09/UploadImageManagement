using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace UploadImage
{
    public class Document
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public string Url { get; set; }
        public string Type { get; set; }
        public string Size { get; set; }
        public string IdAccount { get; set; }
        public DateTime UploadDate { get; set; }
        public string Summary { get; set; }
        public bool Status { get; set; }
    }
}