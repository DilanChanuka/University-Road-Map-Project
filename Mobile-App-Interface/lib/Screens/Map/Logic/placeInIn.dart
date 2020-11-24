import 'package:uor_road_map/Screens/Common/data.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

List<dynamic> placeInIn(List<dynamic> data,int destinationID,int start,int selectedFloorID)
{
// 0=> 0=>floor Route
//     1=>stair route
//     2=.floor location
// 1=.place LatLng
// 2=>place Name

    List<dynamic> finaldata=new List<dynamic>();
     //this will hold marker
    Set<Marker> _marker={};

    //this will hold polyline
    Set<Polyline> _polyline={}; 
  
    int destFloor=getdestionationFloor(destinationID);  //get destination floor number(0/1/2)
    String derection=getderection(start,destFloor);  //get dierection (UP /DOWN)
   
  if(data[0][2][selectedFloorID].length>0)
  {
      if(derection=="UP") 
      {
          //draw relevent floor route/ floor / and stair

          //add floor route polyline
          if(data[0][0][selectedFloorID].length>0)
          {
              Polyline routes=Polyline(
                polylineId:PolylineId("routes"),
                color: routeColor,
                width: routeWidth,
                points: data[0][0][selectedFloorID]);

                _polyline.add(routes);
          }

          //add floor location polyline
          if(data[0][2][selectedFloorID].length>0)
          {
              Polyline floor=Polyline(
                polylineId:PolylineId("floor"),
                color: floorColor,
                width: floorWidth,
                points: data[0][2][selectedFloorID]);

                _polyline.add(floor);
          }

          //add stair  polyline
          if(selectedFloorID==0)
          {
              //get stair01
              if(data[0][1][0].length>0)
              {
                  Polyline stair01=Polyline(
                    polylineId:PolylineId("stair01"),
                    color: stairColor,
                    width: stairWidth,
                    points: data[0][1][0]);

                    _polyline.add(stair01);
              }
              
          }

          if(selectedFloorID==1)
          {
              //get stair12
              if(data[0][1][1].length>0)
              {
                  Polyline stair12=Polyline(
                    polylineId:PolylineId("stair12"),
                    color: stairColor,
                    width: stairWidth,
                    points: data[0][1][1]);

                    _polyline.add(stair12);
              }
              
          }
      }
      else if(derection=="DOWN")
      {
          //draw relevent floor route/ floor / and stair

          //add floor route polyline
          if(data[0][0][selectedFloorID].length>0)
          {
              Polyline routes=Polyline(
                polylineId:PolylineId("routes"),
                color: routeColor,
                width: routeWidth,
                points: data[0][0][selectedFloorID]);

                _polyline.add(routes);
          }    
          //add floor location polyline
          if(data[0][2][selectedFloorID].length>0)
          {
              Polyline floor=Polyline(
                polylineId:PolylineId("floor"),
                color: floorColor,
                width: floorWidth,
                points: data[0][2][selectedFloorID]);

                _polyline.add(floor);
          }

          //add stair Polyline
          if(selectedFloorID==1)
          {
              //get stair01
              if(data[0][1][0].length>0)
              {
                  Polyline stair01=Polyline(
                    polylineId:PolylineId("stair01"),
                    color: stairColor,
                    width: stairWidth,
                    points: data[0][1][0]);

                    _polyline.add(stair01);
              }
              
          }
          if(selectedFloorID==2)
          {
              //get stair01
              if(data[0][1][1].length>0)
              {
                  Polyline stair12=Polyline(
                    polylineId:PolylineId("stair12"),
                    color: stairColor,
                    width: stairWidth,
                    points: data[0][1][1]);

                    _polyline.add(stair12);
              }
              
          }

      }
      else if(derection=="NO")
      {
          //add floor and floor routes

          //add floor routes polyline
          if(data[0][0][selectedFloorID].length>0)
          {
            Polyline  routes=Polyline(
              polylineId:PolylineId("routes"),
              color: routeColor,
              width: routeWidth,
              points: data[0][0][selectedFloorID]);

              _polyline.add(routes);
          }

          //add floor polyline
          if(data[0][2][selectedFloorID].length>0)
          {
            Polyline floor=Polyline(
              polylineId:PolylineId("floor"),
              color: floorColor,
              width: floorWidth,
              points: data[0][2][selectedFloorID]);

              _polyline.add(floor);
          }
        
      }

      //set map Marker
      _marker.add(Marker(
        markerId:MarkerId("destination"),
        position: LatLng(data[1][0], data[1][1])));

  }
    finaldata.add(_polyline);
    finaldata.add(_marker);

    return finaldata;

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
