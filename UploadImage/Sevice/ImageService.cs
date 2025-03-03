using System;
using System.Collections.Generic;
using System.Data.Entity.Core.Metadata.Edm;
using System.Drawing.Design;
using System.IO;
using System.Linq;
using System.Web;
using UploadImage.Interface;

namespace UploadImage
{
    public class ImageService
    {
        public event EventHandler update;

        private static readonly UnitOfWork unitOfWork = new UnitOfWork();
        public IRepository<Images> ImageRepo { get; set; }

        public ImageService()
        {
            ImageRepo = unitOfWork.ImageRepository;
        }

        public Images Get(string id)
        {
            return ImageRepo.GetById(id);
        }

        public List<Images> Gets()
        {
            return unitOfWork.ImageRepository.Gets();
        }

        public bool CheckUrlExisted(Images img)
        {
            var item = ImageRepo.Gets().Where(x => string.Compare(x.Url.ToLower(), img.Url.ToLower(), true) == 0).FirstOrDefault();
            if (item != null)
                return true;
            return false;
        }

        public void AddImageAndSetAccount(Images image, Account account)
        {
            if (ImageRepo.GetById(image.Id) == null)
            {
                unitOfWork.ImageRepository.Add(image);
                account.AccountInfo.IdImage = image.Id;
                account.AccountInfo.Image = image;
                unitOfWork.AccountInfoRepository.Edit(account.AccountInfo);

                update.Invoke(account, EventArgs.Empty);
            }
        }

        public void Add(Images image)
        {
            if (ImageRepo.GetById(image.Id) == null)
            {
                ImageRepo.Gets().Add(image);
                unitOfWork.ImageRepository.Add(image);
            }
        }

        public void UpdateStatus(Images image)
        {
            ImageRepo.Update(image);
        }

        public Images GetByUrl(string url)
        {
            var lstImage = Gets();
            return lstImage.Where(x => string.Compare(x.Url, url, true) == 0).FirstOrDefault();
        }

        public string GetNewId()
        {
            string id = null;
            int num = Gets().Count() + 1;
            do
            {
                if (num <= 9)
                    id = "I0" + num;
                else
                    id = "I" + num;
                num += 1;
            } while (ImageRepo.GetById(id) != null);
            return id;
        }

        public string CreateUrl(string randomUrl, string fileExtension)
        {
            return "/images/Post_" + randomUrl + fileExtension;
        }

        public bool checkUrl(string url)
        {
            var item = Gets().Where(x => string.Compare(url.ToLower(), x.Url.ToLower(), true) == 0).FirstOrDefault();
            if (item != null)
                return true;
            return false;
        }

        public PostDetail GetByIdImage(string id)
        {
            var lstPostDetail = unitOfWork.PostDetailRepository.Gets();
            var postDetail = lstPostDetail.Where(x => string.Compare(x.IdImage, id, true) == 0).FirstOrDefault();
            return postDetail;
        }

        public void Delete(Images image, Account account)
        {
            PostDetail postDetail = GetByIdImage(image.Id);
            Post post = unitOfWork.PostRepository.GetById(postDetail.IdPost);
            post.QuantityImage -= 1;
            if (string.Compare(account.AccountInfo.IdImage, image.Id, true) == 0)
            {
                account.AccountInfo.IdImage = "empty";
                unitOfWork.AccountInfoRepository.Update(account.AccountInfo);
            }

            unitOfWork.PostDetailRepository.Delete(postDetail);
            unitOfWork.PostRepository.Update(post);
            if (post.QuantityImage <= 0)
            {
                account.lstPost.Remove(post);
                unitOfWork.PostRepository.Delete(post);
            }
            else
            {
                post.lstPostDetail.Remove(postDetail);
            }
            post.lstImage.Remove(image);
            ImageRepo.Delete(image);
            string str2 = HttpContext.Current.Server.MapPath(image.Url);
            //new HttpServerUtility(HttpContext.Current.Server).MapPath;
            string str = "D:/VS-2022/UploadImage/UploadImage/" + image.Url;
            File.Delete(str2);
        }

        public bool CheckUrl(string str)
        {
            string url = ("/images/") + str;

            foreach (var img in Gets())
                if (string.Compare(img.Url, url, true) == 0)
                    return true;
            return false;
        }

        public static string getUrl(string id)
        {
            return unitOfWork.ImageRepository.GetById(id).Url;
        }

        public static string getSize(string id)
        {
            return unitOfWork.ImageRepository.GetById(id).Size;
        }

        public static string getStatus(string id)
        {
            return unitOfWork.ImageRepository.GetById(id).Status.ToString(); 
        }
    }
}