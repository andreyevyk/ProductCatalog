using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.OpenApi.Models;
using ProductCatalog.Data;
using ProductCatalog.Repositories;

namespace ProductCatalog
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        public void ConfigureServices(IServiceCollection services)
        {

            services.AddMvc();
            services.AddResponseCompression();
            services.AddScoped<StoreDataContext, StoreDataContext>();
            services.AddTransient<ProductRepository, ProductRepository>();
            services.AddTransient<CategoryRepository, CategoryRepository>();

            services.AddSwaggerGen(x => {
                x.SwaggerDoc("v1",new OpenApiInfo { Title = "Andrey Teste", Version = "v1"});
            });

            var connection = Configuration["ConnectionStrings"];
            services.AddDbContext<StoreDataContext>(options =>
                options.UseSqlServer(connection)
            );
        }
        public void Configure(IApplicationBuilder app, IHostingEnvironment env)
        {
            if (env.IsDevelopment())
                app.UseDeveloperExceptionPage();

                app.UseMvc(); 
                app.UseResponseCompression();
                app.UseSwagger();
                app.UseSwaggerUI(c =>
                    c.SwaggerEndpoint("/swagger/v1/swagger.json", "Andrey Teste v1")
                );
        }
    }
}
