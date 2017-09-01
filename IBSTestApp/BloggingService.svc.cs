using System.Collections.Generic;
using IBSTestApp.Controller;
using IBSTestApp.Model;

namespace IBSTestApp
{
    public partial class BloggingService : IBloggingService
    {
        static IBloggingRepository repository = new BloggingRepository();

        public List<User> GetUsersList()
        {
            return repository.GetAllUsers();
        }

        public User GetUserById(string id)
        {
            return repository.GetUserById(int.Parse(id));
        }

        public string AddUser(User user)
        {
            var newUser = repository.AddNewUser(user);
            return "id=" + newUser.UserId;
        }

        public string UpdateUser(User user, string id)
        {
            var updated = repository.UpdateAUser(user);
            if (updated)
                return "User with id = " + id + " updated successfully";
            return "Unable to update User with id = " + id;
        }

        public string DeleteUser(string id)
        {
            var deleted = repository.DeleteAUser(int.Parse(id));
            if (deleted)
                return "User with id = " + id + " deleted successfully";
            return "Unable to delete User with id = " + id;
        }
    }
}
