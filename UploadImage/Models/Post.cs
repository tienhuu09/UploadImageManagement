using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace UploadImage
{
    public class Post
    {
        [Key]
        public string Id { get; set; }
        public string Title { get; set; }
        public string IdAccount { get; set; }
        public int QuantityImage { get; set; }
        public DateTime CreateDate { get; set; }
        public bool Status { get; set; }

        public List<Images> lstImage { get; set; }
        public List<PostDetail> lstPostDetail { get; set; }
    }
}