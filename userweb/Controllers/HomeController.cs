using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using userweb.Models;
using userweb.Controllers;
namespace userweb.Controllers
{
    
    public class HomeController : Controller
    {
        private db_entities _db = new db_entities();
        // GET: Home
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult SecondPage()
        {
            return View();
        }
        public ActionResult Login()
        {
            return View();
        }
        [HttpPost]
        [ValidateAntiForgeryToken]

        public ActionResult Login(string username,string password)
        {
            if(ModelState.IsValid)
            {
                var data = _db.user.Where(s => s.username.Equals(username) && s.password.Equals(password)).ToList();
                if (data.Count() > 0)
                {
                    Session["username"] = data.FirstOrDefault().username;
                    Session["password"] = data.FirstOrDefault().password;
                    return RedirectToAction("SecondPage");
                }
                else
                {
                    ViewBag.error = "Login Failed";
                    return RedirectToAction("Login");
                }
            }
            else
            {
                ViewBag.error = "abc";
            }
            return View();
        }
    }
}