import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uor_road_map/Screens/Common/data.dart';
import 'package:uor_road_map/Screens/Request/JsonBody.dart';
import 'package:uor_road_map/Screens/Request/request.dart';
import 'package:uor_road_map/Screens/Common/placeLatLng.dart';
import 'dart:async';
import 'package:uor_road_map/Screens/Request/ConvertData.dart';
import 'package:uor_road_map/Screens/Map/Display/Display_PlaceInIn.dart';
import 'package:uor_road_map/Screens/Map/Display/Display_placeInout.dart';
import 'package:uor_road_map/Screens/Map/Display/Display_getPlace.dart';
import 'package:uor_road_map/Screens/Map/Display/Display_Route.dart';
import 'package:uor_road_map/Screens/Map/Display/Display_getfloor.dart';

void getnewScreen(BuildContext context,List<String> arr)
{
          int departmentID=getdepartmentID(arr[2]);

          int selectedfloorId=getfloorID(arr[3]); //get selected floor ID
          int startFloorID=getsAdfloorID(arr[0]);
          int destinationID=allplaceID[arr[1]];
          int destfloorID=getsAdfloorID(arr[1]);//get destination floorID
          List<double> startarr=getStartLatLg(arr[0]);
          
          String url=getplaceInInRequest(departmentID, selectedfloorId, destinationID, startarr);
          
          Future<String> myfuture=getjsonvalue(url);
          myfuture.then((response) =>{
              Navigator.of(context).push(
                
                MaterialPageRoute(
                  builder: (context)=>
                  DrawPlaceInIn(drawplaceinin(response),destinationID,startFloorID,selectedfloorId,destfloorID)
                ))
          });
}



List<List<double>> getStartADest(String start,String dest)
{
    List<List<double>> arr=new List<List<double>>();
    //if Start is your location / have to get current location


    //if not 
    double startlat =placeLatLng[start][0];
    double startlng=placeLatLng[start][1];
    List<double> startval=[startlat,startlng];

    double endlat=placeLatLng[dest][0];
    double endlng=placeLatLng[dest][1];
    List<double> endval=[endlat,endlng];

    arr=[startval,endval];

  return arr;

    
}

int getdepartmentID(String department)
{
    int id=1; //default id =1 (cs depaerment)
    if(department.length>0)
        id=departmentID[department];
    
    return id;

}

int getfloorID(String floorName)
{

   int id=0;// defalut floor id is ground floor
  
   if(floorName=="First floor")
        id=1;
   if(floorName=="Second floor")
        id=2;

    return id;
}

int getsAdfloorID(String floorName)
{
  int id=0; //default floor is  first floor
  if(first_floor.contains(floorName))
      id=1;
  if(second_floor.contains(floorName))
    id=2;

  return id;
}

List<double> getStartLatLg(String start) 
{
   // if start is your location we have to get user current location

   //if not 
   double lat=placeLatLng[start][0];
   double lng=placeLatLng[start][1];
   List<double> arr=[lat,lng];
   
   return arr;
}

int getfloorIdWithName(String placeName)
{
   //in this disition relevent floor id using place name

   int id=1; //default floor is first floor
   if(ground_floor.contains(placeName))
      id=0;
   else if(second_floor.contains(placeName))
      id=2;
    
    return id;
}

