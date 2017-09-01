using System.Data.Entity;

namespace IBSTestApp.Model
{
    public class BloggingContext : DbContext
    {
        public DbSet<User> Users { get; set; }
        public DbSet<Blog> Blogs { get; set; }
        public DbSet<Post> Posts { get; set; }
    }
}