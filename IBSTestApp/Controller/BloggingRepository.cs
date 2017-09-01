using System;
using System.Collections.Generic;
using System.Linq;
using IBSTestApp.Model;

namespace IBSTestApp.Controller
{
    public class BloggingRepository : IBloggingRepository
    {
        BloggingContext db = new BloggingContext();

        public BloggingRepository()
        {
            DbInitializer init = new DbInitializer();
            init.InitializeDatabase(new BloggingContext());
        }

        //CRUD Operations
        //1. CREAT
        public User AddNewUser(User newUser)
        {
            if (newUser == null)
                throw new ArgumentNullException(nameof(newUser));
            db.Users.Add(newUser);
            db.SaveChanges();
            return newUser;
        }

        //2. RETRIEVE /ALL
        public List<User> GetAllUsers()
        {
            return db.Users.ToList();
        }

        //2. RETRIEVE
        public User GetUserById(int userId)
        {
            return db.Users.Find(userId);
        }

        //3. UPDATE
        public bool UpdateAUser(User updatedUser)
        {
            if (updatedUser == null)
                throw new ArgumentNullException(nameof(updatedUser));
            var user = db.Users.Find(updatedUser.UserId);
            if (user == null)
                return false;
            user.Name = updatedUser.Name;
            db.SaveChanges();
            return true;
        }

        //4. DELETE
        public bool DeleteAUser(int userId)
        {
            var user = db.Users.Find(userId);
            if (user == null)
                return false;
            db.Users.Remove(user);
            db.SaveChanges();
            return true;
        }
    }
}