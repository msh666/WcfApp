using System.Collections.Generic;
using IBSTestApp.Model;

namespace IBSTestApp.Controller
{
    public interface IBloggingRepository
    {
        List<User> GetAllUsers();
        User GetUserById(int id);
        User AddNewUser(User item);
        bool DeleteAUser(int id);
        bool UpdateAUser(User item);
    }
}