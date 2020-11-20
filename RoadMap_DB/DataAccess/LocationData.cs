using Microsoft.AspNetCore.Routing;
using Microsoft.EntityFrameworkCore.Internal;
using Microsoft.VisualStudio.Web.CodeGeneration.Contracts.Messaging;
using Newtonsoft.Json;
using RoadMap_DB.Controllers;
using RoadMap_DB.Data;
using RoadMap_DB.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Threading.Tasks;

namespace RoadMap_DB.DataAccess
{
    public class LocationData
    {
        #region GEOLOCATION
        public static double[,] GetFloorLocations(int departmentID, int floorID)
        {
           
            var location = new List<Location>();
            int n = 0;

            try
            {
                location = (from f in GetDataController._db.floors
                            join l in GetDataController._db.location
                            on f.f_location_id equals l.location_id
                            where f.floor_id == floorID & f.f_dept_id == departmentID
                            select l).ToList();
            }
            catch(Exception ex)
            {

            }

            n = location.Count;
            double[,] arr = new double[n, 2];

            if (location.Count>0)
            {
                
                for (int i = 0; i < n; i++)
                {
                    arr[i, 0] = location[i].lat_value;
                    arr[i, 1] = location[i].lng_value;
                }
            }
            
            return arr;

        }

        public static Dictionary<string, double[]> GetFloorPlaces(int departmentID, int floorID)
        {
            var placeAlocation = new List<Location>();
            Dictionary<String, double[]> places = new Dictionary<string, double[]>();
            int n = 0;

            try
            {
                placeAlocation = (from f in GetDataController._db.floors
                                  join l in GetDataController._db.location
                                  on f.f_location_id equals l.location_id
                                  where f.floor_id == floorID & f.f_dept_id == departmentID
                                  select l).ToList();

                n = placeAlocation.Count;
            }catch(Exception e)
            {

            }

            if(placeAlocation.Count>0)
            {
                for (int i = 0; i < n; i++)
                {
                    double lat = placeAlocation[i].lat_value;
                    double lng = placeAlocation[i].lng_value;
                    places.Add(placeAlocation[i].location_name, new double[] { lat, lng });
                }
            }


            return places;

        }

        public static double[,] GetVehicleRoute(int routeID)
        {
            
            var location = new List<Location>();
            int n = 0;

            try
            {
                location = (from v in GetDataController._db.vehicle_Routes
                            join l in GetDataController._db.location
                            on v.v_location_id equals l.location_id
                            where v.v_route_id == routeID
                            select l).ToList();

            }
            catch(Exception ex)
            {
               
            }
            n = location.Count;
            double[,] arr = new double[n, 2];

            if (location.Count > 0)
            {
                for (int i = 0; i < n; i++)
                {
                    arr[i, 0] = location[i].lat_value;
                    arr[i, 1] = location[i].lng_value;
                }
            }

            return arr;
        
        }

        public static double[] GetVertexLoaction(int graphNo, int vertexNo)
        {

            double[] arr = new double[2];
            var location = new List<Location>();

            try
            {
                location = (from vtx in GetDataController._db.vertext_Locations
                            join l in GetDataController._db.location
                            on vtx.location_id equals l.location_id
                            where vtx.vertex_No == vertexNo & vtx.graph_No == graphNo
                            select l).ToList();

               
                arr[0] = location[0].lat_value;
                arr[1] = location[0].lng_value;
            }
            catch(Exception ex)
            {

            }

            return arr;
        }

        public static double[,] GetFootRoute(int routeID)
        {

            var foot_location = new List<Location>();
            int n = 0;

            try
            {
                 foot_location = (from fr in GetDataController._db.foot_Routes
                                     join l in GetDataController._db.location
                                     on fr.f_location_id equals l.location_id
                                     where fr.f_route_id == routeID
                                     select l).ToList();
                n = foot_location.Count;
            }
            catch (Exception ex)
            {

            }
            
            double[,] arr = new double[n, 2];

            if(foot_location.Count>0)
            {
                for (int i = 0; i < n; i++)
                {
                    arr[i, 0] = foot_location[i].lat_value;
                    arr[i, 1] = foot_location[i].lng_value;
                }

            }

            return arr;
        }

