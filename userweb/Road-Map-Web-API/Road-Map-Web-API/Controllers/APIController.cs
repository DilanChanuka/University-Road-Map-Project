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
        public JsonResult GetFloor(int department, int floor)
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
            if (floor == 0)
                final.Add("floor_0_locations", lst);
            else if (floor == 1)
                final.Add("floor_1_locations", lst);
            else
                final.Add("floor_2_locations", lst);

            foreach (KeyValuePair<string, double[]> pair in places)
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
        [Route("GetRoute/{startLAT:double}/{startLON:double}/{endLAT:double}/{endLON:double}/{method}")]
        public IActionResult GetRoute(double startLAT, double startLON, double endLAT, double endLON, [FromRoute] string method)
        {
            List<double[]> lst = new List<double[]>();
            var final = new Hashtable();
            Calculations cal = new Calculations();
            int V_No, grapgNo;
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
                    V_No = Data.footGrapheVertices;
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

                    for (int i = 0; i < routeLocations.GetLength(0); i++)
                        lst.Add(new double[] { routeLocations[i, 0], routeLocations[i, 1] });
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
            int V_No, grapgNo;
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
                    V_No = Data.footGrapheVertices;
                    grapgNo = 0;
                    break;
            }

            int start = cal.GetNearestVertexNo(V_No, grapgNo, startLAT, startLON);
            int localEnd = cal.FindEnterenceVertexNo(placeID, startLAT, startLON);

            if (start != localEnd)
            {
                int[] routes = cal.GetRouteNumbers(grapgNo, start, localEnd);
                foreach (int r in routes)
                {
                    if (grapgNo == 0)
                        routeLocations = LocationData.GetFootRoute(r);
                    else
                        routeLocations = LocationData.GetVehicleRoute(r);

                    for (int i = 0; i < routeLocations.GetLength(0); i++)
                        lst.Add(new double[] { routeLocations[i, 0], routeLocations[i, 1] });
                }
                final.Add("outerroutelocations", lst);
            }
            lst.Clear();
            int[] ids = LocationData.GetDepartmentAndFloor(placeID);
            double[,] floorLocations = LocationData.GetFloorLocations(ids[0], ids[1]);

            for (int i = 0; i < floorLocations.GetLength(0); i++)
                lst.Add(new double[] { floorLocations[i, 0], floorLocations[i, 1] });

            //this should change according to the department
            if (ids[1] == 0)
                final.Add("floor_0_locations", lst);
            else if (ids[1] == 1)
                final.Add("floor_1_locations", lst);
            else
                final.Add("floor_2_locations", lst);

            lst.Clear();
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

            int[] innerRouteSet = cal.GetInnerRouteNumbers(localEnd, placeID);
            int graphNo = 0;
            switch (ids[1])
            {
                case 0: graphNo = 2; break;
                case 1: graphNo = 3; break;
                case 2: graphNo = 4; break;
            }
            lst.Clear();
            foreach (int r in innerRouteSet)
            {
                routeLocations = LocationData.GetInnerRoute(graphNo, r);
                for (int i = 0; i < routeLocations.GetLength(0); i++)
                    lst.Add(new double[] { routeLocations[i, 0], routeLocations[i, 1] });
            }
            final.Add("innerroutelocations", lst);

            return Json(final);
        }

        [HttpGet]
        [Route("GetPlaceInOut/{department:int}/{floor:int}/{startLAT:double}/{startLON:double}/{endLAT:double}/{endLON:double}")]
        public IActionResult GetPlaceInOut(int department, int floor, double startLAT, double startLON, double endLAT, double endLON)
        {
            List<double[]> lst = new List<double[]>();
            var final = new Hashtable();
            double[,] routeLocations;
            Calculations cal = new Calculations();
            int graphNo, V_No;
            switch (floor)
            {
                case 0:
                    graphNo = 2;
                    V_No = Data.innerGraphe_0_Vertices;
                    break;
                case 1:
                    graphNo = 3;
                    V_No = Data.innerGraphe_1_Vertices;
                    break;
                case 2:
                    graphNo = 4;
                    V_No = Data.innerGraphe_2_Vertices;
                    break;
                default:
                    graphNo = 2;
                    V_No = Data.innerGraphe_0_Vertices;
                    break;
            }
            int start = cal.GetNearestVertexNo(V_No, graphNo, startLAT, startLON);
            int[] EntranceAndInnerEnd = cal.FindEnterenceVertexNo(department, floor, startLAT, startLON, endLAT, endLON);
            int innerEnd = EntranceAndInnerEnd[1];
            if (start != innerEnd)
            {
                int[] routes = cal.GetRouteNumbers(graphNo, start, innerEnd);
                foreach (int r in routes)
                {
                    routeLocations = LocationData.GetInnerRoute(graphNo, r);

                    for (int i = 0; i < routeLocations.GetLength(0); i++)
                        lst.Add(new double[] { routeLocations[i, 0], routeLocations[i, 1] });
                }
                final.Add("innerroutelocations", lst);
            }
            lst.Clear();
            double[,] floorLocations = LocationData.GetFloorLocations(department, floor);

            for (int i = 0; i < floorLocations.GetLength(0); i++)
                lst.Add(new double[] { floorLocations[i, 0], floorLocations[i, 1] });

            //this should change according to the department
            if (floor == 0)
                final.Add("floor_0_locations", lst);
            else if (floor == 1)
                final.Add("floor_1_locations", lst);
            else
                final.Add("floor_2_locations", lst);

            int outerStrat = Data.EntranceOuterMatch[EntranceAndInnerEnd[0]];
            int outerEnd = cal.GetNearestVertexNo(Data.footGrapheVertices, 0, endLAT, endLON);
            lst.Clear();
            if (outerStrat != outerEnd)
            {
                int[] routes = cal.GetRouteNumbers(0, outerStrat, outerEnd);
                foreach (int r in routes)
                {
                    routeLocations = LocationData.GetFootRoute(r);

                    for (int i = 0; i < routeLocations.GetLength(0); i++)
                        lst.Add(new double[] { routeLocations[i, 0], routeLocations[i, 1] });
                }
                final.Add("outerroutelocations", lst);
            }
            return Json(final);
        }

        [HttpGet]
        [Route("GetPlaceInIn/{department:int}/{floor:int}/{startLAT:double}/{startLON:double}/{placeID:int}")]
        public IActionResult GetPlaceInIn(int department, int floor, double startLAT, double startLON, int placeID)
        {
            List<double[]> lst = new List<double[]>();
            var final = new Hashtable();
            double[,] floorLocations;
            double[,] routeLocations;
            double[] temp = new double[2];
            Dictionary<string, double[]> place;
            Calculations cal = new Calculations();
            int graphNo = 5;
            int start = cal.GetNearestVertexNo(department, floor, Data.CSDepartmentGrapheVertices, graphNo, startLAT, startLON);
            int end = 0;
            for (int i = 0; i < Data.CSMainPlaceMatch.Length; i++)
                if (Data.CSMainPlaceMatch[i] == placeID)
                {
                    end = i;
                    break;
                }
            if (start != end)
            {
                int[] routes = cal.GetRouteNumbers(graphNo, start, end);
                List<int> zeroFloorRouteSet = new List<int>();
                List<int> stairRouteSet = new List<int>();
                List<int> firstFloorRouteSet = new List<int>();
                List<int> secondFloorRouteSet = new List<int>();

                //according to the department,no of arrays should change
                foreach (int rt in routes)
                {
                    if (Data.CSFloor_0_RouteNumbers.Contains(rt))
                        zeroFloorRouteSet.Add(rt);
                    else if (Data.CSFloor_1_RouteNumbers.Contains(rt))
                        firstFloorRouteSet.Add(rt);
                    else if (Data.CSFloor_2_RouteNumbers.Contains(rt))
                        secondFloorRouteSet.Add(rt);
                    else if (Data.CSStairRouteNumbers.Contains(rt))
                        stairRouteSet.Add(rt);
                }
                foreach (int r in zeroFloorRouteSet)
                {
                    routeLocations = LocationData.GetInnerRoute(graphNo, r);

                    for (int i = 0; i < routeLocations.GetLength(0); i++)
                        lst.Add(new double[] { routeLocations[i, 0], routeLocations[i, 1] });
                }
                if (lst.Count != 0)
                {
                    final.Add("floor_0_routelocations", lst);
                    lst.Clear();
                    floorLocations = LocationData.GetFloorLocations(department, 0);

                    for (int i = 0; i < floorLocations.GetLength(0); i++)
                        lst.Add(new double[] { floorLocations[i, 0], floorLocations[i, 1] });
                    final.Add("floor_0_locations", lst);
                }

                lst.Clear();
                foreach (int r in firstFloorRouteSet)
                {
                    routeLocations = LocationData.GetInnerRoute(graphNo, r);

                    for (int i = 0; i < routeLocations.GetLength(0); i++)
                        lst.Add(new double[] { routeLocations[i, 0], routeLocations[i, 1] });
                }
                if (lst.Count != 0)
                {
                    final.Add("floor_1_routelocations", lst);
                    lst.Clear();
                    floorLocations = LocationData.GetFloorLocations(department, 1);

                    for (int i = 0; i < floorLocations.GetLength(0); i++)
                        lst.Add(new double[] { floorLocations[i, 0], floorLocations[i, 1] });
                    final.Add("floor_1_locations", lst);
                }
                lst.Clear();
                foreach (int r in secondFloorRouteSet)
                {
                    routeLocations = LocationData.GetInnerRoute(graphNo, r);

                    for (int i = 0; i < routeLocations.GetLength(0); i++)
                        lst.Add(new double[] { routeLocations[i, 0], routeLocations[i, 1] });
                }
                if (lst.Count != 0)
                {
                    final.Add("floor_2_routelocations", lst);
                    lst.Clear();
                    floorLocations = LocationData.GetFloorLocations(department, 2);

                    for (int i = 0; i < floorLocations.GetLength(0); i++)
                        lst.Add(new double[] { floorLocations[i, 0], floorLocations[i, 1] });
                    final.Add("floor_2_locations", lst);
                }
                lst.Clear();

                foreach (int r in stairRouteSet)
                {
                    routeLocations = LocationData.GetInnerRoute(graphNo, r);

                    for (int i = 0; i < routeLocations.GetLength(0); i++)
                        lst.Add(new double[] { routeLocations[i, 0], routeLocations[i, 1] });

                    if (Data.CSStairBetwenn_0_1.Contains(r))
                    {
                        final.Add("stair_0_1_locations", lst);
                        lst.Clear();
                    }
                    else if (Data.CSStairBetwenn_1_2.Contains(r))
                    {
                        final.Add("stair_1_2_locations", lst);
                        lst.Clear();
                    }
                }
            }
            else
            {
                lst.Clear();
                floorLocations = LocationData.GetFloorLocations(department, floor);

                for (int i = 0; i < floorLocations.GetLength(0); i++)
                    lst.Add(new double[] { floorLocations[i, 0], floorLocations[i, 1] });
                //this should change according to the department
                if (floor == 0)
                    final.Add("floor_0_locations", lst);
                else if (floor == 1)
                    final.Add("floor_1_locations", lst);
                else
                    final.Add("floor_2_locations", lst);
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
            if (LocationData.GetUserIdentity(username, password))
                return Ok();
            else
                return Unauthorized();
        }

        [HttpPost]
        public IActionResult RegisterUser([FromBody]APIUser user)
        {
            if (LocationData.SetUser(_db, user.username, user.email, user.password))
                return Created("https://localhost:44342/API", user.username + " Registered");
            else
                return BadRequest();
        }
    }
}
