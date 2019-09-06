using Microsoft.EntityFrameworkCore;
using ProductCatalog.Models;
using Microsoft.EntityFrameworkCore.Metadata.Builders;


namespace ProductCatalog.Data.Maps
{
    public class CategoryMap : IEntityTypeConfiguration<Category>
    {
        public void Configure(EntityTypeBuilder<Category> builder)
        {
            builder.ToTable("Category");
            builder.HasKey(x => x.Id);
            builder.Property(x => x.Title)
                .IsRequired()
                .HasMaxLength(120)
                .HasColumnType("varchar(120)");
        }
    }
}