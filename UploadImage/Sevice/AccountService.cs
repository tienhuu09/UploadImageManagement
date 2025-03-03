using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using UploadImage.Interface;

namespace UploadImage
{
    public class AccountService
    {
        private static readonly UnitOfWork unitOfWork = new UnitOfWork();
        private IRepository<Account> accountRepo { get; set; }

        public AccountService()
        {
            accountRepo = unitOfWork.AccountRepository;
        }

        public List<Account> Gets()
        {
            return accountRepo.Gets();
        }

        public Account GetAccount(string username, string password)
        {
            foreach (var item in unitOfWork.AccountRepository.Gets())
            {
                if (string.Compare(username, item.Username, true) == 0 &&
                    string.Compare(password, item.Password, true) == 0)
                    return item;
            }
            return null;
        }

        public string getNewId()
        {
            string id = null;
            int num = Gets().Count() + 1;
            do
            {
                if (num <= 9)
                    id = "A0" + num;
                else
                    id = "A" + num;
                num += 1;
            } while (accountRepo.GetById(id) != null);
            return id;
        }

        public void Add(Account account)
        {
            accountRepo.Add(account);
            unitOfWork.AccountInfoRepository.Add(account.AccountInfo);
        }

        public Account Get(string id)
        {
            return accountRepo.GetById(id);
        }

        public bool CheckUsername(string username)
        {
            foreach (var acc in Gets())
                if (string.Compare(acc.Username, username, true) == 0)
                    return true;
            return false;
        }

        public static string getName(string id)
        {
            return unitOfWork.AccountRepository.GetById(id).Name;
        }
    }
}