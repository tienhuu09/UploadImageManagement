using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography.X509Certificates;
using System.Web;
using UploadImage.Interface;

namespace UploadImage
{
    public class UnitOfWork
    {
        private static IRepository<Account> _AccountRepository;
        public IRepository<Account> AccountRepository
        {
            get
            {
                if (_AccountRepository == null)
                    _AccountRepository = new AccountRepository();
                return _AccountRepository;
            }
            set
            {
                _AccountRepository = value;
            }
        }

        private static IRepository<AccountInfo> _AccountInfoRepository;
        public IRepository<AccountInfo> AccountInfoRepository
        {
            get
            {
                if (_AccountInfoRepository == null)
                    _AccountInfoRepository = new AccountInfoRepository();
                return _AccountInfoRepository;
            }
            set
            {
                _AccountInfoRepository = value;
            }
        }

        public static IRepository<Images> _ImageRepository;
        public IRepository<Images> ImageRepository
        {
            get
            {
                if (_ImageRepository == null)
                    _ImageRepository = new ImageRepository();
                return _ImageRepository;
            }
            set
            {
                _ImageRepository = value;
            }
        }

        public static IRepository<ImageDetail> _ImageDetailRepository;
        public IRepository <ImageDetail> ImageDetailRepository
        {
            get
            {
                if (_ImageDetailRepository == null)
                    _ImageDetailRepository = new ImageDetailRepository();
                return _ImageDetailRepository;
            }
            set
            {
                _ImageDetailRepository = value;
            }
        }

        public static IRepository<Post> _PostRepository;
        public IRepository<Post> PostRepository
        {
            get
            {
                if (_PostRepository == null)
                    _PostRepository = new PostRepository();
                return _PostRepository;
            }
            set
            {
                _PostRepository = value;
            }
        }

        private static IRepository<PostDetail> _PostDetailRepository;
        public IRepository<PostDetail> PostDetailRepository
        {
            get
            {
                if (_PostDetailRepository == null)
                    _PostDetailRepository = new PostDetailRepository();
                return _PostDetailRepository;
            }
            set
            {
                _PostDetailRepository = value;
            }
        }

        private static IRepository<Document> _DocumentRepository;
        public IRepository<Document> DocumentRepository
        {
            get
            {
                if ( _DocumentRepository == null)
                    _DocumentRepository = new DocumentRepository();
                return _DocumentRepository;
            }
            set
            {
                _DocumentRepository = value;
            }
        }

        public void LoadPost()
        {
            foreach (var post in PostRepository.Gets())
            {
               var postDetails = PostDetailRepository.Gets().FindAll(x => string.Compare(x.IdPost, post.Id, true) == 0);

                foreach (var item in postDetails)
                {
                    post.lstPostDetail.Add(item);
                    var image = ImageRepository.GetById(item.IdImage);
                    post.lstImage.Add(image);
                }
            }

            Parameter.Load = true;
        }

        public void LoadImage()
        {
            foreach (var account in AccountRepository.Gets())
            {
                account.AccountInfo = AccountInfoRepository.GetById(account.Id);
            }

            foreach (var accountInfo in AccountInfoRepository.Gets())
            {
                if (string.Compare(accountInfo.IdImage, "empty", true) == 0)
                    continue;
                accountInfo.Image = ImageRepository.GetById(accountInfo.IdImage);
            }
        }

        public void LoadPostToAccount()
        {
            foreach (var account in AccountRepository.Gets())
            {
                foreach (var post in PostRepository.Gets())
                {
                    if (string.Compare(account.Id, post.IdAccount, true) == 0)
                    {
                        account.lstPost.Add(post);
                        continue;
                    }
                }
                account.lstPost.Reverse();
            }
        }

        public void LoadImageDetail()
        {
            foreach(var image in ImageRepository.Gets())
            {
                var imageDetail = ImageDetailRepository.Gets().FindAll(x => string.Compare(x.IdImage, image.Id, true) == 0);
                foreach (var item in imageDetail)
                {
                    image.lstImageDetails.Add(item);
                }
            }
        }

        public UnitOfWork()
        {
            if (!Parameter.Load)
            {
                LoadPost();
                LoadImage();
                LoadPostToAccount();
                LoadImageDetail();
            }
        }
    }
}