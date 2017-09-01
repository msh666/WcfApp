using System.Collections.Generic;
using System.ServiceModel;
using System.ServiceModel.Web;
using IBSTestApp.Model;

namespace IBSTestApp
{
    // ПРИМЕЧАНИЕ. Команду "Переименовать" в меню "Рефакторинг" можно использовать для одновременного изменения имени интерфейса "IBookService" в коде и файле конфигурации.
    [ServiceContract]
    public interface IBloggingService
    {
        //USERS
        [OperationContract]
        [WebInvoke(Method = "GET", ResponseFormat = WebMessageFormat.Json, RequestFormat = WebMessageFormat.Json,
            UriTemplate = "Users/")]
        List<User> GetUsersList();

        [OperationContract]
        [WebInvoke(Method = "GET", ResponseFormat = WebMessageFormat.Json, RequestFormat = WebMessageFormat.Json,
            UriTemplate = "Users/{id}")]
        User GetUserById(string id);

        [OperationContract]
        [WebInvoke(Method = "PUT", ResponseFormat = WebMessageFormat.Json, RequestFormat = WebMessageFormat.Json,
            UriTemplate = "AddUser/")]
        string AddUser(User user);

        [OperationContract]
        [WebInvoke(Method = "PUT", ResponseFormat = WebMessageFormat.Json, RequestFormat = WebMessageFormat.Json,
            UriTemplate = "UpdateUser/{id}")]
        string UpdateUser(User user, string id);

        [OperationContract]
        [WebInvoke(Method = "DELETE", ResponseFormat = WebMessageFormat.Json, RequestFormat = WebMessageFormat.Json,
            UriTemplate = "DeleteUser/{id}")]
        string DeleteUser(string id);

        //BLOGS
        [OperationContract]
        [WebInvoke(Method = "GET", ResponseFormat = WebMessageFormat.Json, RequestFormat = WebMessageFormat.Json,
            UriTemplate = "Blogs/")]
        List<Blog> GetBlogsList();

        [OperationContract]
        [WebInvoke(Method = "GET", ResponseFormat = WebMessageFormat.Json, RequestFormat = WebMessageFormat.Json,
            UriTemplate = "Blogs/{id}")]
        Blog GetBlogById(string id);

        [OperationContract]
        [WebInvoke(Method = "PUT", ResponseFormat = WebMessageFormat.Json, RequestFormat = WebMessageFormat.Json,
            UriTemplate = "AddBlog/")]
        string AddBlog(Blog blog);

        [OperationContract]
        [WebInvoke(Method = "PUT", ResponseFormat = WebMessageFormat.Json, RequestFormat = WebMessageFormat.Json,
            UriTemplate = "UpdateBlog/{id}")]
        string UpdateBlog(Blog blog, string id);

        [OperationContract]
        [WebInvoke(Method = "DELETE", ResponseFormat = WebMessageFormat.Json, RequestFormat = WebMessageFormat.Json,
            UriTemplate = "DeleteBlog/{id}")]
        string DeleteBlog(string id);

        //POSTS
        [OperationContract]
        [WebInvoke(Method = "GET", ResponseFormat = WebMessageFormat.Json, RequestFormat = WebMessageFormat.Json,
            UriTemplate = "Posts/")]
        List<Post> GetPostsList();

        [OperationContract]
        [WebInvoke(Method = "GET", ResponseFormat = WebMessageFormat.Json, RequestFormat = WebMessageFormat.Json,
            UriTemplate = "Posts/{id}")]
        Post GetPostById(string id);

        [OperationContract]
        [WebInvoke(Method = "PUT", ResponseFormat = WebMessageFormat.Json, RequestFormat = WebMessageFormat.Json,
            UriTemplate = "AddPost/")]
        string AddPost(Post post);

        [OperationContract]
        [WebInvoke(Method = "PUT", ResponseFormat = WebMessageFormat.Json, RequestFormat = WebMessageFormat.Json,
            UriTemplate = "UpdatePost/{id}")]
        string UpdatePost(Post post, string id);

        [OperationContract]
        [WebInvoke(Method = "DELETE", ResponseFormat = WebMessageFormat.Json, RequestFormat = WebMessageFormat.Json,
            UriTemplate = "DeletePost/{id}")]
        string DeletePost(string id);
    }
}
