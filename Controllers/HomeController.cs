using System.Collections.Generic;
using System.Linq;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ProductCatalog.Data;
using ProductCatalog.Models;
using ProductCatalog.Repositories;

namespace ProductCatalog.Controllers
{
    public class HomeController : Controller{
    
        [HttpGet]
        [Route("")]
        public object Get()
        {
            return new { version = "Version 0.0.2" };

        }

    }
} 