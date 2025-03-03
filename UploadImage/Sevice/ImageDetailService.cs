using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using UploadImage.Interface;

namespace UploadImage
{
    public class ImageDetailService
    {
        private static readonly UnitOfWork unitOfWork = new UnitOfWork();

        public IRepository<ImageDetail> ImageDetailRepository { get; set; }

        public ImageDetailService()
        {
            ImageDetailRepository = unitOfWork.ImageDetailRepository;
        }
    }
}