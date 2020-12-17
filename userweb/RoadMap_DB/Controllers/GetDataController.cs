using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Security.Cryptography.X509Certificates;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Routing;
using MySql.Data.MySqlClient;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using RoadMap_DB.Data;
using RoadMap_DB.DataAccess;
using RoadMap_DB.Models;


namespace RoadMap_DB.Controllers
{
    public class GetDataController : Controller
    {
        public static  ApplicationDBContext _db;

        public GetDataController(ApplicationDBContext db)
        {
            _db = db;
        }
       
        [Route("GetData/userview")]
        public string userview(string name,string pwd)// view User
        {
           
           // string constr = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            // using (MySqlConnection con=new MySqlConnection(MySqlDataAccess.GetConnectionString("DefaultConnection")))

            string sql = "SELECT name,email,type,pwd FROM roadmap_db.users " +
                "where name='"+name+ "' and pwd='" + pwd + "';";
            string[] data = MySqlDataAccess.GetUser(sql);

            //create json data
            return JsonConvert.SerializeObject(data);
            

        }

        [Route("GetData/DepartmentList")]
        public JsonResult DepartmentList()
        {

            string sql = "SELECT  * FROM department_lists ";
            JsonResult result = MySqlDataAccess.AccesData(sql, new Department_list());

            Console.Write(result);
            return new JsonResult(result);

        }

        [Route("GetData/VertextLocation")]
        public string VertextLocation(int id)
        {
            Vertext_Location[] vertexts = _db.vertext_Locations.Where((v) =>v.id==id).ToArray();
            string json = System.Text.Json.JsonSerializer.Serialize(vertexts);
            Console.Write(json);
            return json;

        }

        [Route("GetData/VRoute")]
        public IActionResult VRoute()
        {
            
           // int[] data = LocationData.GetDepartmentAndFloor(1); // this is a sample

            Dictionary<string, double[]> data = LocationData.GetFloorPlaces(10,20);

            return View();
        }

        [Route("GetData/FRoute")]
        public IActionResult FRoute()
        {
            //double[,] data = LocationData.GetFootRoute(20);
            return View();
        }

        [Route("GetData/InnerRoute")]
        public IActionResult InnerRoute()
        {
            
            return View();
        }


        [Route("GetData/Floor")]
        public IActionResult Floor()//places
        {
            return View();
        }
    }
}