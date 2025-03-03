using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using UploadImage.Interface;

namespace UploadImage
{
    public class DocumentService
    {
        private static readonly UnitOfWork unitOfWork = new UnitOfWork();
        public IRepository<Document> DocumentRepository { get; set; }

        public DocumentService()
        {
            DocumentRepository = unitOfWork.DocumentRepository; 
        }

        public int GetNewId()
        {
            return Gets().Count() + 1;
        }

        public Document Get(int id)
        {
            return DocumentRepository.GetById(id.ToString());
        }

        public List<Document> Gets()
        {
            return DocumentRepository.Gets();
        }

        public void Add(Document document)
        {
            DocumentRepository.Add(document);
        }

        public bool CheckUrlExisted(string url)
        {
            var item = DocumentRepository.Gets().Where(x => string.Compare(x.Url.ToLower(), url.ToLower(), true) == 0).FirstOrDefault();
            if (item != null)
                return true;
            return false;
        }

        public void Remove(int id)
        {
            var item = Get(id);
            DocumentRepository.Delete(item);
        }
    }
}