import 'dart:convert';
import 'dart:async';
//import 'dart:html';
//import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:MapView/Map/drawline.dart';
import  'package:MapView/Common/data.dart';

 

List<LatLng> drawroute(String response)  //getroute 
{
    var jsonresponse=json.decode(response)['routelocations'];
    List<LatLng> finalDataArray=[];
    List<List<double>> array=List.generate(jsonresponse.length,(_)=>List.generate(2, (_) => 0.0));

    for(int i=0;i<jsonresponse.length;i++)
    {
        array[i][0]=jsonresponse[i][0];
        array[i][1]=jsonresponse[i][1];
    }

    for(int i=0;i<array.length;i++)
    {
        finalDataArray.add(LatLng(array[i][0],array[i][1]));
    }

    return finalDataArray;
}

List<LatLng> drawfloor(String jsonplaceholder)  //getfloor
{

    var jsonresponse=json.decode(jsonplaceholder);

    var floor0=jsonresponse["floor_0_locations"];
    var floor1=jsonresponse["floor_1_locations"];
    var floor2=jsonresponse["floor_2_locations"];
    var place=jsonresponse["place"];

    List<String> fResponse=["floor_0_locations","floor_1_locations","floor_2_locations"];

    List<List<double>> f0Location;
    List<List<double>> f1Location;
    List<List<double>> f2Location;
    List<dynamic> releventF=[f0Location,f1Location,f2Location];
    List<LatLng> finalArray=[];
      
    String name;
    double lat,lng;

    //get place details
      if(place.length>0)
      {         
          if(place!=null){
              Map<String,dynamic> map=place;
              name=map["name"];
              lat=map["lat"];
              lng=map["lon"];
          }  
      }

    //get relevent  floor details
    int floor=getUserFloor(jsonresponse);
    if(jsonresponse[fResponse[floor]]!=null)
    {
        int n=jsonresponse[fResponse[floor]].length;
        //initialize  2d array
        releventF[floor]=List.generate(n,(_)=>List.generate(2, (_) => 0.0));
        for(int i=0;i<n;i++)
        {
            releventF[floor][i][0]=jsonresponse[fResponse[floor]][i][0];
            releventF[floor][i][1]=jsonresponse[fResponse[floor]][i][1];
        }

        for(int i=0;i<releventF[floor].length;i++)
        {
            finalArray.add(LatLng(releventF[floor][i][0],releventF[floor][i][1]));
        }
    }

    return finalArray;

}

List<List<LatLng>> drawplaceout(String response,int selectedfloorId,int floorID) //getplaceinout
{

    var jsonresponse=json.decode(response);
    List<LatLng> finalDataArray=[];
    List<LatLng> finalFloorDataArray=[];
  
          var innerroutearray = jsonresponse["innerroutelocations"];
          var floor0array = jsonresponse["floor_0_locations"];
          var outerroutearray = jsonresponse["outerroutelocations"];
          var floor1array = jsonresponse["floor_1_locations"];
          var floor2array = jsonresponse["floor_2_locations"];

          List<String> floorlocation=["floor_0_locations","floor_1_locations","floor_2_locations"];

          // check user sitting floor 
          //int floor=getUserFloor(jsonresponse);
          int floor=floorID;
          int n=jsonresponse[floorlocation[floor]].length;
          //2d array
          List<List<double>> inner=List.generate(innerroutearray.length,(_)=>List.generate(2, (_) => 0.0));
          List<List<double>> outer=List.generate(outerroutearray.length,(_)=>List.generate(2, (_) => 0.0));
          List<List<double>> floordata=List.generate(n,(_)=>List.generate(2, (_) => 0.0));//select relevent floor

          List<int> length=[innerroutearray.length,outerroutearray.length,n];
          List<dynamic> dataarray=[inner,outer,floordata];
          List<String> jsonarray=["innerroutelocations","outerroutelocations",floorlocation[floor]];

          if(innerroutearray.length>0 || floor0array.length >0 
          || outerroutearray.length>0 || floor1array.length>0 || floor2array.length>0)
          {
              for(int i=0;i<3;i++) //for 3 json array
              {
                  for(int j=0;j<length[i];j++) //get data for each double array
                  {
                      dataarray[i][j][0]=jsonresponse[jsonarray[i]][j][0];
                      dataarray[i][j][1]=jsonresponse[jsonarray[i]][j][1];
                  }
              }
          } 
          
          //inner route array
        for(int i=0;i<inner.length;i++)
        {
            finalDataArray.add(LatLng(inner[i][0],inner[i][1]));
        }

        //outer route array
        for(int i=0;i<outer.length;i++)
        {
            finalDataArray.add(LatLng(outer[i][0], outer[i][1]));
        }

        //floor location Array
        for(int i=0;i<floordata.length;i++)
        {
            finalFloorDataArray.add(LatLng(floordata[i][0],floordata[i][1]));
        }
     
       List<List<LatLng>> arr=[];
       arr.add(finalDataArray);
       arr.add(finalFloorDataArray);
   
    return arr;
}

