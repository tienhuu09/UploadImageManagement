using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using UploadImage.Interface;

namespace UploadImage
{
    public class PostService
    {
        private static readonly UnitOfWork unitOfWork = new UnitOfWork();
        public IRepository<Post> postRepo { get; set; }
        public PostDetailService postDetailService { get; set; }

        public PostService()
        {
            postRepo = unitOfWork.PostRepository;
            postDetailService = new PostDetailService();
        }

        public List<Post> Gets()
        {
            return postRepo.Gets();
        }

        public Post GetById(string id)
        {
            return postRepo.GetById(id);
        }

        public string GetNewId()
        {
            string id;
            int num = Gets().Count() + 1;
            do
            {
                if (num <= 9)
                    id = "P0" + num;
                else
                    id = "P" + num;
                num += 1;
            } while (postRepo.GetById(id) != null);
            return id;
        }

        public void AddAvatar(Images image, Account account)
        {
            Post post = new Post
            {
                Id = GetNewId(),
                IdAccount = account.Id,
                CreateDate = DateTime.Now,
                lstImage = new List<Images>(),
                lstPostDetail = new List<PostDetail>(),
                QuantityImage = 1
            };
            post.lstImage.Add(image);

            PostDetail postDetail = new PostDetail
            {
                Id = postDetailService.GetNewId(),
                IdPost = post.Id,
                IdImage = image.Id
            };

            post.lstPostDetail.Add(postDetail);
            account.lstPost.Reverse();
            account.lstPost.Add(post);
            account.lstPost.Reverse();
            unitOfWork.PostRepository.Add(post);  
            unitOfWork.PostDetailRepository.Add(postDetail);
        }

        public void Add(Post post)
        {
            if (postRepo.GetById(post.Id) == null)
            {
                postRepo.Add(post);
                var acc = unitOfWork.AccountRepository.GetById(post.IdAccount);
                acc.lstPost.Reverse();
                acc.lstPost.Add(post);
                acc.lstPost.Reverse();
                foreach (var postDetail in post.lstPostDetail)
                {
                    unitOfWork.PostDetailRepository.Add(postDetail);
                }
            }
        }
    }
}