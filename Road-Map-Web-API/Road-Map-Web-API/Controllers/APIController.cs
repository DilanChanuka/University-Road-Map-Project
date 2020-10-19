using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json.Linq;
using Newtonsoft.Json;
using System.Text.Json;

namespace Road_Map_Web_API.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class APIController : Controller
    {  
        [HttpGet("{department}")]
        public IActionResult GetDepartment(string department)
        {
            return Json(new
            {
                latitude = 15.961329,
                longitude = 28.385640
            });

        }

        [HttpGet("{department}/{floor}")]
        public IActionResult GetFloor(string department, string floor)
        {
            return Json(new
            {
                latitude = 15.961329,
                longitude = 28.385640
            });
        }

        [HttpGet("{department}/{floor}/{place}")]
        public IActionResult GetPlace(string department, string floor,string place)
        {
            return Json(new
            {
                latitude = 15.961329,
                longitude = 28.385640
            });
        }

        [HttpGet]
        public IActionResult GetRoute(int start,int end)
        {
            //Calculations cal = new Calculations();
            //return Json(cal.GetFootRouteNumbers(start, end));
            return Json(new
            {
                latitude = 15.961329,
                longitude = 28.385640
            });
        }

        [HttpPost("{username}/{password}")]
        public string IdentifyUser(string username, string password)
        {
            string pwd = "123";
            if(pwd==password)
                return username + " Authenicated...!";
            else
                return username + " Incorrect password...!";
        }

        [HttpPost]
        public string RegisterUser([FromBody]User user)
        {
            return user.id +"\t"+ user.username +"\t"+ user.email+"\t Entered..!";
        }

        public string CalculateShortestPath(int place_1,int place_2)
        {
            return "done";
        }
    }
}