List<List<LatLng>> drawplacaeinin(String response,int destinationID,int selectedFloorID,int floorID)  //getplaceinin
{

    var jsonresponse=json.decode(response);
    var floor0location = jsonresponse["floor_0_locations"];
    var floor1location = jsonresponse["floor_1_locations"];
    var floor2location = jsonresponse["floor_2_locations"];
    var floor0Routelocation = jsonresponse["floor_0_routelocations"];
    var floor1Routelocation = jsonresponse["floor_1_routelocations"];
    var floor2Routelocation = jsonresponse["floor_2_routelocations"];
    var stair12location = jsonresponse["stair_1_2_locations"];
    var stair01location = jsonresponse["stair_0_1_locations"];
    var place=jsonresponse["place"];

    String name;
    double lat,lng;
    String derection;

    List<LatLng> finalRouteArray=[];
    List<LatLng> finalStairArray=[];
    List<LatLng> finalFloorLocation=[]; //relevent selected floor id

    List<String> floorlocation=["floor_0_locations","floor_1_locations","floor_2_locations"];
    List<String> floorRlocation=["floor_0_routelocations","floor_1_routelocations","floor_2_routelocations"];
    List<String> stair=["stair_0_1_locations","stair_1_2_locations"];

    List<List<double>> stair01;
    List<List<double>> stair12;

    //int start=getUserFloor(jsonresponse);  // get user sitting floor number (0/1/2)
    int start=floorID;

    int destFloor=getdestionationFloor(destinationID);  //get destination floor number(0/1/2)
    derection=getderection(start,destFloor);  //get dierection (UP /DOWN)
    if(stair12location!=null || stair01location!=null) //check user wants to stair
    {
        

        if(stair01location!=null)       
        {
            stair01=List.generate(stair01location.length,(_)=>List.generate(2, (_) => 0.0));     

            for(int i=0;i<stair01location.length;i++)
            {
                stair01[i][0]=jsonresponse["stair_0_1_locations"][i][0];
                stair01[i][1]=jsonresponse["stair_0_1_locations"][i][1];
            }
        }    
        else if(stair12location!=null)
        {
            stair12=List.generate(stair12location.length,(_)=>List.generate(2, (_) => 0.0));

            for(int i=0;i<stair12location.length;i++)
            {
                stair12[i][0]=jsonresponse["stair_1_2_locations"][i][0];
                stair12[i][1]=jsonresponse["stair_1_2_locations"][i][1];
            }
        }   

    }

    List<int> length=[getArraylength(jsonresponse[floorRlocation[0]]),
    getArraylength(jsonresponse[floorRlocation[1]]),
    getArraylength(jsonresponse[floorRlocation[2]])];

    List<int> fLLength=[getFLLength(jsonresponse[floorlocation[0]]),
    getFLLength(jsonresponse[floorlocation[1]]),
    getFLLength(jsonresponse[floorlocation[2]])];

    List<List<double>> floor0Route;
    List<List<double>> floor1Route;
    List<List<double>> floor2Route;
    
    List<List<double>> floor0Loc;
    List<List<double>> floor1Loc;
    List<List<double>> floor2Loc;

    List<dynamic> fRarray=[floor0Route,floor1Route,floor2Route];
    List<dynamic> fLarray=[floor0Loc,floor1Loc,floor2Loc];
    List<dynamic> stairArray=[stair01,stair12];


    int diference=(destFloor-start).abs();
    //create 2d arry
    if(diference==2) 
    {
       for(int k=0;k<MAX_FLOOR;k++)
       {
           //creatinf 2d array for store floor route Lat and Lng
            fRarray[k]=List.generate(length[k],(_)=>List.generate(2, (_) => 0.0));
       }

       //user wants to 3 floors 
       for(int i=0;i<MAX_FLOOR;i++)
       {
            
            for(int j=0;j<length[i];j++)
            {
                //floor Route Location
                fRarray[i][j][0]=jsonresponse[floorRlocation[i]][j][0];
                fRarray[i][j][1]=jsonresponse[floorRlocation[i]][j][1];
            }

            for(int j=0;j<fLLength[i];j++ )
            {
                
                //floor location
                fLarray[i][j][0]=jsonresponse[floorlocation[i]][j][0];
                fLarray[i][j][1]=jsonresponse[floorlocation[i]][j][1];
            }
       }      

    }
    else if(diference==1)
    {
       //user wants to  only start and destination floor(both are near (1/2) or (2/3))
       fRarray[start]=List.generate(length[start],(_)=>List.generate(2, (_) => 0.0));
       fRarray[destFloor]=List.generate(length[destFloor],(_)=>List.generate(2, (_) => 0.0));

       fLarray[start]=List.generate(length[start],(_)=>List.generate(2, (_) => 0.0));
       fLarray[destFloor]=List.generate(length[start],(_)=>List.generate(2, (_) => 0.0));

       List<int> sAdLength=[start,destFloor];

       for(int i=0;i<2;i++)
       {
           for(int j=0;j<length[sAdLength[i]];j++)
           {
                //floor Route Location
                fRarray[sAdLength[i]][j][0]=jsonresponse[floorRlocation[sAdLength[i]]][j][0];  //Lat
                fRarray[sAdLength[i]][j][1]=jsonresponse[floorRlocation[sAdLength[i]]][j][1];  //Lng

           }
          for(int j=0;j<fLLength[sAdLength[i]];j++)
          {
                
                //floor Location
                fLarray[sAdLength[i]][j][0]=jsonresponse[floorlocation[sAdLength[i]]][j][0];
                fLarray[sAdLength[i]][j][1]=jsonresponse[floorlocation[sAdLength[i]]][j][1];
          }

       }

    }
    else
    {
       //user wants to only start floor
       fRarray[start]=List.generate(length[start],(_)=>List.generate(2, (_) => 0.0));
       fLarray[start]=List.generate(length[start],(_)=>List.generate(2, (_) => 0.0));

       for(int i=0;i<length[start];i++)
       {
            fRarray[start][i][0]=jsonresponse[floorRlocation[start]][i][0]; //Lat
            fRarray[start][i][1]=jsonresponse[floorRlocation[start]][i][1]; //Lng
        
       }
       for(int i=0;i<fLLength[start];i++)
       {
            fLarray[start][i][0]=jsonresponse[floorlocation[start]][i][0];
            fLarray[start][i][1]=jsonresponse[floorlocation[start]][i][1];
       }
    }

    //get place details
    //if(data.statusCode==200)
    //{
          if(place.length>0)
          {
                Map<String,dynamic> map=place;
                name=map["name"];
                lat=map["lat"];
                lng=map["lon"];
          }
    //}
  //in here draw route acoudinf to  innera  and outer 2d aray

  if(derection=="UP") 
  {
      if(fRarray[selectedFloorID]!=null)
      {
            //draw route ---> fRarray[selectedFloorID]

            for(int i=0;i<fRarray[selectedFloorID].length;i++)
            {
                finalRouteArray.add(LatLng(fRarray[selectedFloorID][i][0], fRarray[selectedFloorID][i][1]));
            }
           // print(fRarray[selectedFloorID]);
      }

      if(fLarray[selectedFloorID]!=null)
      {
          //drwa floor 
          for(int i=0;i<fLarray[selectedFloorID].length;i++)
          {
              finalFloorLocation.add(LatLng(fLarray[selectedFloorID][i][0],fLarray[selectedFloorID][i][1]));
          }

      }

      if(selectedFloorID<2 && stairArray[selectedFloorID]!=null)  //selectedfloorId= 0/1
      {
          //draw stair -->> stairArray[selectedFloorID]
          for(int i=0;i<stairArray[selectedFloorID].length;i++)
          {
             finalStairArray.add(LatLng(stairArray[selectedFloorID], stairArray[selectedFloorID][i][1]));
          }

          //print(stairArray[selectedFloorID]);
      }

  }
  else if(derection=="DOWN")
  {
     
      if(fRarray[selectedFloorID]!=null)
       {
             //draw route --->>  fRarray[selectedFloorID]
         for(int i=0;i<fRarray[selectedFloorID].length;i++)
         {
            finalRouteArray.add(LatLng(fRarray[selectedFloorID][i][0], fRarray[selectedFloorID][i][1]));
         }
       }

       if(fLarray[selectedFloorID]!=null)
       {
           for(int i=0;i<fLarray[selectedFloorID].length;i++)
           {
              finalFloorLocation.add(LatLng(fLarray[selectedFloorID][i][0],fLarray[selectedFloorID][i][1]));
           }
       }

       if(selectedFloorID==2 && stairArray[selectedFloorID-1]!=null)
       {
            //draw stair 1 to 2 -->> stairArray[selectedFloorID]
            for(int i=0;i<stairArray[1].length;i++)
            {
                finalStairArray.add(LatLng(stairArray[1][i][0],stairArray[1][i][1]));
            }
       }
       else if(selectedFloorID==1 && stairArray[selectedFloorID-1]!=null)
       {
            //draw stair 1 to 0 -->>  stairArray[selectedFloorID]
            for(int i=0;i<stairArray[0].length;i++)
            {
                finalStairArray.add(LatLng(stairArray[0][i][0],stairArray[0][i][1]));
            }

       }

  }
  else if(derection=="NO" && fRarray[selectedFloorID]!=null && fLarray[selectedFloorID]!=null)
  {
      //draw route -->> fRarray[selectedFloorID]

      if(fRarray[selectedFloorID]!=null)
       {
            
         for(int i=0;i<fRarray[selectedFloorID].length;i++)
         {
            finalRouteArray.add(LatLng(fRarray[selectedFloorID][i][0], fRarray[selectedFloorID][i][1]));
         }
       }

       if(fLarray[selectedFloorID]!=null)
       {
           for(int i=0;i<fLarray[selectedFloorID].length;i++)
           {
              finalFloorLocation.add(LatLng(fLarray[selectedFloorID][i][0],fLarray[selectedFloorID][i][1]));
           }
       }

  }  

    //return finalRouteArray   and finalstaireArray
    List<List<LatLng>> arr=[];
    arr.add(finalRouteArray);
    arr.add(finalStairArray);
    arr.add(finalFloorLocation);

    //return arr 
    return arr;
    
}

