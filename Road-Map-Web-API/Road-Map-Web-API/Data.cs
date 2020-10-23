using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Road_Map_Web_API
{
    public static class Data
    {
        #region PreDefined DataSet

        //no of vertices in the graphs
        public static int footGrapheVertices = 9;
        public static int innerGraphe_0_Vertices = 9;
        public static int innerGraphe_1_Vertices = 9;
        public static int innerGraphe_2_Vertices = 9;
        public static int vehicleGrapheVertices = 9;

        //end points of each route
        public static int[,] foorRouteEndpoints = new int[,]
        {
            {0,1 },{1,2 },{2,3 },{3,4 },{ 4,5},{5,6 },{6,7 },{0,7 },{1,7 },{ 7,8},{ 6,8},{2,8 },{2,5 },{ 3,5}
        };
        public static int[,] inner_0_RouteEndpoints = new int[,]
        {
            {0,1 },{1,2 },{2,3 },{3,4 },{ 4,5},{5,6 },{6,7 },{0,7 },{1,7 },{ 7,8},{ 6,8},{2,8 },{2,5 },{ 3,5}
        };
        public static int[,] inner_1_RouteEndpoints = new int[,]
        {
            {0,1 },{1,2 },{2,3 },{3,4 },{ 4,5},{5,6 },{6,7 },{0,7 },{1,7 },{ 7,8},{ 6,8},{2,8 },{2,5 },{ 3,5}
        };
        public static int[,] inner_2_RouteEndpoints = new int[,]
        {
            {0,1 },{1,2 },{2,3 },{3,4 },{ 4,5},{5,6 },{6,7 },{0,7 },{1,7 },{ 7,8},{ 6,8},{2,8 },{2,5 },{ 3,5}
        };
        public static int[,] vehicleRouteEndpoints = new int[,]
         {
            {0,1 },{1,2 },{2,3 },{3,4 },{ 4,5},{5,6 },{6,7 },{0,7 },{1,7 },{ 7,8},{ 6,8},{2,8 },{2,5 },{ 3,5}
         };

        //graphs of each map
        public static int[,] flootRoutesGraph = new int[,] { { 0, 4, 0, 0, 0, 0, 0, 8, 0 },
                                                      { 4, 0, 8, 0, 0, 0, 0, 11, 0 },
                                                      { 0, 8, 0, 7, 0, 4, 0, 0, 2 },
                                                      { 0, 0, 7, 0, 9, 14, 0, 0, 0 },
                                                      { 0, 0, 0, 9, 0, 10, 0, 0, 0 },
                                                      { 0, 0, 4, 14, 10, 0, 2, 0, 0 },
                                                      { 0, 0, 0, 0, 0, 2, 0, 1, 6 },
                                                      { 8, 11, 0, 0, 0, 0, 1, 0, 7 },
                                                      { 0, 0, 2, 0, 0, 0, 6, 7, 0 } };

        public static int[,] innerRoutesGraph_0 = new int[,] { { 0, 4, 0, 0, 0, 0, 0, 8, 0 },
                                                      { 4, 0, 8, 0, 0, 0, 0, 11, 0 },
                                                      { 0, 8, 0, 7, 0, 4, 0, 0, 2 },
                                                      { 0, 0, 7, 0, 9, 14, 0, 0, 0 },
                                                      { 0, 0, 0, 9, 0, 10, 0, 0, 0 },
                                                      { 0, 0, 4, 14, 10, 0, 2, 0, 0 },
                                                      { 0, 0, 0, 0, 0, 2, 0, 1, 6 },
                                                      { 8, 11, 0, 0, 0, 0, 1, 0, 7 },
                                                      { 0, 0, 2, 0, 0, 0, 6, 7, 0 } };

        public static int[,] innerRoutesGraph_1 = new int[,] { { 0, 4, 0, 0, 0, 0, 0, 8, 0 },
                                                      { 4, 0, 8, 0, 0, 0, 0, 11, 0 },
                                                      { 0, 8, 0, 7, 0, 4, 0, 0, 2 },
                                                      { 0, 0, 7, 0, 9, 14, 0, 0, 0 },
                                                      { 0, 0, 0, 9, 0, 10, 0, 0, 0 },
                                                      { 0, 0, 4, 14, 10, 0, 2, 0, 0 },
                                                      { 0, 0, 0, 0, 0, 2, 0, 1, 6 },
                                                      { 8, 11, 0, 0, 0, 0, 1, 0, 7 },
                                                      { 0, 0, 2, 0, 0, 0, 6, 7, 0 } };

        public static int[,] innerRoutesGraph_2 = new int[,] { { 0, 4, 0, 0, 0, 0, 0, 8, 0 },
                                                      { 4, 0, 8, 0, 0, 0, 0, 11, 0 },
                                                      { 0, 8, 0, 7, 0, 4, 0, 0, 2 },
                                                      { 0, 0, 7, 0, 9, 14, 0, 0, 0 },
                                                      { 0, 0, 0, 9, 0, 10, 0, 0, 0 },
                                                      { 0, 0, 4, 14, 10, 0, 2, 0, 0 },
                                                      { 0, 0, 0, 0, 0, 2, 0, 1, 6 },
                                                      { 8, 11, 0, 0, 0, 0, 1, 0, 7 },
                                                      { 0, 0, 2, 0, 0, 0, 6, 7, 0 } };

        public static int[,] vehicleRoutesGraph = new int[,] { { 0, 4, 0, 0, 0, 0, 0, 8, 0 },
                                                      { 4, 0, 8, 0, 0, 0, 0, 11, 0 },
                                                      { 0, 8, 0, 7, 0, 4, 0, 0, 2 },
                                                      { 0, 0, 7, 0, 9, 14, 0, 0, 0 },
                                                      { 0, 0, 0, 9, 0, 10, 0, 0, 0 },
                                                      { 0, 0, 4, 14, 10, 0, 2, 0, 0 },
                                                      { 0, 0, 0, 0, 0, 2, 0, 1, 6 },
                                                      { 8, 11, 0, 0, 0, 0, 1, 0, 7 },
                                                      { 0, 0, 2, 0, 0, 0, 6, 7, 0 } };

        //includes place numbers for relavelt inner graph vertex number 
        //index=inner vertex number,value=place id
        public static int[] InnerPlaceMatch_0 = new int[] { 4, 5, 6, 7, 8, 9 };
        public static int[] InnerPlaceMatch_1 = new int[] { 4, 5, 6, 7, 8, 9 };
        public static int[] InnerPlaceMatch_2 = new int[] { 4, 5, 6, 7, 8, 9 };

        //includes foot graph vertex numbers for relavelt inner graph 
        //index=inner vetex number,value=foot graph vertex no
        public static int[] InnerOuterMatch_0 = new int[] { 4, 5, 6, 7, 8, 9 };
        public static int[] InnerOuterMatch_1 = new int[] { 4, 5, 6, 7, 8, 9 };
        public static int[] InnerOuterMatch_2 = new int[] { 4, 5, 6, 7, 8, 9 };

        //includes foot graph vertex numbers for relavelt entrance number
        //index=entrance no,value=foot graph vertex no
        public static int[] EntranceOuterMatch = new int[] { 4, 5, 6, 7};


        #endregion
    }
}
