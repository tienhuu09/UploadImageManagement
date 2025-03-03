using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using UploadImage.Interface;

namespace UploadImage
{
    public class AccountInfoService
    {
        private static readonly UnitOfWork unitOfWork = new UnitOfWork();
        public IRepository<AccountInfo> accountInfoRepo { get; set; }
        
        public AccountInfoService()
        {
            accountInfoRepo = unitOfWork.AccountInfoRepository;
        }

        public void Update(AccountInfo accountInfo)
        {
            accountInfoRepo.Update(accountInfo);
        }
    }
}