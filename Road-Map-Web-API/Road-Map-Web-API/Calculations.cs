using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Road_Map_Web_API
{
    public class Calculations
    {
        public int GetNearestVertexNo(int noOfVertices, double lat, double lon)
        {
            double[] distance = new double[noOfVertices];
            double[] temp;
            for (int i = 0; i < noOfVertices; i++)
            {
                temp = GetVertexLoaction(i);
                distance[i] = Math.Sqrt(Math.Pow(lat - temp[0], 2) + Math.Pow(lon - temp[1], 2));
            }
            return Array.IndexOf(distance, distance.Min());
        }

        public int[] GetFootRouteNumbers(int start,int end)
        {
            FindShortestPath find = new FindShortestPath();
            List<int[]> allPaths= find.GetShortestPathList(Data.footRoutesGraph, Data.footGrapheVertices, start);
            int[] path = allPaths[end];
            List<int> routeNumbers = new List<int>();

            for (int j = 0; j < path.Length-1; j++)
            {
                for (int i = 0; i < Data.foorRouteEndpoints.GetLength(0); i++)
                {
                    if((Data.foorRouteEndpoints[i,0]==path[j] && Data.foorRouteEndpoints[i, 1] == path[j + 1]) ||
                        (Data.foorRouteEndpoints[i, 1] == path[j] && Data.foorRouteEndpoints[i, 0] == path[j + 1]))
                    {
                        routeNumbers.Add(i);
                        break;
                    }
                }
            }
            return routeNumbers.ToArray();
        }
    }
}
