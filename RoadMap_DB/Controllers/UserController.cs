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
        public void setuser(string name,string email,string type,string pwd)//Register user
        {
            //insert User Data
            User u = new User()
            {
                name=name,
                email=email,
                type=type,
                pwd=pwd
            };

            _db.users.Add(u);
            _db.SaveChanges();
            //return View();
        }
    }
}