List<List<LatLng>> drawplace(String response)   //getplace   
{

  var jsonresponse=json.decode(response);

  var innrR=jsonresponse['innerroutelocations'];
  var outerR=jsonresponse['outerroutelocations'];
  var floor2L=jsonresponse['floor_2_locations'];
  var floor1L=jsonresponse['floor_0_locations'];
  var floor0L=jsonresponse['floor_0_locations'];

  List<String> floorlocation=["floor_0_locations","floor_0_locations","floor_2_locations"];
  List<LatLng> finalinnrArray=[];
  List<LatLng> finalouterArray=[];
  List<LatLng> finalFloorArray=[];

  var place=jsonresponse["place"];
  String name;
  double lat,lng;

  //get place details
  //if(data.statusCode==200)
 // {
    if(place.length>0)
    {         
         if(place!=null){
            Map<String,dynamic> map=place;
            name=map["name"];
            lat=map["lat"];
            lng=map["lon"];
         }  
    }
    // check user sitting floor 
  int floor=getUserFloor(jsonresponse);
  int n=jsonresponse[floorlocation[floor]].length;
 
  List<List<double>> inner=List.generate(innrR.length,(_)=>List.generate(2, (_) => 0.0));
  List<List<double>> outer=List.generate(outerR.length,(_)=>List.generate(2, (_) => 0.0));
  List<List<double>> floordata=List.generate(n,(_)=>List.generate(2, (_) => 0.0));//select relevent floor

  List<int> length=[innrR.length,outerR.length,n];
  List<dynamic> dataarray=[inner,outer,floordata];
  List<String> jsonarray=["innerroutelocations","outerroutelocations",floorlocation[floor]];


  if(innrR.legth>0 || outerR.length>0|| floor0L.length>0||
  floor1L.length>0 || floor2L.length>0)
  {
      for(int i=0;i<3;i++) //for 3 json array
      {
          for(int j=0;j<length[i];j++) //get data for each double array
          {
              dataarray[i][j][0]=jsonresponse[jsonarray[i]][j][0];
              dataarray[i][j][1]=jsonresponse[jsonarray[i]][j][1];
          }
      }  

  }

      //drwa route acording to dataarray data....................
    List<List<LatLng>> arr=[];

    //inner route
    for(int i=0;i<inner.length;i++)
    {
        finalinnrArray.add(LatLng(inner[i][0],inner[i][1]));
    }
    
    //outer
    for(int i=0;i<outer.length;i++)
    {
        finalouterArray.add(LatLng(outer[i][0],outer[i][1]));
    }

    
    for(int i=0;i<floordata.length;i++)
    {
        finalFloorArray.add(LatLng(floordata[i][0],floordata[i][1]));
    }

    arr.add(finalinnrArray);
    arr.add(finalouterArray);
    arr.add(finalFloorArray);

  return arr;
}

Future<bool> loginuser(String jsonplaceholder) async  //login user
{

    var data=await http.get(jsonplaceholder);

    if(data.statusCode==200)
          return true;
    else if(data.statusCode==401)
          return false;
    else
          return false;
}

int getUserFloor(var response)
{
    var floor0array = response["floor_0_locations"];
    var floor1array = response["floor_1_locations"];
    var floor2array = response["floor_2_locations"];
    int floor;
    if(floor0array!=null)
        floor=0;
    else if(floor1array!=null)
        floor=1;
    else if(floor2array!=null)
        floor=2;
    else
        floor=1;

    return floor;
}

int getArraylength(var response)
{
    if(response!=null)
      return response.length;
    else
      return 0;
}

int getFLLength(var response)
{
    if(response!=null)
      return response.length;
    else
      return 0;
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


