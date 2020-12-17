using Newtonsoft.Json;
using RoadMap_DB.Controllers;
using RoadMap_DB.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace RoadMap_DB.DataAccess
{
    public class LocationData
    {
        public static double[,] GetFloorLocations(int departmentID, int floorID)
        {
            string sql = "SELECT lat,lng FROM roadmap_db.floors" +
                " where floor_id=" + floorID + " and f_dept_id=" + departmentID + ";";

            return MySqlDataAccess.GetFloor(sql);

        }

        public static Dictionary<string, double[]> GetFloorPlaces(int departmentID, int floorID)
        {
            string sql = "SELECT name,lat,lng FROM roadmap_db.floors " +
                "where f_dept_id=" + departmentID + " and floor_id=" + floorID + ";";

            return MySqlDataAccess.GetFloorplaces(sql);

        }

        public static double[,] GetVehicleRoute(int routeNo)
        {
            string sql = "SELECT lat,lng FROM roadmap_db.v_routes " +
                "where v_route_id=" + routeNo + ";";

            return MySqlDataAccess.VRoutes(sql);


            //v_route[] routes = _db.v_Routes.Where((r) => r.v_route_id==id).ToArray();
            //string json = System.Text.Json.JsonSerializer.Serialize(routes);
        
        }

        public static double[] GetVertexLoaction(int graphNo, int vertexNo)
        {
            string sql = "SELECT lat,lng FROM roadmap_db.vertext_locations " +
                "where graph_No="+ graphNo + " and vertex_No="+ vertexNo + " ;";

            return MySqlDataAccess.GetVertex(sql);
        }

        public static double[,] GetFootRoute(int routeNo)
        {
            string sql = "SELECT lat,lng FROM roadmap_db.f_routes" +
                " where f_route_id=" + routeNo + ";";

            return MySqlDataAccess.FRoute(sql);
        }

        public static int[] GetDepartmentAndFloor(int placeID)
        {
            string sql = "SELECT dept_id,d_floor_id " +
                "FROM roadmap_db.depaerment_places where id="+placeID+";";

            return MySqlDataAccess.DeptAndFloorID(sql);  //first value is depart id and 
                                                         //second value is floor id
        }

        public static double[,] GetEntranceLocations(int departmentID, int floorID)
        {
            string sql = "SELECT  lat,lng FROM roadmap_db.entrances " +
                "where dept_id="+departmentID+" and floor_ID="+floorID+";";

            return MySqlDataAccess.GetEntryLocation(sql);

        }

        public static double[,] GetInnerRoute(int graphNo, int routeNo)
        {
            string sql = "SELECT lat,lng FROM roadmap_db.inner_routes" +
                " where in_r_id=" + routeNo + " and graph_No="+graphNo+";";

            return MySqlDataAccess.InnerRoute(sql);

        }

        public static bool GetUserIdentity(string username, string password)
        {
            String sql = "SELECT name,pwd FROM roadmap_db.users " +
                "where name='"+ username + "' and pwd="+password+";";

            string[] data = MySqlDataAccess.GetIdentity(sql);
            if (data[0] == username && data[1] == password)
                return true;
            else
                return false;
        }

        public static double[] GetPlace(int placeID)
        {
            string sql = "SELECT lat,lng FROM roadmap_db.depaerment_places " +
                "where id="+placeID+" ;";

            return MySqlDataAccess.GetOnePlace(sql);
        }

        public static Dictionary<string, double[]> GetPlaceWithName(int placeID)
        {
            string sql = "SELECT place_name,lat,lng " +
                "FROM roadmap_db.depaerment_places where id="+placeID+";";

            return MySqlDataAccess.GetplaceAndName(sql);
        }

        public static bool SetUser(string username, string email, string password)
        {
            User u = new User()
            {
                name = username,
                email=email,
                pwd=password,
               
            };

            try
            {
                GetDataController._db.users.Add(u);
                GetDataController._db.SaveChanges();
                return true;
            }
            catch { }
            return false;
        }


    }
}

