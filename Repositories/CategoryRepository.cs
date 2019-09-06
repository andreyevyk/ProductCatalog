using System.Collections.Generic;
using System.Linq;
using Microsoft.EntityFrameworkCore;
using ProductCatalog.Data;
using ProductCatalog.Models;
using ProductCatalog.ViewModels.ProductsViewModels;

namespace ProductCatalog.Repositories
{
    public class CategoryRepository
    {
         private readonly StoreDataContext _context;
        
        public CategoryRepository(StoreDataContext context) 
        { 
            _context = context;
        }
        public IEnumerable<Category> Get()
        {
            return _context.Categories.AsNoTracking().ToList();
        }
        public Category GetById(int id)
        {
            return _context.Categories.Find(id);
        }

        public IEnumerable<Product> GetProductsByCategoryId(int id)
        {
            return _context.Products.AsNoTracking().Where(x =>x.CategoryId == id);
        }

        public void Save(Category category){
            _context.Categories.Add(category);
            _context.SaveChanges();
        }

        public void Update(Category category){
            _context.Entry<Category>(category).State = EntityState.Modified;
            _context.SaveChanges();
        }
        public void Delete(Category category){
            _context.Remove(category);
            _context.SaveChanges();
        }
    }
}