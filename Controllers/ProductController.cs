using System;
using System.Collections.Generic;
using System.Linq;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ProductCatalog.Models;
using ProductCatalog.Repositories;
using ProductCatalog.ViewModels;
using ProductCatalog.ViewModels.ProductsViewModels;

namespace ProductCatalog.Controllers
{
    public class ProductController : ControllerBase
    {
       
        private readonly ProductRepository _repository;
        
        public ProductController(ProductRepository repository) 
        { 
            _repository = repository;
        }

        [Route("v1/products")]
        [HttpGet]
        public IEnumerable<ListProductViewModel> Get()
        {
            return _repository.Get();

        }

        [Route("v1/products/{id}")]
        [HttpGet]
        public Product GetById(int id)
        {
            return _repository.GetById(id);
        }

        [Route("v1/products")]
        [HttpPost]
        public ResultViewModel Post([FromBody]EditorProductViewModel model) 
        { 
            model.Validate();
            if(model.Invalid)
                return new ResultViewModel
                {
                    Sucess = false,
                    Message = "Não foi possicel cadastrar o produto",
                    Data = model.Notifications
                };
            var product = new Product(){
                Tittle = model.Title,
                CategoryId = model.CategoryId,
                CreateDate = DateTime.Now,
                Description = model.Description,
                Image = model.Image,
                LastUpdateDate = DateTime.Now,
                Price = model.Price,
                Quantity = model.Quantity
            };
            
            _repository.Save(product);

            return new ResultViewModel
            {
                Sucess = true,
                Message = "Produto cadastrado com sucesso",
                Data = product
            };
            
        }

        [Route("v2/products")]
        [HttpPost]
        public ResultViewModel Post([FromBody]Product product) 
        { 
            _repository.Save(product);

            return new ResultViewModel
            {
                Sucess = true,
                Message = "Produto cadastrado com sucesso",
                Data = product
            };
            
        }

        [Route("v1/products")]
        [HttpPut]
        public ResultViewModel Put([FromBody]EditorProductViewModel model) 
        { 
            model.Validate();
            if(model.Invalid)
                return new ResultViewModel
                {
                    Sucess = false,
                    Message = "Não foi possicel cadastrar o produto",
                    Data = model.Notifications
                };
            var product = _repository.GetById(model.Id);
            product.Tittle = model.Title;
            product.CategoryId = model.CategoryId;
            product.CreateDate = DateTime.Now;
            product.Description = model.Description;
            product.Image = model.Image;
            product.LastUpdateDate = DateTime.Now;
            product.Price = model.Price;
            product.Quantity = model.Quantity;
            
            _repository.Update(product);

            return new ResultViewModel
            {
                Sucess = true,
                Message = "Produto cadastrado com sucesso",
                Data = product
            };

        }


        [Route("v1/products")]
        [HttpDelete]
        public Product Delete([FromBody] Product product) { 
            if(ModelState.IsValid)
            {
               _repository.Delete(product);
            }
            return product;
        }
    }
}