using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using UploadImage.Interface;

namespace UploadImage
{
    public class PostDetailService
    {
        private static readonly UnitOfWork unitOfWork = new UnitOfWork();
        public IRepository<PostDetail> postDetailRepo { get; set; }

        public PostDetailService()
        {
            postDetailRepo = unitOfWork.PostDetailRepository;
        }

        public List<PostDetail> Gets()
        {
            return postDetailRepo.Gets();
        }

        public PostDetail GetById(string id)
        {
            return postDetailRepo.GetById(id);
        }

        public int GetNewId()
        {
            int id = Gets().Count;
            int num = 0;
            do
            {
                id += num;
                num++;
            } while (GetById(id.ToString()) != null);
            return id;
        }

        public int GetNewId(int number)
        {
            int id;
            int num = Gets().Count() + number;
            do
            {
                id = num;
                num += 1;
            } while (GetById(id.ToString()) != null);
            return id;
        }

        public void Add(PostDetail item)
        {
            postDetailRepo.Gets().Add(item);
            //postDetailRepo.Add(item);
        }
    }
}