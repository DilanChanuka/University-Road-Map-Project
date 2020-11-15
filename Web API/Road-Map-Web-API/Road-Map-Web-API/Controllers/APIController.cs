﻿using System;
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
using RoadMap_DB.Controllers;
using RoadMap_DB.Data;
using RoadMap_DB.Models;

namespace Road_Map_Web_API.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class APIController : Controller
    {
        public static ApplicationDBContext _db;
        public APIController(ApplicationDBContext db)
        {
            _db = db;
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
            int V_No,grapgNo;
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
            int start = cal.GetNearestVertexNo(V_No, grapgNo, startLAT, startLON);
            int end = cal.GetNearestVertexNo(V_No, grapgNo, endLAT, endLON);
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
                return Json(final);
            }
            return Json(final);
        }

        [HttpGet]
        [Route("GetPlace/{startLAT:double}/{startLON:double}/{placeID:int}/{method}")]
        public IActionResult GetPlace(double startLAT, double startLON, int placeID, string method)
        {
            List<double[]> lst = new List<double[]>();            
            var final = new Hashtable();
            double[,] routeLocations;
            double[] temp = new double[2];
            Calculations cal = new Calculations();
            int V_No, graphNo;
            double[,] floorLocations;
            List<double[]> zeroFloorRouteSet = new List<double[]>();
            List<double[]> stair_0_1_RouteSet = new List<double[]>();
            List<double[]> stair_1_2_RouteSet = new List<double[]>();
            List<double[]> firstFloorRouteSet = new List<double[]>();
            List<double[]> secondFloorRouteSet = new List<double[]>();

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
            int start = cal.GetNearestVertexNo(V_No, graphNo, startLAT, startLON);
            int localEnd = cal.FindEnterenceVertexNo(placeID, startLAT, startLON);
                       
            if (start != localEnd)
            {
                int[] route = cal.GetRouteNumbers(graphNo, start, localEnd);
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

            int innerStart=0,innerEnd=0;
            for (int i = 0; i < Data.CSMainOuterInnerMatch.Length; i++)
                if (Data.CSMainOuterInnerMatch[i] == localEnd)
                    innerStart = i;

            for (int i = 0; i < Data.CSMainPlaceMatch.Length; i++)
                if (Data.CSMainPlaceMatch[i] == placeID)
                    innerEnd = i;

            graphNo = 2;
            int[] ids = LocationData.GetDepartmentAndFloor(placeID);

            int[] routes = cal.GetRouteNumbers(graphNo, innerStart, innerEnd);            

            //according to the department,no of arrays should change
            foreach (int rt in routes)
            {
                if (Data.CSFloor_0_RouteNumbers.Contains(rt))
                {
                    routeLocations = LocationData.GetInnerRoute(graphNo, rt);
                    zeroFloorRouteSet.AddRange(new List<double[]>(cal.ValidateRoute(innerStart, innerEnd, graphNo, rt, routeLocations)));
                }
                else if (Data.CSFloor_1_RouteNumbers.Contains(rt))
                {
                    routeLocations = LocationData.GetInnerRoute(graphNo, rt);
                    firstFloorRouteSet.AddRange(new List<double[]>(cal.ValidateRoute(innerStart, innerEnd, graphNo, rt, routeLocations)));
                }
                else if (Data.CSFloor_2_RouteNumbers.Contains(rt))
                {
                    routeLocations = LocationData.GetInnerRoute(graphNo, rt);
                    secondFloorRouteSet.AddRange(new List<double[]>(cal.ValidateRoute(innerStart, innerEnd, graphNo, rt, routeLocations)));
                }
                else if (Data.CSStairBetwenn_0_1.Contains(rt))
                {
                    routeLocations = LocationData.GetInnerRoute(graphNo, rt);
                    stair_0_1_RouteSet.AddRange(new List<double[]>(cal.ValidateRoute(innerStart, innerEnd, graphNo, rt, routeLocations)));
                }
                else if (Data.CSStairBetwenn_1_2.Contains(rt))
                {
                    routeLocations = LocationData.GetInnerRoute(graphNo, rt);
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

            Dictionary<string, double[]> place = LocationData.GetPlaceWithName(placeID);
            Place pl = new Place();
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
        [Route("GetPlaceInOut/{department:int}/{floor:int}/{startLAT:double}/{startLON:double}/{endLAT:double}/{endLON:double}")]
        public IActionResult GetPlaceInOut(int department, int floor,double startLAT, double startLON, double endLAT, double endLON)
        {
            List<double[]> lst = new List<double[]>();
            var final = new Hashtable();
            double[,] routeLocations;
            double[,] floorLocations;
            Calculations cal = new Calculations();
            int graphNo=2,V_No=Data.CSDepartmentGrapheVertices;

            int start = cal.GetNearestVertexNo(department, floor, V_No, graphNo, startLAT, startLON);
            int[] EntranceAndInnerEnd = cal.FindEnterenceVertexNo(department, floor, startLAT, startLON, endLAT, endLON);
            int innerEnd = EntranceAndInnerEnd[1];

            if (start != innerEnd)
            {
                int[] routes = cal.GetRouteNumbers(graphNo, start, innerEnd);
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
                        routeLocations = LocationData.GetInnerRoute(graphNo, rt);
                        zeroFloorRouteSet.AddRange(new List<double[]>(cal.ValidateRoute(start, innerEnd, graphNo, rt, routeLocations)));
                    }
                    else if (Data.CSFloor_1_RouteNumbers.Contains(rt))
                    {
                        routeLocations = LocationData.GetInnerRoute(graphNo, rt);
                        firstFloorRouteSet.AddRange(new List<double[]>(cal.ValidateRoute(start, innerEnd, graphNo, rt, routeLocations)));
                    }
                    else if (Data.CSFloor_2_RouteNumbers.Contains(rt))
                    {
                        routeLocations = LocationData.GetInnerRoute(graphNo, rt);
                        secondFloorRouteSet.AddRange(new List<double[]>(cal.ValidateRoute(start, innerEnd, graphNo, rt, routeLocations)));
                    }
                    else if (Data.CSStairBetwenn_0_1.Contains(rt))
                    {
                        routeLocations = LocationData.GetInnerRoute(graphNo, rt);
                        stair_0_1_RouteSet.AddRange(new List<double[]>(cal.ValidateRoute(start, innerEnd, graphNo, rt, routeLocations)));
                    }
                    else if (Data.CSStairBetwenn_1_2.Contains(rt))
                    {
                        routeLocations = LocationData.GetInnerRoute(graphNo, rt);
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
                       
            int outerStrat = Data.EntranceOuterMatch[EntranceAndInnerEnd[0]];
            int outerEnd= cal.GetNearestVertexNo(Data.footGrapheVertices, 0, endLAT, endLON);
            lst.Clear();
            if (outerStrat != outerEnd)
            {
                int[] routes = cal.GetRouteNumbers(0, outerStrat, outerEnd);
                foreach (int r in routes)
                {
                    routeLocations = LocationData.GetFootRoute(r);
                    lst.AddRange(new List<double[]>(cal.ValidateRoute(outerStrat, outerEnd, 0, r, routeLocations)));
                }
                final.Add("outerroutelocations", new List<double[]>(lst));
            }            
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
            Calculations cal = new Calculations();
            int graphNo = 2;
            int start= cal.GetNearestVertexNo(department,floor,Data.CSDepartmentGrapheVertices, graphNo, startLAT, startLON);                        
            int end=0;
            for (int i = 0; i < Data.CSMainPlaceMatch.Length; i++)
                if (Data.CSMainPlaceMatch[i] == placeID)
                {
                    end = i;
                    break;
                }
            if (start != end)
            {
                int[] routes = cal.GetRouteNumbers(graphNo, start, end);
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
                        routeLocations = LocationData.GetInnerRoute(graphNo, rt);
                        zeroFloorRouteSet.AddRange(new List<double[]>(cal.ValidateRoute(start, end, graphNo, rt, routeLocations)));
                    }
                    else if (Data.CSFloor_1_RouteNumbers.Contains(rt))
                    {
                        routeLocations = LocationData.GetInnerRoute(graphNo, rt);
                        firstFloorRouteSet.AddRange(new List<double[]>(cal.ValidateRoute(start, end, graphNo, rt, routeLocations)));
                    }
                    else if (Data.CSFloor_2_RouteNumbers.Contains(rt))
                    {
                        routeLocations = LocationData.GetInnerRoute(graphNo, rt);
                        secondFloorRouteSet.AddRange(new List<double[]>(cal.ValidateRoute(start, end, graphNo, rt, routeLocations)));
                    }
                    else if (Data.CSStairBetwenn_0_1.Contains(rt))
                    {
                        routeLocations = LocationData.GetInnerRoute(graphNo, rt);
                        stair_0_1_RouteSet.AddRange(new List<double[]>(cal.ValidateRoute(start, end, graphNo, rt, routeLocations)));
                    }
                    else if (Data.CSStairBetwenn_1_2.Contains(rt))
                    {
                        routeLocations = LocationData.GetInnerRoute(graphNo, rt);
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
            Place pl = new Place();

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
        public IActionResult Get()
        {
            return Json("Connected..!");
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
            if (LocationData.SetUser(_db,user[0].username,user[0].email,user[0].password))
                return Created("http://localhost:52571/API", user[0].username+" Registered");
            else
                return BadRequest();
        }
    }
}
