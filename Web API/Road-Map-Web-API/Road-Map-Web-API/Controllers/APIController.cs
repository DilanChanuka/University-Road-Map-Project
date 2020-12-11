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
using System.Collections;
using RoadMap_DB.DataAccess;
using RoadMap_DB.Data;
using RoadMap_DB.Models;
using Firebase.Database;
using Firebase.Database.Query;

namespace Road_Map_Web_API.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class APIController : Controller
    {
        public APIController(ApplicationDBContext db)
        {
            LocationData._db = db;
        }

        [HttpGet]
        [Route("GetFloor/{department:int}/{floor:int}")]
        public IActionResult GetFloor(int department,int floor)
        {
            int n = 0;
            List<double[]> lst = new List<double[]>();
            var final = new Hashtable();
            double[] temp = new double[2];
            double[,] floorLocations = LocationData.GetFloorLocations(department, floor);
            Dictionary<string, double[]> places = LocationData.GetFloorPlaces(department, floor);
            Place[] arr = new Place[places.Count];
     
            for (int i = 0; i < floorLocations.GetLength(0); i++)
                lst.Add(new double[] { floorLocations[i, 0], floorLocations[i, 1] });
            //this should change according to the department
            if(floor==0)
                final.Add("floor_0_locations", lst);
            else if (floor == 1)
                final.Add("floor_1_locations", lst);
            else 
                final.Add("floor_2_locations", lst);

            foreach (KeyValuePair<string,double[]> pair in places)
            {
                temp = pair.Value;
                arr[n++] = new Place()
                {
                    name = pair.Key,
                    lat = temp[0],
                    lon = temp[1]
                };
            }
            final.Add("places", arr);
            return Json(final);            
        }

        [HttpGet]
        [Route("GetFloorWithPlace/{placeID:int}")]
        public IActionResult GetFloorWithPlace(int placeID)
        {
            int n = 0;
            int[] ids = LocationData.GetDepartmentAndFloor(placeID);
            List<double[]> lst = new List<double[]>();
            var final = new Hashtable();
            double[] temp = new double[2];
            double[,] floorLocations = LocationData.GetFloorLocations(ids[0], ids[1]);
            Dictionary<string, double[]> places = LocationData.GetFloorPlaces(ids[0], ids[1]);
            Dictionary<string, double[]> place = LocationData.GetPlaceWithName(placeID);
            Place[] arr = new Place[places.Count];
            Place pl=new Place();

            for (int i = 0; i < floorLocations.GetLength(0); i++)
                lst.Add(new double[] { floorLocations[i, 0], floorLocations[i, 1] });
            //this should change according to the department
            if (ids[1] == 0)
                final.Add("floor_0_locations", lst);
            else if (ids[1] == 1)
                final.Add("floor_1_locations", lst);
            else
                final.Add("floor_2_locations", lst);

            foreach (KeyValuePair<string, double[]> pair_0 in place)//only once
            {
                foreach (KeyValuePair<string, double[]> pair in places)
                {
                    if (pair_0.Key == pair.Key)
                    {
                        temp = pair.Value;
                        pl = new Place()
                        {
                            name = pair.Key,
                            lat = temp[0],
                            lon = temp[1]
                        };
                    }
                    else
                    {
                        temp = pair.Value;
                        arr[n++] = new Place()
                        {
                            name = pair.Key,
                            lat = temp[0],
                            lon = temp[1]
                        };
                    }
                }
            }
            final.Add("places", arr);
            final.Add("place", pl);
            return Json(final);
        }

        [HttpGet]
        [Route("GetRoute/{startLAT:double}/{startLON:double}/{endLAT:double}/{endLON:double}/{method}")]
        public IActionResult GetRoute(double startLAT, double startLON, double endLAT, double endLON , [FromRoute] string method)
        {
            List<double[]> lst = new List<double[]>();
            var final = new Hashtable();
            Calculations cal = new Calculations();
            int V_No,grapgNo,start,end;
            switch (method)
            {
                case "f":
                    V_No = Data.footGrapheVertices;
                    grapgNo = 0;
                    break;
                case "v":
                    V_No = Data.vehicleGrapheVertices;
                    grapgNo = 1;
                    break;              
                default:
                    V_No=Data.footGrapheVertices;
                    grapgNo = 0;
                    break;
            }
            start = cal.GetNearestVertexNo(V_No, grapgNo, startLAT, startLON);
            end = cal.GetNearestVertexNo(V_No, grapgNo, endLAT, endLON);
            if (start != end)
            {
                int[] routes = cal.GetRouteNumbers(grapgNo, start, end);
                double[,] routeLocations;
                foreach (int r in routes)
                {
                    if (grapgNo == 0)
                        routeLocations = LocationData.GetFootRoute(r);  
                    else
                        routeLocations = LocationData.GetVehicleRoute(r);

                    lst.AddRange(new List<double[]>(cal.ValidateRoute(start, end, grapgNo, r, routeLocations)));
                }
                final.Add("routelocations", lst);

                final.Add("distance_time", cal.FindDistanceAndTime(grapgNo, start, end));

                return Json(final);
            }
            return Json(final);
        }

        [HttpGet]
        [Route("GetPlace/{startLAT:double}/{startLON:double}/{placeID:int}/{method}")]
        public IActionResult GetPlace(double startLAT, double startLON, int placeID, string method)
        {
            List<double[]> lst = new List<double[]>();
            List<double[]> zeroFloorRouteSet = new List<double[]>();
            List<double[]> stair_0_1_RouteSet = new List<double[]>();
            List<double[]> stair_1_2_RouteSet = new List<double[]>();
            List<double[]> firstFloorRouteSet = new List<double[]>();
            List<double[]> secondFloorRouteSet = new List<double[]>();
            double distance=0, time=0;
            var final = new Hashtable();
            double[,] routeLocations;
            double[] temp = new double[2], distanceAndTime;
            Calculations cal = new Calculations();
            int V_No, graphNo, start, localEnd, innerStart = 0, innerEnd = 0;
            int[] ids, routes;
            double[,] floorLocations;
            Dictionary<string, double[]> place;
            Place pl;

            switch (method)
            {
                case "f":
                    V_No = Data.footGrapheVertices;
                    graphNo = 0;
                    break;
                case "v":
                    V_No = Data.vehicleGrapheVertices;
                    graphNo = 1;
                    break;
                default:
                    V_No = Data.footGrapheVertices;
                    graphNo = 0;
                    break;
            }
            start = cal.GetNearestVertexNo(V_No, graphNo, startLAT, startLON);
            localEnd = cal.FindEnterenceVertexNo(V_No, graphNo,start);
                       
            if (start != localEnd)
            {
                int[] route = cal.GetRouteNumbers(graphNo, start, localEnd);
                distanceAndTime = cal.FindDistanceAndTime(graphNo, start, localEnd);
                distance += distanceAndTime[0];
                time += distanceAndTime[1];

                foreach (int r in route)
                {
                    if (graphNo == 0)
                        routeLocations = LocationData.GetFootRoute(r);
                    else
                        routeLocations = LocationData.GetVehicleRoute(r);

                    lst.AddRange(new List<double[]>(cal.ValidateRoute(start, localEnd, graphNo, r, routeLocations)));
                }
                final.Add("outerroutelocations",new List<double[]>(lst));

            }
            lst.Clear();

            for (int i = 0; i < Data.CSMainOuterInnerMatch.Length; i++)
                if (Data.CSMainOuterInnerMatch[i] == localEnd)
                    innerStart = i;

            for (int i = 0; i < Data.CSMainPlaceMatch.Length; i++)
                if (Data.CSMainPlaceMatch[i] == placeID)
                    innerEnd = i;

            graphNo = 2;
            ids = LocationData.GetDepartmentAndFloor(placeID);
            routes = cal.GetRouteNumbers(graphNo, innerStart, innerEnd);
            distanceAndTime = cal.FindDistanceAndTime(graphNo, innerStart, innerEnd);
            distance += distanceAndTime[0];
            time += distanceAndTime[1];
                      
            //according to the department,no of arrays should change
            foreach (int rt in routes)
            {
                if (Data.CSFloor_0_RouteNumbers.Contains(rt))
                {
                    routeLocations = LocationData.GetInnerRoute(ids[0], rt);
                    zeroFloorRouteSet.AddRange(new List<double[]>(cal.ValidateRoute(innerStart, innerEnd, graphNo, rt, routeLocations)));
                }
                else if (Data.CSFloor_1_RouteNumbers.Contains(rt))
                {
                    routeLocations = LocationData.GetInnerRoute(ids[0], rt);
                    firstFloorRouteSet.AddRange(new List<double[]>(cal.ValidateRoute(innerStart, innerEnd, graphNo, rt, routeLocations)));
                }
                else if (Data.CSFloor_2_RouteNumbers.Contains(rt))
                {
                    routeLocations = LocationData.GetInnerRoute(ids[0], rt);
                    secondFloorRouteSet.AddRange(new List<double[]>(cal.ValidateRoute(innerStart, innerEnd, graphNo, rt, routeLocations)));
                }
                else if (Data.CSStairBetwenn_0_1.Contains(rt))
                {
                    routeLocations = LocationData.GetInnerRoute(ids[0], rt);
                    stair_0_1_RouteSet.AddRange(new List<double[]>(cal.ValidateRoute(innerStart, innerEnd, graphNo, rt, routeLocations)));
                }
                else if (Data.CSStairBetwenn_1_2.Contains(rt))
                {
                    routeLocations = LocationData.GetInnerRoute(ids[0], rt);
                    stair_1_2_RouteSet.AddRange(new List<double[]>(cal.ValidateRoute(innerStart, innerEnd, graphNo, rt, routeLocations)));
                }
            }
       
            if (zeroFloorRouteSet.Count != 0)
            {
                final.Add("floor_0_routelocations", new List<double[]>(zeroFloorRouteSet));
                lst.Clear();
                floorLocations = LocationData.GetFloorLocations(ids[0], 0);

                for (int i = 0; i < floorLocations.GetLength(0); i++)
                    lst.Add(new double[] { floorLocations[i, 0], floorLocations[i, 1] });
                final.Add("floor_0_locations", new List<double[]>(lst));
            }
                                
            if (firstFloorRouteSet.Count != 0)
            {
                final.Add("floor_1_routelocations", new List<double[]>(firstFloorRouteSet));
                lst.Clear();
                floorLocations = LocationData.GetFloorLocations(ids[0], 1);

                for (int i = 0; i < floorLocations.GetLength(0); i++)
                    lst.Add(new double[] { floorLocations[i, 0], floorLocations[i, 1] });
                final.Add("floor_1_locations", new List<double[]>(lst));
            }
    
            if (secondFloorRouteSet.Count != 0)
            {
                final.Add("floor_2_routelocations", new List<double[]>(secondFloorRouteSet));
                lst.Clear();
                floorLocations = LocationData.GetFloorLocations(ids[0], 2);

                for (int i = 0; i < floorLocations.GetLength(0); i++)
                    lst.Add(new double[] { floorLocations[i, 0], floorLocations[i, 1] });
                final.Add("floor_2_locations", new List<double[]>(lst));
            }
              
            if (stair_0_1_RouteSet.Count != 0)
                final.Add("stair_0_1_locations", stair_0_1_RouteSet);
            if (stair_1_2_RouteSet.Count != 0)
                final.Add("stair_1_2_locations", stair_1_2_RouteSet);

            place = LocationData.GetPlaceWithName(placeID);
            pl = new Place();
            foreach (KeyValuePair<string, double[]> pair in place)//only once
            {
                temp = pair.Value;
                pl = new Place()
                {
                    name = pair.Key,
                    lat = temp[0],
                    lon = temp[1]
                };
            }
            final.Add("place", pl);
            final.Add("distance_time", new double[] { distance, Math.Round(time, 1) });
            return Json(final);
        }

        [HttpGet]
        [Route("GetPlaceInOut/{department:int}/{floor:int}/{startLAT:double}/{startLON:double}/{endLAT:double}/{endLON:double}")]
        public IActionResult GetPlaceInOut(int department, int floor,double startLAT, double startLON, double endLAT, double endLON)
        {
            List<double[]> lst = new List<double[]>();
            double distance = 0, time = 0;
            double[] distanceAndTime;
            var final = new Hashtable();
            double[,] routeLocations;
            double[,] floorLocations;
            Calculations cal = new Calculations();
            int graphNo = 2, V_No = Data.CSDepartmentGrapheVertices, start, innerEnd, outerStrat, outerEnd;
            int[] EntranceAndInnerEnd;

            start = cal.GetNearestVertexNo(department, floor, V_No, graphNo, startLAT, startLON);
            EntranceAndInnerEnd = cal.FindEnterenceVertexNo(department, floor, startLAT, startLON, endLAT, endLON);
            innerEnd = EntranceAndInnerEnd[1];

            if (start != innerEnd)
            {
                int[] routes = cal.GetRouteNumbers(graphNo, start, innerEnd);
                distanceAndTime = cal.FindDistanceAndTime(graphNo, start, innerEnd);
                distance += distanceAndTime[0];
                time += distanceAndTime[1];

                List<double[]> zeroFloorRouteSet = new List<double[]>();
                List<double[]> stair_0_1_RouteSet = new List<double[]>();
                List<double[]> stair_1_2_RouteSet = new List<double[]>();
                List<double[]> firstFloorRouteSet = new List<double[]>();
                List<double[]> secondFloorRouteSet = new List<double[]>();

                //according to the department,no of arrays should change
                foreach (int rt in routes)
                {
                    if (Data.CSFloor_0_RouteNumbers.Contains(rt))
                    {
                        routeLocations = LocationData.GetInnerRoute(department, rt);
                        zeroFloorRouteSet.AddRange(new List<double[]>(cal.ValidateRoute(start, innerEnd, graphNo, rt, routeLocations)));
                    }
                    else if (Data.CSFloor_1_RouteNumbers.Contains(rt))
                    {
                        routeLocations = LocationData.GetInnerRoute(department, rt);
                        firstFloorRouteSet.AddRange(new List<double[]>(cal.ValidateRoute(start, innerEnd, graphNo, rt, routeLocations)));
                    }
                    else if (Data.CSFloor_2_RouteNumbers.Contains(rt))
                    {
                        routeLocations = LocationData.GetInnerRoute(department, rt);
                        secondFloorRouteSet.AddRange(new List<double[]>(cal.ValidateRoute(start, innerEnd, graphNo, rt, routeLocations)));
                    }
                    else if (Data.CSStairBetwenn_0_1.Contains(rt))
                    {
                        routeLocations = LocationData.GetInnerRoute(department, rt);
                        stair_0_1_RouteSet.AddRange(new List<double[]>(cal.ValidateRoute(start, innerEnd, graphNo, rt, routeLocations)));
                    }
                    else if (Data.CSStairBetwenn_1_2.Contains(rt))
                    {
                        routeLocations = LocationData.GetInnerRoute(department, rt);
                        stair_1_2_RouteSet.AddRange(new List<double[]>(cal.ValidateRoute(start, innerEnd, graphNo, rt, routeLocations)));
                    }
                }

                if (zeroFloorRouteSet.Count != 0)
                {
                    final.Add("floor_0_routelocations", new List<double[]>(zeroFloorRouteSet));
                    lst.Clear();
                    floorLocations = LocationData.GetFloorLocations(department, 0);

                    for (int i = 0; i < floorLocations.GetLength(0); i++)
                        lst.Add(new double[] { floorLocations[i, 0], floorLocations[i, 1] });
                    final.Add("floor_0_locations", new List<double[]>(lst));
                }

                if (firstFloorRouteSet.Count != 0)
                {
                    final.Add("floor_1_routelocations", new List<double[]>(firstFloorRouteSet));
                    lst.Clear();
                    floorLocations = LocationData.GetFloorLocations(department, 1);

                    for (int i = 0; i < floorLocations.GetLength(0); i++)
                        lst.Add(new double[] { floorLocations[i, 0], floorLocations[i, 1] });
                    final.Add("floor_1_locations", new List<double[]>(lst));
                }

                if (secondFloorRouteSet.Count != 0)
                {
                    final.Add("floor_2_routelocations", new List<double[]>(secondFloorRouteSet));
                    lst.Clear();
                    floorLocations = LocationData.GetFloorLocations(department, 2);

                    for (int i = 0; i < floorLocations.GetLength(0); i++)
                        lst.Add(new double[] { floorLocations[i, 0], floorLocations[i, 1] });
                    final.Add("floor_2_locations", new List<double[]>(lst));
                }

                if (stair_0_1_RouteSet.Count != 0)
                    final.Add("stair_0_1_locations", stair_0_1_RouteSet);
                if (stair_1_2_RouteSet.Count != 0)
                    final.Add("stair_1_2_locations", stair_1_2_RouteSet);
            }

            graphNo = 0;
            outerStrat = Data.EntranceOuterMatch[EntranceAndInnerEnd[0]];
            outerEnd= cal.GetNearestVertexNo(Data.footGrapheVertices, graphNo, endLAT, endLON);
            lst.Clear();
            if (outerStrat != outerEnd)
            {
                int[] routes = cal.GetRouteNumbers(graphNo, outerStrat, outerEnd);

                distanceAndTime = cal.FindDistanceAndTime(graphNo, outerStrat, outerEnd);
                distance += distanceAndTime[0];
                time += distanceAndTime[1];

                foreach (int r in routes)
                {
                    routeLocations = LocationData.GetFootRoute(r);
                    lst.AddRange(new List<double[]>(cal.ValidateRoute(outerStrat, outerEnd, 0, r, routeLocations)));
                }
                final.Add("outerroutelocations", new List<double[]>(lst));
            }  
            final.Add("distance_time", new double[] { distance, Math.Round(time, 1) });
            return Json(final);
        }

        [HttpGet]
        [Route("GetPlaceInIn/{department:int}/{floor:int}/{startLAT:double}/{startLON:double}/{placeID:int}")]
        public IActionResult GetPlaceInIn(int department, int floor,double startLAT, double startLON, int placeID)
        {
            List<double[]> lst = new List<double[]>();
            var final = new Hashtable();
            double[,] floorLocations;
            double[,] routeLocations;
            double[] temp = new double[2];
            Dictionary<string, double[]> place;
            Place pl;
            Calculations cal = new Calculations();
            int graphNo = 2,start,end=0;

            start= cal.GetNearestVertexNo(department,floor,Data.CSDepartmentGrapheVertices, graphNo, startLAT, startLON);                        
            for (int i = 0; i < Data.CSMainPlaceMatch.Length; i++)
                if (Data.CSMainPlaceMatch[i] == placeID)
                {
                    end = i;
                    break;
                }
            if (start != end)
            {
                int[] routes = cal.GetRouteNumbers(graphNo, start, end);
                final.Add("distance_time", cal.FindDistanceAndTime(graphNo, start, end));

                List<double[]> zeroFloorRouteSet = new List<double[]>();
                List<double[]> stair_0_1_RouteSet = new List<double[]>();
                List<double[]> stair_1_2_RouteSet = new List<double[]>();
                List<double[]> firstFloorRouteSet = new List<double[]>();
                List<double[]> secondFloorRouteSet = new List<double[]>();

                //according to the department,no of arrays should change
                foreach (int rt in routes)
                {
                    if (Data.CSFloor_0_RouteNumbers.Contains(rt))
                    {
                        routeLocations = LocationData.GetInnerRoute(department, rt);
                        zeroFloorRouteSet.AddRange(new List<double[]>(cal.ValidateRoute(start, end, graphNo, rt, routeLocations)));
                    }
                    else if (Data.CSFloor_1_RouteNumbers.Contains(rt))
                    {
                        routeLocations = LocationData.GetInnerRoute(department, rt);
                        firstFloorRouteSet.AddRange(new List<double[]>(cal.ValidateRoute(start, end, graphNo, rt, routeLocations)));
                    }
                    else if (Data.CSFloor_2_RouteNumbers.Contains(rt))
                    {
                        routeLocations = LocationData.GetInnerRoute(department, rt);
                        secondFloorRouteSet.AddRange(new List<double[]>(cal.ValidateRoute(start, end, graphNo, rt, routeLocations)));
                    }
                    else if (Data.CSStairBetwenn_0_1.Contains(rt))
                    {
                        routeLocations = LocationData.GetInnerRoute(department, rt);
                        stair_0_1_RouteSet.AddRange(new List<double[]>(cal.ValidateRoute(start, end, graphNo, rt, routeLocations)));
                    }
                    else if (Data.CSStairBetwenn_1_2.Contains(rt))
                    {
                        routeLocations = LocationData.GetInnerRoute(department, rt);
                        stair_1_2_RouteSet.AddRange(new List<double[]>(cal.ValidateRoute(start, end, graphNo, rt, routeLocations)));
                    }
                }

                if (zeroFloorRouteSet.Count != 0)
                {
                    final.Add("floor_0_routelocations", new List<double[]>(zeroFloorRouteSet));
                    lst.Clear();
                    floorLocations = LocationData.GetFloorLocations(department, 0);

                    for (int i = 0; i < floorLocations.GetLength(0); i++)
                        lst.Add(new double[] { floorLocations[i, 0], floorLocations[i, 1] });
                    final.Add("floor_0_locations", new List<double[]>(lst));
                }

                if (firstFloorRouteSet.Count != 0)
                {
                    final.Add("floor_1_routelocations", new List<double[]>(firstFloorRouteSet));
                    lst.Clear();
                    floorLocations = LocationData.GetFloorLocations(department, 1);

                    for (int i = 0; i < floorLocations.GetLength(0); i++)
                        lst.Add(new double[] { floorLocations[i, 0], floorLocations[i, 1] });
                    final.Add("floor_1_locations", new List<double[]>(lst));
                }

                if (secondFloorRouteSet.Count != 0)
                {
                    final.Add("floor_2_routelocations", new List<double[]>(secondFloorRouteSet));
                    lst.Clear();
                    floorLocations = LocationData.GetFloorLocations(department, 2);

                    for (int i = 0; i < floorLocations.GetLength(0); i++)
                        lst.Add(new double[] { floorLocations[i, 0], floorLocations[i, 1] });
                    final.Add("floor_2_locations", new List<double[]>(lst));
                }

                if (stair_0_1_RouteSet.Count != 0)
                    final.Add("stair_0_1_locations", stair_0_1_RouteSet);
                if (stair_1_2_RouteSet.Count != 0)
                    final.Add("stair_1_2_locations", stair_1_2_RouteSet);
            }
            else
            {
                lst.Clear();
                floorLocations = LocationData.GetFloorLocations(department, floor);

                for (int i = 0; i < floorLocations.GetLength(0); i++)
                    lst.Add(new double[] { floorLocations[i, 0], floorLocations[i, 1] });
                //this should change according to the department
                if (floor == 0)
                    final.Add("floor_0_locations", new List<double[]>(lst));
                else if (floor == 1)
                    final.Add("floor_1_locations", new List<double[]>(lst));
                else
                    final.Add("floor_2_locations", new List<double[]>(lst));
            }

            place = LocationData.GetPlaceWithName(placeID);
            pl = new Place();

            foreach (KeyValuePair<string, double[]> pair in place)//only once
            {
                temp = pair.Value;
                pl = new Place()
                {
                    name = pair.Key,
                    lat = temp[0],
                    lon = temp[1]
                };
            }
            final.Add("place", pl);
            return Json(final);
        }
                
        [HttpGet]
        public IActionResult Index()
        {            
            return View();
        }

        [HttpPost("{username}/{password}")]
        public IActionResult IdentifyUser(string username, string password)
        {
            if (LocationData.GetUserIdentity(username,password))
                return Ok();
            else
                return Unauthorized();
        }

        [HttpPost]
        public IActionResult RegisterUser([FromBody]APIUser[] user)
        {
            if (LocationData.SetUser(user[0].username,user[0].email,user[0].password))
                return Created("http://127.0.0.1:5000/API", user[0].username+" Registered");
            else
                return BadRequest();
        }

        //Location Shearing system request handling methods

        [HttpGet]
        [Route("UserLocation/{userName}/{LAT:double}/{LON:double}")]
        public async Task<IActionResult> UserLocation(string userName, double LAT, double LON)
        {
            Location loc = new Location()
            {
                Username = userName,
                Lat = LAT,
                Lon = LON
            };
            try
            {
                FirebaseClient client = new FirebaseClient("https://university-road-map-project-default-rtdb.firebaseio.com/");
                ///////// use  GetUserId(string username) method
               // await client.Child("UserLocation/" + GetUserId(userName)).PutAsync(loc);
                return Ok("Successfully Updated..!");
            }
            catch
            {
                return BadRequest("There is an issue with realtime database connection..!");
            }
        }

        private async Task<Location> FetchUserLocation(int userId)
        {
            //try
            //{
            //    FirebaseClient client = new FirebaseClient("https://university-road-map-project-default-rtdb.firebaseio.com/");
            //    var read = await client.Child("UserLocation").Child(userId).OnceSingleAsync<Location>();
            //    return new Location() { Username = read.Username, Lat = read.Lat, Lon = read.Lon };
            //}
            //catch
            //{
            //    return null;
            //}

            return null;
        }

        [HttpGet]
        [Route("GetLocations/{userName}")]
        public async Task<IActionResult> GetLocations(string userName)
        {
            //var final = new Hashtable();
            //Location loc;
            //int n = 0;
            //int[] ConfUsers = GetConfirmUsers(userName);
            //Location[] arr = new Location[ConfUsers.Length];

            //foreach (int userId in ConfUsers)
            //{
            //    loc = await FetchUserLocation(userId);
            //    if (loc != null)
            //        arr[n++] = new Location() { Username = loc.Username, Lat = loc.Lat, Lon = loc.Lon };
            //}
            //final.Add("friends", arr);
            //return Json(final);

            Location loc1 = await FetchUserLocation(1);
            return Json(loc1);
        }
        
        [HttpGet]
        [Route("GetPath/{user}/{req_user}")]
        public IActionResult GetPath(string user,string req_user)
        {


            return Json(user+req_user);
        }
        
        [HttpGet]
        [Route("GetAppUsers/{userName}")]
        public IActionResult GetAppUsers(string userName)
        {
            return Json(userName);
        }

        [HttpGet]
        [Route("AddFriend/{user}/{req_user}")]
        public IActionResult AddFriend(string user, string req_user)
        {
            return Json(user + req_user);
        }

        [HttpGet]
        [Route("ConfirmFriend/{user}/{req_user}")]
        public IActionResult ConfirmFriend(string user, string req_user)
        {
            return Json(user + req_user);
        }

        [HttpGet]
        [Route("RemoveFriend/{user}/{req_user}")]
        public IActionResult RemoveFriend(string user, string req_user)
        {
            return Json(user + req_user);
        }


    }
}
