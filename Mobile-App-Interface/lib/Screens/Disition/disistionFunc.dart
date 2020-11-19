import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uor_road_map/Screens/Common/data.dart';
import 'package:uor_road_map/Screens/Map/Draw_Map/drawRouteLine.dart';
import 'package:uor_road_map/Screens/Map/Draw_Map/drawfloor.dart';
import 'package:uor_road_map/Screens/Map/Draw_Map/drawplaceinout.dart';
import 'package:uor_road_map/Screens/Map/Draw_Map/drawplacewithfloor.dart';
import 'package:uor_road_map/Screens/Map/Draw_Map/drwaplace.dart';
import 'package:uor_road_map/Screens/Request/JsonBody.dart';
import 'package:uor_road_map/Screens/Request/request.dart';
import 'package:uor_road_map/Screens/Common/placeLatLng.dart';
import 'dart:async';
import 'package:uor_road_map/Screens/Map/Draw_Map/drawplaceInIn.dart';
import 'package:uor_road_map/Screens/Request/ConvertData.dart';
import 'package:http/http.dart' as http;

void disitionFunct(BuildContext context,List<String> arr)
{
    //0=>start place name
    //1=>destination place name
    //2=>department name
    //3=>floor name
    //4=>vOr

  bool startInside=false;
  bool startOutside=false;
  bool endInside=false;
  bool endOutside=false;

  if(arr[0]!=null && arr[1]!=null)
  {
     int departmentID=getdepartmentID(arr[2]);
     int floorId=0; //defalut ground floor
     int selectedFloorID=1; // default selected first floor

     //check start whether inside or outside
     if(inSidePlces.contains(arr[0]))
          startInside=true;
     else
          startOutside=true;

     //check destination whether inside or outside
     if(outSideplaces.contains(arr[1]))
        endOutside=true;
     else
        endInside=true;


      //drawplace inside to inside
      if(startInside==true && endInside==true)
      {
          
          floorId=getfloorID(arr[3]); //get selected floor ID
          int startFloorID=getsAdfloorID(arr[0]);
          int destinationID=allplaceID[arr[1]];
          List<double> startarr=getStartLatLg(arr[0]);
          
          String url=getplaceInInRequest(departmentID, floorId, destinationID, startarr, floorId);
          String a="https://my.api.mockaroo.com/my_saved_schema.json?key=8699f700";
          Future<String> myfuture=getjsonvalue(a);
          myfuture.then((response) =>{
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context)=>DrawPlaceInIn(drawplaceinin(response,destinationID,floorId,startFloorID))
                ))
          });
      }

      //drwa place inside to outside (drawplaceinout)
      else if(startInside==true && endOutside==true)
      {
          floorId=getfloorID(arr[3]);//get selected floor id
          selectedFloorID=getsAdfloorID(arr[1]); //default selected floor will be  destination place floor
          List<List<double>> startAdestLatLng=getStartADest(arr[0],arr[1]);
          String url=getplaceinOutRequest(departmentID, floorId, startAdestLatLng, selectedFloorID);

          Future<String> myfuture=getjsonvalue(url);
          myfuture.then((response) => {
            Navigator.push(
              context, 
              MaterialPageRoute(
                builder:(context)=>DrawPlaceinout(drawplaceinout(response, selectedFloorID))))
          });
      }

      //draw place  outside to inside ( drawplace)
      else if(startOutside==true && endInside==true)
      {
          List<double> startLatLng=getStartLatLg(arr[0]);
          int placeID=allplaceID[arr[1]]; //get destination place ID
          int selectedfloorID=getfloorID(arr[1]);
          String url=getplaceRequest(startLatLng, placeID, arr[4]);

          Future<String> myfuture=getjsonvalue(url);
          myfuture.then((response) =>{
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:(context)=>DrawPlace(drawplace(response, selectedfloorID)) ))
          });
      }

      //draw place outside to outside (drawRouteLine)
      else if(startOutside==true && endOutside==true)
      {
          List<List<double>> startAdestination=getStartADest(arr[0],arr[1]);
          String url=getrouteRequest(startAdestination,arr[4]);

          Future<String> myfuture=getjsonvalue(url);
          myfuture.then((response) => {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:(context)=>DrawRouteLine(drawroute(response))))
          });
           
      }
      
  }
}

void seachDisition(BuildContext context,String placeNameselected)
{

    //draw relevent floor with all places in relevent floor and  required place (drawfloorwithplace)
    
    /*int placeID=allplaceID[placeNameselected];
    String url =getfloorwithplaceRequest(placeID);
    Future<String> myfuture1=getjsonvalue(url);
    myfuture1.then((response) => {
       Navigator.push(
         context,
         MaterialPageRoute(
           builder:(context)=>Drawplacewithfloor(drawfloorWplace(response))
           ))

    });

*/
    
    //draw relevent floor and  all the places of relevent floor   (drawfloor)
    // in this department is cd departmet (ID => 1)
   int floorID= getfloorIdWithName(placeNameselected);
   int deptID=1; //cs department
   String url=getfloorRequest(deptID, floorID);

   Future<String> myfuture=getjsonvalue(url);
   myfuture.then((response) => {
     Navigator.push(
       context,
       MaterialPageRoute(
         builder:(context)=>Drawfloor(drawfloor(response,floorID))))
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

