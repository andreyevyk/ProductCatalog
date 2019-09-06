using System;

namespace ProductCatalog.Models {
    public class Product {
        public int Id { get; set; }
        public string Tittle { get; set; }
        public string Description { get; set; }
        public int Quantity { get; set; }
        public decimal Price { get; set; }
        public string Image { get; set; }
        public DateTime CreateDate { get; set; }
        public DateTime LastUpdateDate { get; set; }
        public int CategoryId { get; set; }
        public virtual Category Category { get; set; }
    }
}