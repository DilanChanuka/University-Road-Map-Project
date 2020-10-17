using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Security.Cryptography.X509Certificates;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using MySql.Data.MySqlClient;
using RoadMap_DB.Data;
using RoadMap_DB.DataAccess;
using RoadMap_DB.Models;

namespace RoadMap_DB.Controllers
{
    public class GetDataController : Controller
    {
       
        [Route("GetData/Index")]
        public JsonResult Index()
        {
           
           // string constr = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            // using (MySqlConnection con=new MySqlConnection(MySqlDataAccess.GetConnectionString("DefaultConnection")))

            string sql = "SELECT  * FROM USERS ";
            JsonResult result=MySqlDataAccess.AccesData(sql, new User());

           // Console.Write(result);
            return new JsonResult(result);
        }

        [Route("GetData/DepartmentList")]
        public JsonResult DepartmentList()
        {

            string sql = "SELECT  * FROM department_lists ";
            JsonResult result = MySqlDataAccess.AccesData(sql, new Department_list());

            //Console.Write(result);
            return new JsonResult(result);

        }

        [Route("GetData/VRoute")]
        public JsonResult VRoute()
        {

            string sql = "SELECT  * FROM v_routes ";
            JsonResult result = MySqlDataAccess.AccesData(sql, new v_route());

           // Console.Write(result);
            return new JsonResult(result);

        }

        [Route("GetData/FRoute")]
        public JsonResult FRoute()
        {

            string sql = "SELECT  * FROM v_routes ";
            JsonResult result = MySqlDataAccess.AccesData(sql, new v_route());

            //Console.Write(result);
            return new JsonResult(result);

        }


        [Route("GetData/UserLocation")]
        public JsonResult UserLocation()
        {

            string sql = "SELECT  * FROM user_location ";
            JsonResult result = MySqlDataAccess.AccesData(sql, new User_location());

           // Console.Write(result);
            return new JsonResult(result);

        }

        [Route("GetData/Floor")]
        public JsonResult Floor()
        {

            string sql = "SELECT  * FROM floors ";
            JsonResult result = MySqlDataAccess.AccesData(sql, new Floor());

           // Console.Write(result);
            return new JsonResult(result);

        }
    }
}
