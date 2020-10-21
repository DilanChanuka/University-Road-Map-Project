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
        private readonly ApplicationDBContext _db;

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
        public string VRoute(int id)
        {

            string sql = "SELECT lat,lng FROM roadmap_db.v_routes where v_route_id="+id+";";
            double[,] array = MySqlDataAccess.VRoutes(sql);

            //create json data
            return JsonConvert.SerializeObject(array);

            //v_route[] routes = _db.v_Routes.Where((r) => r.v_route_id==id).ToArray();
            //string json = System.Text.Json.JsonSerializer.Serialize(routes);
            ////Console.Write(json);
            //return json;

        }

        [Route("GetData/FRoute")]
        public string FRoute(int id)
        {

            string sql = "SELECT lat,lng FROM roadmap_db.f_routes where f_route_id="+id+";";
            double[,] array = MySqlDataAccess.FRoute(sql);

            //create json data
            string json = JsonConvert.SerializeObject(array);
            Console.Write(json);
            return json;
        }

        [Route("GetData/UserLocation")]
        public JsonResult UserLocation()
        {

            string sql = "SELECT  * FROM user_location ";
            JsonResult result = MySqlDataAccess.AccesData(sql, new User_location());

            //Console.Write(result);
            return new JsonResult(result);

        }

        [Route("GetData/InnerRoute")]
        public string InnerRoute(int id)
        {
            string sql = "SELECT lat,lng FROM roadmap_db.inner_routes where in_r_id="+id+";";
            double[,] array = MySqlDataAccess.InnerRoute(sql);

            //create json data
            string json = JsonConvert.SerializeObject(array);
            return json;

        }


        [Route("GetData/Floor")]
        public string Floor(int dept_id,int floor_id)//places
        {

            string sql = "SELECT name,lat,lng FROM roadmap_db.floors" +
                " where floor_id="+floor_id+" and f_dept_id="+dept_id+";";
            double[,] data = MySqlDataAccess.GetFloor(sql);

            //create json data
            Console.Write(JsonConvert.SerializeObject(data));
            return JsonConvert.SerializeObject(data);
            
        }

        [Route("GetData/Dept_places")]
        public string Dept_place(int dept_id,int placeID)  //place
        {

            string sql = "SELECT lat,lng FROM roadmap_db.depaerment_places " +
                "where dept_id="+dept_id+" and id="+placeID+";";

            double[] data = MySqlDataAccess.Dept_place(sql);

            //create json data
            return JsonConvert.SerializeObject(data);

        }
    }
}