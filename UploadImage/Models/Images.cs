using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Web.UI;

namespace UploadImage
{
    public class Images
    {
        [Key]
        public string Id { get; set; }
        public string Name { get; set; }
        public string Url { get; set; }
        public string Size { get; set; }
        public string Style { get; set; }
        public string IdReference { get; set; }
        public DateTime CreateDate { get; set; }
        public string Summary { get; set; }
        public bool Status { get; set; }

        public List<ImageDetail> lstImageDetails { get; set; }
    }
}