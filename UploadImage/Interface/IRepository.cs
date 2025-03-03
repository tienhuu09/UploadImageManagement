using System.Collections.Generic;

namespace UploadImage.Interface
{
    public interface IRepository<T>
    {
        void Load();
        void Add(T item);
        void Edit(T item);
        void Update(T item);
        void Delete(T item);
        T GetById(string id);
        List<T> Gets();
    }
}
