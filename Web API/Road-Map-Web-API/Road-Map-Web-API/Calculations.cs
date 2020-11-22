using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using RoadMap_DB.DataAccess;

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
                temp = LocationData.GetVertexLoaction(graphNo,i);
                distance[i] = Math.Sqrt(Math.Pow(lat - temp[0], 2) + Math.Pow(lon - temp[1], 2));
            }
            return Array.IndexOf(distance, distance.Min());
        }

        public int GetNearestVertexNo(int department,int floor,int noOfVertices, int graphNo, double lat, double lon)
        {
            double[] distance = new double[noOfVertices];
            for (int i = 0; i < noOfVertices; i++)            
                distance[i] = int.MaxValue;            
            double[] temp;
            int[] verticesSet;
            //according to the department,vertices set should change
            if (floor == 0)
                verticesSet = Data.CSFloo_0_VerticesSet;
            else if (floor == 1)
                verticesSet = Data.CSFloo_1_VerticesSet;
            else
                verticesSet = Data.CSFloo_2_VerticesSet;

            foreach (int V in verticesSet)
            {
                temp = LocationData.GetVertexLoaction(graphNo, V);
                distance[V] = Math.Sqrt(Math.Pow(lat - temp[0], 2) + Math.Pow(lon - temp[1], 2));
            }
            return Array.IndexOf(distance, distance.Min());
        }

        public int FindEnterenceVertexNo(int noOfVertices, int graphNo, int start)
        {
            int[,] graph;
            if (graphNo == 0)
                graph = Data.flootRoutesGraph;
            else
                graph = Data.vehicleRoutesGraph;
            
            FindShortestPath find = new FindShortestPath();
            int[] dist= find.GetShortestDistanceList(graph, noOfVertices, start);
            int[] distance = new int[Data.EntranceOuterMatch.Length];
            for (int i = 0; i < Data.EntranceOuterMatch.Length; i++)
                distance[i] = dist[Data.EntranceOuterMatch[i]];

            //according to the department,Entrance outer match should change
            return  Data.EntranceOuterMatch[Array.IndexOf(distance, distance.Min())];
        }

        public int[] FindEnterenceVertexNo(int dept_ID,int floorID,double startlat, double startlon, double endlat, double endlon)
        {
            double[,] entrance = LocationData.GetEntranceLocations(dept_ID);
            double[] distance = new double[entrance.GetLength(0)];
            int entranceNumber;
            List<int> entranceAndInnerVertex = new List<int>();
            for (int i = 0; i < entrance.GetLength(0); i++)
            {
                distance[i] = Math.Sqrt(Math.Pow(startlat - entrance[i, 0], 2) + Math.Pow(startlon - entrance[i, 1], 2)) +
                        Math.Sqrt(Math.Pow(endlat- entrance[i, 0], 2) + Math.Pow(endlon - entrance[i, 1], 2));
            }
            entranceNumber = Array.IndexOf(distance, distance.Min());
            entranceAndInnerVertex.Add(entranceNumber);
            //according to the department,Entrance inner match should change            
            entranceAndInnerVertex.Add(Data.CSMainEntranceInnerMatch[entranceNumber]);            

            return entranceAndInnerVertex.ToArray();
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
                    graph = Data.CSDepartmentGraph;
                    V_No = Data.CSDepartmentGrapheVertices;
                    endPoints = Data.CSDepartmentRouteEndpoints;
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

        public List<double[]> ValidateRoute(int start,int end,int graphNo,int routNo,double[,] route)
        {
            int[,] endPoints;
            if (graphNo == 0)
                endPoints = Data.foorRouteEndpoints;
            else if (graphNo == 1)
                endPoints = Data.vehicleRouteEndpoints;
            else 
                endPoints = Data.CSDepartmentRouteEndpoints;

            List<double[]> lst = new List<double[]>();
            int size = route.GetLength(0);
            double[] temp_1 = LocationData.GetVertexLoaction(graphNo, start);
            double[] temp_2 = LocationData.GetVertexLoaction(graphNo, end);

            if ((temp_1[0] == route[0, 0] && temp_1[1] == route[0, 1]) &&
                (temp_2[0] == route[size - 1, 0] && temp_2[1] == route[size - 1, 1]))
            {
                for (int i = 0; i < size; i++)
                    lst.Add(new double[] { route[i, 0], route[i, 1] });
                return lst;
            }
            if ((temp_2[0] == route[0, 0] && temp_2[1] == route[0, 1]) &&
                (temp_1[0] == route[size - 1, 0] && temp_1[1] == route[size - 1, 1]))
            {
                for (int i = size - 1; i >= 0; i--)
                    lst.Add(new double[] { route[i, 0], route[i, 1] });
                return lst;
            }

            if (temp_1[0] == route[0, 0] && temp_1[1] == route[0, 1])
            {
                for (int i = 0; i < size; i++)
                    lst.Add(new double[] { route[i, 0], route[i, 1] });

                if (endPoints[routNo, 0] == start)
                    Middle = endPoints[routNo, 1];
                else
                    Middle = endPoints[routNo, 0];
                return lst;
            }
            if (temp_1[0] == route[size-1, 0] && temp_1[1] == route[size-1, 1])
            {
                for (int i = size - 1; i >= 0; i--)
                    lst.Add(new double[] { route[i, 0], route[i, 1] });         

                if (endPoints[routNo, 0] == start)
                    Middle = endPoints[routNo, 1];
                else
                    Middle = endPoints[routNo, 0];
                return lst;
            }
            double[] mid = LocationData.GetVertexLoaction(graphNo, Middle);

            if ((mid[0] == route[0, 0] && mid[1] == route[0, 1]) &&
                (temp_2[0] == route[size - 1, 0] && temp_2[1] == route[size - 1, 1]))
            {
                for (int i = 0; i < size; i++)
                    lst.Add(new double[] { route[i, 0], route[i, 1] });
                return lst;
            }
            if ((temp_2[0] == route[0, 0] && temp_2[1] == route[0, 1]) &&
                (mid[0] == route[size - 1, 0] && mid[1] == route[size - 1, 1]))
            {
                for (int i = size - 1; i >= 0; i--)
                    lst.Add(new double[] { route[i, 0], route[i, 1] });
                return lst;
            }

            if (mid[0] == route[0, 0] && mid[1] == route[0, 1])
            {
                for (int i = 0; i < size; i++)
                    lst.Add(new double[] { route[i, 0], route[i, 1] });

                if (endPoints[routNo, 0] == Middle)
                    Middle = endPoints[routNo, 1];
                else
                    Middle = endPoints[routNo, 0];
                return lst;
            }
            if (mid[0] == route[size - 1, 0] && mid[1] == route[size - 1, 1])
            {
                for (int i = size - 1; i >= 0; i--)
                    lst.Add(new double[] { route[i, 0], route[i, 1] });

                if (endPoints[routNo, 0] == Middle)
                    Middle = endPoints[routNo, 1];
                else
                    Middle = endPoints[routNo, 0];
                return lst;
            }
            return lst;
        }

        void Revers2D(ref double[,] array)
        {
            int size = array.GetLength(0);
            double[] temp = new double[2];
            for (int i = 0; i < size; i++)
            {
                if (i >= size - (1 + i))
                    break;
                else
                {
                    temp[0] = array[i, 0];
                    temp[1] = array[i, 1];

                    array[i, 0] = array[size - (1 + i), 0];
                    array[i, 1] = array[size - (1 + i), 1];

                    array[size - (1 + i), 0] = temp[0];
                    array[size - (1 + i), 1] = temp[1];
                }
            }
        }

        public int Middle { get; set; }
    }
}
