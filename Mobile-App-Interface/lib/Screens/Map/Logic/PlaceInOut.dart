import 'package:uor_road_map/Screens/Common/data.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

List<dynamic> placeInout(List<dynamic> data,int selectedFloorID)
{
      //0=>outer routes
      //1=>floor routes
      //      0=>ground floor
      //      0=>first floor
      //      0=>second floor
      //2=>stair routes
      //      0=>stair 01
      //      0=>stair 12
      //3=>floor cordinates
      //      0=>ground floor
      //      1=>first floor
      //      2=>second floor

    List<dynamic> finaldata=new List<dynamic>();
     //this will hold marker
    Set<Marker> _marker={};

    //this will hold polylinefg
    Set<Polyline> _polyline={}; 
  
    if(data[3][selectedFloorID].length>0)
    {
        //get outer routes polyline
        if(data[0].length>0)
        {
            Polyline outerR=Polyline(
              polylineId:PolylineId("outerR"),
              color: routeColor,
              width: routeWidth,
              points: data[0] );

              _polyline.add(outerR);
        }

        //add floor routes polyline
        if(data[1][selectedFloorID].length>0)
        {
            Polyline routes=Polyline(
              polylineId:PolylineId("routes"),
              color: routeColor,
              width:routeWidth,
              points:data[1][selectedFloorID]);

              _polyline.add(routes);
        }

        //add stair routes polyline
        if(selectedFloorID==2)
        {
          //join floor 2 routes and stair12 routes
         // data[2][1]=joinStair(data[2][1],data[1][2]);
          //stair12
          if(data[2][1].length>0)
          {
              Polyline stair12=Polyline(
                  polylineId:PolylineId("stair12"),
                  color: stairColor,
                  width:stairWidth,
                  points:data[2][1]);

                  _polyline.add(stair12);
          }
        }

        if(selectedFloorID==1)
        {
          //stair01
          if(data[2][0].length>0)
          {
              Polyline stair01=Polyline(
                  polylineId:PolylineId("stair01"),
                  color: stairColor,
                  width:stairWidth,
                  points:data[2][0]);

                  _polyline.add(stair01);
          }
        }
      

        //add floor polyline
        if(data[3][selectedFloorID].length>0)
        {
          Polyline floor=Polyline(
              polylineId:PolylineId("floor"),
              color: floorColor,
              width:floorWidth,
              points:data[3][selectedFloorID]);

              _polyline.add(floor);
        }
        
    }
    
    finaldata.add(_polyline);
   // finaldata.add(_marker);

    return finaldata;

}

List<LatLng> joinStair(List<LatLng> stair,List<LatLng> route)
{
    int last=route.length-1;
    stair.add(route[last]);

    return stair;
}


int getdestionationFloor(int id)
{
    if(groundFloor.contains(id))
        return 0;
    else if(firstFloor.contains(id))
        return 1;
    else if(secondFloor.contains(id))
        return 2;
    else
        return 1;
}
String getderection(int start,int end)
{
    if(start<end)
      return "UP";
    else if(start>end)
      return "DOWN";
    else if(start==end) //same floor
      return "NO";
    else
      return "NO";
}
