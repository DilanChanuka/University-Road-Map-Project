using System;
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

        public int[] GetInnerRouteNumbers(int outerEnd,int placeID)
        {
            int[] ids = GetDepartmentAndFloor(placeID);
            int[] matchInnerOuter,matchInnerPlace;
            int start=0, end=0,graphNo;
            switch (ids[1])
            {
                case 0:
                    matchInnerOuter = Data.InnerOuterMatch_0;
                    matchInnerPlace = Data.InnerPlaceMatch_0;
                    graphNo = 2;
                    break;
                case 1:
                    matchInnerOuter = Data.InnerOuterMatch_1;
                    matchInnerPlace = Data.InnerPlaceMatch_1;
                    graphNo = 3;
                    break;
                case 2:
                    matchInnerOuter = Data.InnerOuterMatch_2;
                    matchInnerPlace = Data.InnerPlaceMatch_2;
                    graphNo = 4;
                    break;
                default:
                    matchInnerOuter = Data.InnerOuterMatch_0;
                    matchInnerPlace = Data.InnerPlaceMatch_0;
                    graphNo = 2;
                    break;
            }                                   

            for (int i = 0; i < matchInnerOuter.Length; i++)
                if (matchInnerOuter[i] == outerEnd)
                {
                    start = i;
                    break;
                }

            for (int i = 0; i < matchInnerPlace.Length; i++)
                if (matchInnerPlace[i] == placeID)
                {
                    end = i;
                    break;
                }
            if (start != end)
                return GetRouteNumbers(graphNo, start, end);
            else
                return new int[] { };
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
                    graph = Data.innerRoutesGraph_0;
                    V_No = Data.innerGraphe_0_Vertices;
                    endPoints = Data.inner_0_RouteEndpoints;
                    break;
                case 3:
                    graph = Data.innerRoutesGraph_1;
                    V_No = Data.innerGraphe_1_Vertices;
                    endPoints = Data.inner_1_RouteEndpoints;
                    break;
                case 4:
                    graph = Data.innerRoutesGraph_2;
                    V_No = Data.innerGraphe_2_Vertices;
                    endPoints = Data.inner_2_RouteEndpoints;
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
                for (int i = 0; i < endPoints.GetLength(0); i++)
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
    }
}