        public static int[] GetDepartmentAndFloor(int placeID)
        {
            //get departmentID and floorID relevent placeID
            int[] arr = new int[2];
            var deptAfloor = new List<Place>();

            try
            {
                deptAfloor = (from p in GetDataController._db.Place
                              where p.place_id == placeID
                              select p).ToList();

                if (deptAfloor.Count > 0)
                {
                    arr[0] = deptAfloor[0].p_dept_id;
                    arr[1] = deptAfloor[0].p_floor_id;
                }
            }
            catch(Exception ex)
            {

            }
            

            return arr;

        }

        public static double[,] GetEntranceLocations(int departmentID)
        {
            
            var entranceLocation = new List<Location>();
            int n = 0;

            entranceLocation = (from e in GetDataController._db.entrances
                                join l in GetDataController._db.location
                                on e.e_location_id equals l.location_id
                                where e.e_dept_id == departmentID
                                select l).ToList();
                                    

            n = entranceLocation.Count;
            double[,] arr = new double[n, 2];

            if(entranceLocation.Count>0)
            {
                for (int i = 0; i < n; i++)
                {
                    arr[i, 0] = entranceLocation[i].lat_value;
                    arr[i, 1] = entranceLocation[i].lng_value;
                }
            }

            return arr;

          /*  string sql = "select lat_value,lng_value " +
                "from roadmap_db.location " +
                "where location_id in " +
                "(select e_location_id " +
                "from roadmap_db.entrances " +
                "left join roadmap_db.floors " +
                "on entrances.e_location_id = floors.f_location_id " +
                "where e_dept_id = "+departmentID+"); ";

            return MySqlDataAccess.GetEntryLocation(sql);
            */
        }

        public static double[,] GetInnerRoute(int departmentID, int routeID)
        {
            var innrtLocation = new List<Location>();
            int n = 0;

            try
            {
                innrtLocation = (from i in GetDataController._db.inner_Routes
                                 join l in GetDataController._db.location
                                 on i.i_location_id equals l.location_id
                                 where i.in_route_id == routeID & i.i_dept_id == departmentID
                                 select l).ToList();

                n = innrtLocation.Count;
               
            }
            catch(Exception ex)
            {

            }
            double[,] arr = new double[n, 2];
            if (innrtLocation.Count > 0)
            {

                for (int i = 0; i < n; i++)
                {
                    arr[i, 0] = innrtLocation[i].lat_value;
                    arr[i, 1] = innrtLocation[i].lng_value;
                }
            }
            return arr;
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
            var placeLocation = new List<Location>();
            double[] arr = new double[2];

            try
            {
                placeLocation = (from p in GetDataController._db.Place
                                 join l in GetDataController._db.location
                                 on p.p_location_id equals l.location_id
                                 where p.place_id == placeID
                                 select l).ToList();

               
                if (placeLocation.Count > 0)
                {
                    arr[0] = placeLocation[0].lat_value;
                    arr[1] = placeLocation[0].lng_value;
                }
            }catch(Exception ex)
            {

            }

            return arr;
        }

        public static Dictionary<string, double[]> GetPlaceWithName(int placeID)
        {

            var placeDetails = new List<Location>();
            Dictionary<string, double[]> arr = new Dictionary<string, double[]>();

            try
            {
                placeDetails = (from p in GetDataController._db.Place
                                join l in GetDataController._db.location
                                on p.p_location_id equals l.location_id
                                where p.place_id == placeID
                                select l).ToList();

            }
            catch(Exception e)
            {
                
            }

            if(placeDetails.Count>0)
            {
                double lat = placeDetails[0].lat_value;
                double lng = placeDetails[0].lng_value;
                arr.Add(placeDetails[0].location_name, new double[] { lat, lng });
            }

            return arr;
        }

        #endregion
    }
}

