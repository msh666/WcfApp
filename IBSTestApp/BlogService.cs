using System.Collections.Generic;
using IBSTestApp.Controller;
using IBSTestApp.Model;

namespace IBSTestApp
{
    public partial class BloggingService
    {
        IBlogRepository blogRep = new BlogRepository();
        public List<Blog> GetBlogsList()
        {
            return blogRep.GetAllBlogs();
        }

        public Blog GetBlogById(string id)
        {
            return blogRep.GetBlogById(int.Parse(id));
        }

        public string AddBlog(Blog blog)
        {
            var newBlog = blogRep.AddNewBlog(blog);
            return "id=" + newBlog.BlogId;
        }

        public string UpdateBlog(Blog blog, string id)
        {
            var updated = blogRep.UpdateABlog(blog);
            if (updated)
                return "Blog with id = " + id + " updated successfully";
            return "Unable to update Blog with id = " + id;
        }

        public string DeleteBlog(string id)
        {
            var deleted = blogRep.DeleteABlog(int.Parse(id));
            if (deleted)
                return "Blog with id = " + id + " deleted successfully";
            return "Unable to delete Blog with id = " + id;
        }
    }
}