using System.Collections.Generic;
using IBSTestApp.Model;

namespace IBSTestApp.Controller
{
    public interface IPostRepository
    {
        List<Post> GetAllPosts();
        Post GetPostById(int id);
        Post AddNewPost(Post item);
        bool DeleteAPost(int id);
        bool UpdateAPost(Post item);
    }
}