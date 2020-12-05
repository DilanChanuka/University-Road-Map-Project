import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:map_interfaces/Screens/Common/data.dart';
import 'package:map_interfaces/Screens/Map/Display/Display_OuterPlace.dart';
import 'package:map_interfaces/Screens/Request/JsonBody.dart';
import 'package:map_interfaces/Screens/Request/request.dart';
import 'package:map_interfaces/Screens/Common/placeLatLng.dart';
import 'dart:async';
import 'package:map_interfaces/Screens/Request/ConvertData.dart';
import 'package:map_interfaces/Screens/Map/Display/Display_PlaceInIn.dart';
import 'package:map_interfaces/Screens/Map/Display/Display_getPlace.dart';
import 'package:map_interfaces/Screens/Map/Display/Display_getfloor.dart';
import 'package:map_interfaces/Screens/Map/Display/Display_OuterRiutes.dart';
import 'package:map_interfaces/Screens/Map/Display/Display_placeInout.dart';
import 'package:map_interfaces/page_tran.dart';
import 'package:map_interfaces/Screens/Map/Display/Display_OuterRiutes.dart';



Future<String> myfuture;

void disitionFunc(BuildContext context,List<String> arr)
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
          
          int selectedfloorId=getfloorID(arr[3]); //get selected floor ID
          int startFloorID=getsAdfloorID(arr[0]);
          int destinationID=allplaceID[arr[1]];
          int destfloorID=getsAdfloorID(arr[1]);//get destination floorID
          List<double> startarr=getStartLatLg(arr[0]);
          
          String url=getplaceInInRequest(departmentID,startFloorID , destinationID, startarr);
          
          myfuture=getjsonvalue(url);
          myfuture.then((response) =>{
              Navigator.push(
                context,
                
                MaterialPageRoute(
                  builder: (context)=>
                  DrawPlaceInIn(drawplaceinin(response),destinationID,startFloorID,selectedfloorId,destfloorID,arr[0])
                )),
                
                
          });
      }

      //drwa place inside to outside (drawplaceinout)
      else if(startInside==true && endOutside==true)
      {
          floorId=getsAdfloorID(arr[0]);//get Start floor id
          selectedFloorID=getfloorID(arr[3]); //default selected floor will be  destination place floor
          List<List<double>> startAdestLatLng=getStartADest(arr[0],arr[1]);
          String url=getplaceinOutRequest(departmentID, floorId, startAdestLatLng);
          
          Future<String> myfuture=getjsonvalue(url);
          myfuture.then((response) => {
            Navigator.push(
              context, 
              MaterialPageRoute(
                builder:(context)=>DrawPlaceInOut(drawplaceinout(response),selectedFloorID,arr[0])))
          });
      }

      //draw place  outside to inside ( drawplace)
      else if(startOutside==true && endInside==true)
      {
          List<double> startLatLng=getStartLatLg(arr[0]);
          int placeID=allplaceID[arr[1]]; //get destination place ID
          int destFloorID=getsAdfloorID(arr[1]);//get destination floorID (0 /1 / 2)
          int selectedfloorID=getfloorID(arr[3]);//get selected floor ID  (0 /1 / 2)
          String url=getplaceRequest(startLatLng, placeID, arr[4]);

          Future<String> myfuture=getjsonvalue(url);
          myfuture.then((response) =>{
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:(context)=>DrawPlace(drawplace(response),selectedfloorID,destFloorID)))
          });
      }

      //draw place outside to outside (drawRouteLine)
      else if(startOutside==true && endOutside==true)
      {
          List<List<double>> startAdestination=getStartADest(arr[0],arr[1]);
          String url=getrouteRequest(startAdestination,arr[4]);
         // _handleSubmitaddsearch(context);

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

void serachPlace(BuildContext context,String placeNameselected)
{

    bool inside=false;
    bool outside=false;

    if(inSidePlces.contains(placeNameselected))
        inside=true;
    else
        outside=true;
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
    
    if(inside)
    {
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
              builder:(context)=>DrawFloor(drawfloor(response),placeNameselected)))
        });

    }
    if(outside)
    {
        Navigator.push(
          context,
          MaterialPageRoute(builder:(context)=>DisplayOuterPlace(placeNameselected)));
    }
   
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

int getsAdfloorID(String placeName)
{
  int id=0; //default floor is  first floor
  if(first_floor.contains(placeName))
      id=1;
  if(second_floor.contains(placeName))
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

 Future<void> _handleSubmitaddsearch(BuildContext context,GlobalKey<State> _keyloader) async
  {
    try{
      Dialogs.showLoadingDialog(context,_keyloader);
      await Future.delayed(Duration(seconds: 3,));
      Navigator.of(_keyloader.currentContext,rootNavigator: true).pop();

     // Navigator.push(context,MaterialPageRoute(builder: (context) => AddSearch()));
    }
    catch(error){
      print(error);
    }
  }