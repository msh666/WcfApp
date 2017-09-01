using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using IBSTestApp.Controller;
using IBSTestApp.Model;

namespace IBSTestApp
{
    public partial class BloggingService
    {
        IPostRepository postRep = new PostRepository();
        public List<Post> GetPostsList()
        {
            return postRep.GetAllPosts();
        }

        public Post GetPostById(string id)
        {
            return postRep.GetPostById(int.Parse(id));
        }

        public string AddPost(Post blog)
        {
            var newPost = postRep.AddNewPost(blog);
            return "id=" + newPost.PostId;
        }

        public string UpdatePost(Post post, string id)
        {
            var updated = postRep.UpdateAPost(post);
            if (updated)
                return "Post with id = " + id + " updated successfully";
            return "Unable to update Post with id = " + id;
        }

        public string DeletePost(string id)
        {
            var deleted = postRep.DeleteAPost(int.Parse(id));
            if (deleted)
                return "Post with id = " + id + " deleted successfully";
            return "Unable to delete Post with id = " + id;
        }
    }
}