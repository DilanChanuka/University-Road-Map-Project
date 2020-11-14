using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using RoadMap_DB.Data;
using RoadMap_DB.Models;

namespace RoadMap_DB.Controllers
{
    public class UserController : Controller
    {

        private readonly ApplicationDBContext _db;

        public UserController(ApplicationDBContext db)
        {
            this._db = db;
        }


        [Route("User/setuser")]
        public string setuser(string name, string email, string pwd)//Register user
        {
            if (SetUser(name, email, pwd))
                return "Done";
            else
                return "Not Done";
        }

        public bool SetUser(string username, string email, string password)
        {
            User u = new User()
            {
                name = username,
                email = email,
                pwd = password,

            };

            try
            {
                _db.users.Add(u);
                _db.SaveChanges();
                return true;
            }
            catch { }
            return false;
        }

    }
}