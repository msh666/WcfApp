using System;
using System.Collections.Generic;
using System.Linq;
using IBSTestApp.Model;

namespace IBSTestApp.Controller
{
    public class PostRepository : IPostRepository
    {
        BloggingContext db = new BloggingContext();

        //CRUD Operations
        //1. CREAT
        public Post AddNewPost(Post newPost)
        {
            if (newPost == null)
                throw new ArgumentNullException(nameof(newPost));
            newPost.PublicationDate = DateTime.Now;
            db.Posts.Add(newPost);
            db.SaveChanges();
            return newPost;
        }

        //2. RETRIEVE /ALL
        public List<Post> GetAllPosts()
        {
            var a = db.Posts.ToList();
            return db.Posts.ToList();
        }

        //2. RETRIEVE
        public Post GetPostById(int postId)
        {
            return db.Posts.Find(postId);
        }

        //3. UPDATE
        public bool UpdateAPost(Post updatedPost)
        {
            if (updatedPost == null)
                throw new ArgumentNullException(nameof(updatedPost));
            var post = db.Posts.Find(updatedPost.PostId);
            if (post  == null)
                return false;
            post.Title = updatedPost.Title;
            post.Content = updatedPost.Content;
            post.PublicationDate = DateTime.Now;
            db.SaveChanges();
            return true;
        }

        //4. DELETE
        public bool DeleteAPost(int postId)
        {
            var post = db.Posts.Find(postId);
            if (post == null)
                return false;
            db.Posts.Remove(post);
            db.SaveChanges();
            return true;
        }
    }
}