using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace UploadImage
{
    public class PostDetail
    {
        [Key]
        public int Id { get; set; }
        public string IdPost { get; set; }
        public string IdImage { get; set; }
        public int Position { get; set; }        // Quantity Order
        public bool Status { get; set; }
    }
}