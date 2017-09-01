using System;
using System.Collections.Generic;
using System.Linq;
using IBSTestApp.Model;

namespace IBSTestApp.Controller
{
    public class BlogRepository : IBlogRepository
    {
        BloggingContext db = new BloggingContext();

        //CRUD Operations
        //1. CREAT
        public Blog AddNewBlog(Blog newBlog)
        {
            if (newBlog == null)
                throw new ArgumentNullException(nameof(newBlog));
            db.Blogs.Add(newBlog);
            db.SaveChanges();
            return newBlog;
        }

        //2. RETRIEVE /ALL
        public List<Blog> GetAllBlogs()
        {
            return db.Blogs.ToList();
        }

        //2. RETRIEVE
        public Blog GetBlogById(int blogId)
        {
            return db.Blogs.Find(blogId);
        }

        //3. UPDATE
        public bool UpdateABlog(Blog updatedBlog)
        {
            if (updatedBlog == null)
                throw new ArgumentNullException(nameof(updatedBlog));
            var blog = db.Blogs.Find(updatedBlog.BlogId);
            if (blog == null)
                return false;
            blog.Name = updatedBlog.Name;
            blog.Url = updatedBlog.Url;
            db.SaveChanges();
            return true;
        }

        //4. DELETE
        public bool DeleteABlog(int blogId)
        {
            var blog = db.Blogs.Find(blogId);
            if (blog == null)
                return false;
            db.Blogs.Remove(blog);
            db.SaveChanges();
            return true;
        }
    }
}