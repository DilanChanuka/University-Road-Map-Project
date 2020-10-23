﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Road_Map_Web_API
{
    public class Calculations
    {
        public int GetNearestVertexNo(int noOfVertices,int graphNo, double lat, double lon)
        {
            double[] distance = new double[noOfVertices];
            double[] temp;
            for (int i = 0; i < noOfVertices; i++)
            {
                temp = GetVertexLoaction(graphNo,i);
                distance[i] = Math.Sqrt(Math.Pow(lat - temp[0], 2) + Math.Pow(lon - temp[1], 2));
            }
            return Array.IndexOf(distance, distance.Min());
        }

        public int FindEnterenceVertexNo(int placeID, double lat, double lon)
        {
            int[] ids = GetDepartmentAndFloor(placeID);
            double[] loc = GetPlace(placeID);//locations of place
            double[,] entrance = GetEntranceLocations(ids[0], ids[1]);
            double[] distance = new double[entrance.GetLength(0)];
            for (int i = 0; i < entrance.GetLength(0); i++)
            {
                distance[i] = Math.Sqrt(Math.Pow(lat - entrance[i, 0], 2) + Math.Pow(lon - entrance[i, 1], 2)) +
                        Math.Sqrt(Math.Pow(loc[0] - entrance[i, 0], 2) + Math.Pow(loc[1] - entrance[i, 1], 2));
            }
            //according to the department,Entrance outer match should change
            return  Data.EntranceOuterMatch[Array.IndexOf(distance, distance.Min())];
        }

        public int[] FindInnerVertices(int department,int floor,int outerEnd,int placeID)
        {
            List<int> set=new List<int>();

            for (int i = 0; i < Data.InnerOuterMatch_1.Length; i++)
                if (Data.InnerGraph_1_Places[i] == outerEnd)
                {
                    set.Add(i);
                    break;
                }

            for (int i = 0; i < Data.InnerGraph_1_Places.Length; i++)
                if (Data.InnerGraph_1_Places[i] == placeID)
                {
                    set.Add(i);
                    break;
                }

            return set.ToArray();
        }

        public int[] GetRouteNumbers(int graphNo,int start,int end)
        {
            int[,] graph;
            int V_No;
            int[,] endPoints;
            switch (graphNo)
            {
                case 0:
                    graph = Data.flootRoutesGraph;
                    V_No = Data.footGrapheVertices;
                    endPoints = Data.foorRouteEndpoints;
                    break;
                case 1:
                    graph = Data.vehicleRoutesGraph;
                    V_No = Data.vehicleGrapheVertices;
                    endPoints = Data.vehicleRouteEndpoints;
                    break;
                case 2:
                    graph = Data.innerRoutesGraph_1;
                    V_No = Data.innerGrapheVertices_1;
                    endPoints = Data.innerRouteEndpoints_1;
                    break;
                case 3:
                    graph = Data.innerRoutesGraph_2;
                    V_No = Data.innerGrapheVertices_2;
                    endPoints = Data.innerRouteEndpoints_2;
                    break;
                case 4:
                    graph = Data.innerRoutesGraph_3;
                    V_No = Data.innerGrapheVertices_3;
                    endPoints = Data.innerRouteEndpoints_3;
                    break;
                default:
                    graph = Data.flootRoutesGraph;
                    V_No = Data.footGrapheVertices;
                    endPoints = Data.foorRouteEndpoints;
                    break;
            }
            FindShortestPath find = new FindShortestPath();
            List<int[]> allPaths= find.GetShortestPathList(graph, V_No, start);
            int[] path = allPaths[end];
            List<int> routeNumbers = new List<int>();

            for (int j = 0; j < path.Length-1; j++)
            {
                for (int i = 0; i < Data.foorRouteEndpoints.GetLength(0); i++)
                {
                    if((endPoints[i,0]==path[j] && endPoints[i, 1] == path[j + 1]) ||
                        (endPoints[i, 1] == path[j] && endPoints[i, 0] == path[j + 1]))
                    {
                        routeNumbers.Add(i);
                        break;
                    }
                }
            }
            return routeNumbers.ToArray();
        }

        //public int[] GetInnerRouteNumbers(int[,] graph,int vertices,int start, int end)
        //{
        //    FindShortestPath find = new FindShortestPath();
        //    List<int[]> allPaths = find.GetShortestPathList(graph, vertices, start);
        //    int[] path = allPaths[end];
        //    List<int> routeNumbers = new List<int>();

        //    for (int j = 0; j < path.Length - 1; j++)
        //    {
        //        for (int i = 0; i < graph.GetLength(0); i++)
        //        {
        //            if ((Data.innerRouteEndpoints_1[i, 0] == path[j] && Data.innerRouteEndpoints_1[i, 1] == path[j + 1]) ||
        //                (Data.innerRouteEndpoints_1[i, 1] == path[j] && Data.innerRouteEndpoints_1[i, 0] == path[j + 1]))
        //            {
        //                routeNumbers.Add(i);
        //                break;
        //            }
        //        }
        //    }
        //    return routeNumbers.ToArray();
        //}
    }
}
