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
        [HttpGet]
        [Route("GetFloor/{department:int}/{floor:int}")]
        public IActionResult GetFloor(int department,int floor)
        {
            //GetFloorLocations(department, floor);
            //GetFloorPlaces(department, floor);

            return Json("Department - "+department+" Florr - "+floor+" Requested..!");
        }

        [HttpGet]
        [Route("GetRoute/{startLAT:double}/{startLON:double}/{endLAT:double}/{endLON:double}/{method}")]
        public IActionResult GetRoute(double startLAT, double startLON, double endLAT, double endLON , [FromRoute] string method)
        {
            Calculations cal = new Calculations();
            int V_No;
            switch (method)
            {
                case "F":
                    V_No = Data.footGrapheVertices;break;
                case "V":
                    V_No = Data.vehicleGrapheVertices;break;
                case "I":
                    V_No = Data.innerGrapheVertices_1;break;
                default:
                    V_No=Data.footGrapheVertices;break;
            }
            int start = cal.GetNearestVertexNo(V_No, startLAT, startLON);
            int end=cal.GetNearestVertexNo(V_No, endLAT, endLON);

            int[] routes= cal.GetFootRouteNumbers(start, end);

            //foreach (int r in routes)
            //{
            //    GetFootRoute(r);
            //}

            //return Json([]);

            return Json(startLAT+" -- "+ startLON + " -- "+ endLAT + " -- "+ endLON + " -- "+ method);
        }

        [HttpGet]
        [Route("GetPlace/{startLAT:double}/{startLON:double}/{placeID:int}/{method}")]
        public IActionResult GetPlace(double startLAT, double startLON, int placeID, string method)
        {
            Calculations cal = new Calculations();
            int V_No;
            switch (method)
            {
                case "F":
                    V_No = Data.footGrapheVertices; break;
                case "V":
                    V_No = Data.vehicleGrapheVertices; break;
                case "I":
                    V_No = Data.innerGrapheVertices_1; break;
                default:
                    V_No = Data.footGrapheVertices; break;
            }
            int start = cal.GetNearestVertexNo(V_No, startLAT, startLON);
            int localEnd= cal.FindEnterenceVertexNo(placeID, startLAT, startLON);

            int[] routesSet1 = cal.GetFootRouteNumbers(start, localEnd);

            //foreach (int r in routesSet1)
            //{
            //    GetFootRoute(r);
            //}
            int[] fl = cal.FindDepartmentAndFloor(placeID);
            //GetFloorLocations(fl[0], fl[1]);

            //GetFloorPlace(fl[0], placeID);

            int[] innerVertices = cal.FindInnerVertices(fl[0],fl[1],localEnd, placeID);

            int[] routesSet2 = cal.GetInnerRouteNumbers(Data.innerRoutesGraph_1,Data.innerGrapheVertices_1,innerVertices[0], innerVertices[1]);

            //foreach (int r in routesSet2)
            //{
            //    GetInnerRoute(r);
            //}

            //return Json([]);

            return Json(startLAT + " -- " + startLON + " -- " + placeID + " -- " + method);
        }

        [HttpGet]
        public IActionResult Get()
        {
            return Json("Connected..!");
        }

        [HttpPost("{username}/{password}")]
        public IActionResult IdentifyUser(string username, string password)
        {
            //if (GetUser(username, password))
            //    return Ok();
            //else
            //    return Unauthorized();
            return Ok();
        }

        [HttpPost]
        public IActionResult RegisterUser([FromBody]User user)
        {
            //if (SetUser(user))
            //    return Created("https://localhost:44342/API", user.username);
            //else
            //    return BadRequest();
            return Ok();
        }
    }
}
