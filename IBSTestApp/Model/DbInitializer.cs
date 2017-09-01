using System;
using System.Data.Entity;

namespace IBSTestApp.Model
{
    public class DbInitializer : CreateDatabaseIfNotExists<BloggingContext>
    {
        protected override void Seed(BloggingContext db)
        {
            db.Users.Add(new User {Name = "John"});
            db.Users.Add(new User {Name = "Julia"});
            db.Users.Add(new User {Name = "Anthony"});

            db.Blogs.Add(new Blog {Name = "Awesome blog", Url = "www.myawesomeblog.com", UserId = 1});
            db.Blogs.Add(new Blog {Name = "MyBlog", Url = "www.myblog.com", UserId = 3});
            db.Blogs.Add(new Blog {Name = "BeautyBlog", Url = "www.beauty.com", UserId = 2});

            db.Posts.Add(new Post
            {
                BlogId = 1,
                Title = "Hi ALL",
                Content = "Hello, It's me and my AWESOME blog",
                PublicationDate = DateTime.Now
            });
            db.Posts.Add(new Post
            {
                BlogId = 2,
                Title = "My first post",
                Content = "It is my first post in my new blog, Hi all and welcome",
                PublicationDate = DateTime.Now
            });
            db.Posts.Add(new Post
            {
                BlogId = 3,
                Title = "New cool makeup way",
                Content = "Hello everyone and today I tell you about new way pf makeupping",
                PublicationDate = DateTime.Now
            });

            base.Seed(db);
        }
    }
}