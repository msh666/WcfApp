using System.Collections.Generic;
using IBSTestApp.Model;

namespace IBSTestApp.Controller
{
    public interface IBlogRepository
    {
        List<Blog> GetAllBlogs();
        Blog GetBlogById(int id);
        Blog AddNewBlog(Blog item);
        bool DeleteABlog(int id);
        bool UpdateABlog(Blog item);
    }
}