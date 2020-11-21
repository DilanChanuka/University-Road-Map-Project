import 'dart:convert';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:uor_road_map/Screens/Common/data.dart';
 

List<LatLng> drawroute(String jsonplaceholder)   //getroute   ---
{
  var jsonresponse=json.decode(jsonplaceholder)['routelocations'];
  print(1);
  int n=jsonresponse.length;
  print(n);
    //create 2d array
    List<List<double>> data=List.generate(n,(_)=>List.generate(2, (_) => 0.0));
    List<LatLng> routeL=[];
    for(int i=0;i<n;i++)
    {
        data[i][0]=jsonresponse[i][0];
        data[i][1]=jsonresponse[i][1];
    }

    for(int i=0;i<n;i++)
    {
        routeL.add(LatLng(data[i][0],data[i][1]));
    }
print(routeL);
    return routeL;

}

List<dynamic> drawfloor(String jsonplaceholder,int selectedfloorID)   //getfloor
{

    var jsonresponse=json.decode(jsonplaceholder);
    var floor0array = jsonresponse["floor_0_locations"];
    var floor1array = jsonresponse["floor_1_locations"];
    var floor2array = jsonresponse["floor_2_locations"];
    var places = jsonresponse["places"];  //this will come places array

    List<dynamic> finalarray=new List<dynamic>();

    List<String> floorlocation=["floor_0_locations","floor_1_locations","floor_2_locations"];
    int n=jsonresponse[floorlocation[selectedfloorID]].length;
    List<List<double>> releventfloor=List.generate(n,(_)=>List.generate(2, (_) => 0.0));
    int numPlaces=places.length;
    List<List<dynamic>> allplaces=new List<List<dynamic>>();
    List<LatLng> floorL=[];
    
  if(jsonresponse[floorlocation[selectedfloorID]]!=null)
  {
      for(int i=0;i<n;i++)
      {
        releventfloor[i][0]=jsonresponse[floorlocation[selectedfloorID]][i][0];
        releventfloor[i][1]=jsonresponse[floorlocation[selectedfloorID]][i][1];
      }

      for(int i=0;i<n;i++)
      {
          floorL.add(LatLng(releventfloor[i][0],releventfloor[i][1]));
      }
  }

  finalarray.add(floorL);

  //get places
  if(numPlaces!=null)
  {
      for(int i=0;i<numPlaces;i++)
      {   
          String name;
          double lat,lng;
          Map<String,dynamic> map=places[i];
          name=places[i]["name"];
          lat=places[i]["lat"];
          lng=places[i]["lon"];

          List<dynamic> oneplace=new List<dynamic>();
          oneplace.add(name);
          oneplace.add(lat);
          oneplace.add(lng);

          allplaces.add(oneplace);
          
      }
  }
  
  finalarray.add(allplaces);
  return finalarray;
    
}

List<dynamic> drawplaceinout(String response,int selectedfloorId) //getplaceinout
{


    var jsonresponse=json.decode(response);
    List<LatLng> finalDataArray=[];
    List<LatLng> finalFloorDataArray=[];
  
          var floor0RL = jsonresponse["floor_0_routelocations"];
          var floor1RL = jsonresponse["floor_1_routelocations"];
          var floor2RL = jsonresponse["floor_2_routelocations"];
          var floor0array = jsonresponse["floor_0_locations"];
          var floor1array = jsonresponse["floor_1_locations"];
          var floor2array = jsonresponse["floor_2_locations"];
          var stair01 = jsonresponse["stair_0_1_locations"];
          var stair12 = jsonresponse["stair_1_2_locations"];
          var outerR = jsonresponse["outerroutelocations"];
          
          

          List<String> floorlocation=["floor_0_locations","floor_1_locations","floor_2_locations"];
          List<String> floorRL=["floor_0_routelocations","floor_1_routelocations","floor_2_routelocations"];
          List<String> stairRL=["stair_0_1_locations","stair_1_2_locations"];
 

          List<LatLng> floor0R=[];
          List<LatLng> floor1R=[];
          List<LatLng> floor2R=[];

          List<LatLng> stair01R=[];
          List<LatLng> stair12R=[];

          List<LatLng> floor0=[];
          List<LatLng> floor1=[];
          List<LatLng> floor2=[];

          List<LatLng> finalouterR=[];

          List<dynamic> floorRC=[floor0R,floor1R,floor2R];
          List<dynamic> stairC=[stair01R,stair12R];
          List<dynamic> floorC=[floor0,floor1,floor2];

          //get outer route
          // outer routes must comr from json array
          if(outerR!=null)
          { 
               double a,b;
              for(int i=0;i<outerR.length;i++)
              { 
                a=outerR[i][0];
                b=outerR[i][1];
                finalouterR.add(LatLng(a,b));
              }
          }
         
          //get inner routes 
          //inner routes shoul be relevent selected floor route
          if(selectedfloorId==2)
          {
              //should be 0 1 and 2 floor routes if exist
              for(int i=0;i<3;i++)
              {
                  if(jsonresponse[floorRL[i]]!=null || jsonresponse[floorRL[selectedfloorId]]!=null)
                  {
                      int n=jsonresponse[floorRL[i]].length;
                      for(int j=0;j<n;j++)
                      {
                          floorRC[i].add(LatLng(jsonresponse[floorRL[i]][j][0],jsonresponse[floorRL[i]][j][1]));
                      }
                  }
              }

              //get stair
              //should be staie01 and stair12
              for(int i=0;i<2;i++)
              {
                  if(jsonresponse[stairRL[i]]!=null)
                  { 
                      int n=jsonresponse[stairRL[i]].length;
                      for(int j=0;j<n;j++)
                      {
                          stairC[i].add(LatLng(jsonresponse[stairRL[i]][j][0],jsonresponse[stairRL[i]][j][1]));
                      }
                  }
              }

              //get floor location
              if(jsonresponse[floorlocation[2]]!=null)
              {
                 int n=jsonresponse[floorlocation[2]].length;
                 for(int i=0;i<n;i++)
                 {
                    floorC[2].add(LatLng(jsonresponse[floorlocation[2]][i][0],jsonresponse[floorlocation[2]][i][1]));
                 }
              }
          }
          else if(selectedfloorId==1)
          {
             //get floor routes
             //should be 0 and 1 floor
             for(int i=0;i<2;i++)
             {
                if(jsonresponse[floorRL[i]]!=null || jsonresponse[floorRL[selectedfloorId]]!=null)
                {
                    int n=jsonresponse[floorRL[i]].length;
                    for(int j=0;j<n;j++)
                    {
                        floorRC[i].add(LatLng(jsonresponse[floorRL[i]][j][0],jsonresponse[floorRL[i]][j][1]));
                    }
                }
             }

             //get stair route cordinates
             //should be stair01 
             if(jsonresponse[stairRL[0]]!=null)
             {
                int n=jsonresponse[stairRL[0]].length;
                for(int i=0;i<n;i++)
                {
                    stairC[0].add(LatLng(jsonresponse[stairRL[0]][i][0],jsonresponse[stairRL[0]][i][1]));
                }
             }

             //get floor location
             if(jsonresponse[floorlocation[1]]!=null)
             {
                int n=jsonresponse[floorlocation[1]].length;
                for(int i=0;i<n;i++)
                {
                    floorC[1].add(LatLng(jsonresponse[floorlocation[1]][i][0],jsonresponse[floorlocation[1]][i][1]));
                }
             }           
          }
          else
          {
              //should be 0 floor

            //get floor route location
            if(jsonresponse[floorRL[0]]!=null)
            {
               int n=jsonresponse[floorRL[0]].length;
               for(int i=0;i<n;i++)
               {
                  floorRC[0].add(LatLng(jsonresponse[floorRL[0]][i][0],jsonresponse[floorRL[0]][i][1]));
               }
            }

            //get floor location
            if(jsonresponse[floorlocation[0]]!=null)
            {
                int n=jsonresponse[floorlocation[0]].length;
                for(int i=0;i<n;i++)
                {
                    floorC[0].add(LatLng(jsonresponse[floorlocation[0]][i][0],jsonresponse[floorlocation[0]][i][1]));
                }
            }
          }
      
      List<dynamic> allData=[];
      allData.add(finalouterR);
      allData.add(floorRC);
      allData.add(stairC);
      allData.add(floorC);

     return allData;
}

List<dynamic> drawplaceinin(String url,int destinationID,int selectedFloorID,int start) //getplaceinout
{
    
    var jsonresponse=json.decode(url);

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

    List<LatLng> floor0R=[];
    List<LatLng> floor1R=[];
    List<LatLng> floor2R=[];
    List<dynamic> floors=[floor0R,floor1R,floor2R];

    List<LatLng> floor0L=[];
    List<LatLng> floor1L=[];
    List<LatLng> floor2L=[];
    List<dynamic> floorLo=[floor0L,floor1L,floor2L];

    List<LatLng> stair01=[];
    List<LatLng> stair12=[];
    List<dynamic> stairArray=[stair01,stair12];

    int destFloor=getdestionationFloor(destinationID);  //get destination floor number(0/1/2)
    derection=getderection(start,destFloor);  //get dierection (UP /DOWN)
    int diference=(destFloor-start).abs();

    if(stair12location!=null || stair01location!=null) //check user wants to stair
    {
        //get stair01 location data for LatLng array
        if(stair01location!=null)       
        {

            for(int i=0;i<stair01location.length;i++)
            {
                double a=jsonresponse["stair_0_1_locations"][i][0];
                double b=jsonresponse["stair_0_1_locations"][i][1];
                stair01.add(LatLng(a,b));
            }
        }    

        //get stair12 location data for latLng array
       if(stair12location!=null)
        {

            for(int i=0;i<stair12location.length;i++)
            {
                double a=jsonresponse["stair_1_2_locations"][i][0];
                double b=jsonresponse["stair_1_2_locations"][i][1];
                stair12.add(LatLng(a,b));
            }
        }   
    }

    List<int> length=[getArraylength(jsonresponse[floorRlocation[0]]),
    getArraylength(jsonresponse[floorRlocation[1]]),
    getArraylength(jsonresponse[floorRlocation[2]])];

    List<int> fLLength=[getFLLength(jsonresponse[floorlocation[0]]),
    getFLLength(jsonresponse[floorlocation[1]]),
    getFLLength(jsonresponse[floorlocation[2]])];

    


    if(diference==2) 
    {
   const MAX_FLOOR=3;
       //user wants to 3 floors 
       for(int i=0;i<MAX_FLOOR;i++)
       {
            //get floor route
            if(jsonresponse[floorRlocation[i]]!=null)
            {
                //if data come width jasonresponse
                for(int j=0;j<length[i];j++)
                {
                   double a=jsonresponse[floorRlocation[i]][j][0];
                   double b=jsonresponse[floorRlocation[i]][j][1];
                   floors[i].add(LatLng(a,b));
                }
            }
            //get floor location
            if(jsonresponse[floorlocation[i]]!=null)
            {
                //if data com from json response
                for(int j=0;j<fLLength[i];j++)
                {
                    double a=jsonresponse[floorlocation[i]][j][0];
                    double b=jsonresponse[floorlocation[i]][j][1];
                    floorLo[i].add(LatLng(a,b));
                }
            }
       }      
    }
    else if(diference==1)
    {
      //user wants to 2 floor ,it should be nearest floor (1/2) of (0/1)
       List<int> sAdLength=[start,destFloor];

       for(int i=0;i<2;i++)
       {
            //get floor routes
            if(jsonresponse[floorRlocation[sAdLength[i]]]!=null)
            {
                //if data come from jsonresponse
                for(int j=0;j<length[sAdLength[i]];j++)
                {
                    double a=jsonresponse[floorRlocation[sAdLength[i]]][j][0];
                    double b=jsonresponse[floorRlocation[sAdLength[i]]][j][1]; 
                    floors[sAdLength[i]].add(LatLng(a,b));
                }
            }

            //get floor location
            if(jsonresponse[floorlocation[sAdLength[i]]]!=null)
            {
                for(int j=0;j<fLLength[sAdLength[i]];j++)
                {
                   double a=jsonresponse[floorlocation[sAdLength[i]]][j][0];
                   double b=jsonresponse[floorlocation[sAdLength[i]]][j][1];
                   floorLo[sAdLength[i]].add(LatLng(a,b));
                }     
            }
       }
    }
    else
    {
       //user wants to only start floor

       //get floor routes location
       if(jsonresponse[floorRlocation[start]]!=null)
       {
          for(int i=0;i<length[start];i++)
          {
              double a=jsonresponse[floorRlocation[start]][i][0];
              double b=jsonresponse[floorRlocation[start]][i][1];
              floors[start].add(LatLng(a,b));
          }
       }

       //get floor location
       if(jsonresponse[floorlocation[start]]!=null)
       {
          for(int i=0;i<fLLength[start];i++)
          {
              double a=jsonresponse[floorlocation[start]][i][0];
              double b=jsonresponse[floorlocation[start]][i][1];
              floorLo[start].add(LatLng(a,b));
          }
       }
    }

    //get place details
          if(place.length>0)
          {
                Map<String,dynamic> map=place;
                name=map["name"];
                lat=map["lat"];
                lng=map["lon"];
          }

  if(derection=="UP") 
  {
      if(floors[selectedFloorID].length>0)
      {
            finalRouteArray=floors[selectedFloorID];
      }
      if(selectedFloorID==0 && stairArray[selectedFloorID].length>0)  //selectedfloorId= 0/1
      {
          finalStairArray=stairArray[selectedFloorID];
      }
      else if(selectedFloorID==1 && stairArray[selectedFloorID].length>0)
      {
          finalStairArray=stairArray[selectedFloorID];
      }
  }
  else if(derection=="DOWN")
  {
      //get floor route
      if(floors[selectedFloorID].length>0)
       {
         finalRouteArray=floors[selectedFloorID];
       }
       //get stair                          //stair12
       if(selectedFloorID==2 && stairArray[selectedFloorID-1].length>0)
       {
           finalStairArray=stairArray[selectedFloorID-1];
       }

       else if(selectedFloorID==1 && stairArray[selectedFloorID-1].length>0)
       {
           finalStairArray=stairArray[selectedFloorID-1];
            
       }

  }
  else if(derection=="NO" && floors[selectedFloorID].length>0)
  {

      if(floors[selectedFloorID].length>0)
       {
          finalRouteArray=floors[selectedFloorID];

       }

  }  

  //get relevent floor location for final array

    if(floorLo[selectedFloorID].length>0)
    {
        finalFloorLocation=floorLo[selectedFloorID];

    }
    

    //return finalRouteArray   and finalstaireArray
    List<List<LatLng>> arr=[];
    arr.add(finalRouteArray);
    if(finalStairArray!=null)
      arr.add(finalStairArray);
    if(finalFloorLocation!=null)
      arr.add(finalFloorLocation);


    List<double> placeLatLng=[lat,lng];

    List<dynamic> allDetails=[arr,placeLatLng,name];

    return allDetails;
}

List<dynamic> drawplace(String jsonplaceholder,int selectedfloorID)  //getplace
{

        
      var jsonresponse=json.decode(jsonplaceholder);

      var floor0R=jsonresponse['floor_0_routelocations'];
      var floor1R=jsonresponse['floor_1_routelocations'];
      var floor2R=jsonresponse['floor_2_routelocations'];
      var outerR=jsonresponse['outerroutelocations'];
      var floor2L=jsonresponse['floor_2_locations'];
      var floor1L=jsonresponse['floor_1_locations'];
      var floor0L=jsonresponse['floor_0_locations'];
      var stair01=jsonresponse['stair_0_1_locations'];
      var stair12=jsonresponse['stair_1_2_locations'];
      var place=jsonresponse["place"];

      List<String> floorlocation=["floor_0_locations","floor_0_locations","floor_2_locations"];
      List<String> floorRL=["floor_0_routelocations","floor_1_routelocations","floor_2_routelocations"];
      List<String> stairRL=["stair_0_1_locations","stair_1_2_locations"];
    
      String name;
      double lat,lng;

      List<LatLng> finalFloor0R=[];
      List<LatLng> finalFloor1R=[];
      List<LatLng> finalFloor2R=[];

      List<LatLng> finalOuterR=[];

      List<LatLng> finalStair01=[];
      List<LatLng> finalStair12=[];

      List<LatLng> finalFloor0=[];
      List<LatLng> finalFloor1=[];
      List<LatLng> finalFloor2=[];
      
      List<dynamic> routes=[finalFloor0R,finalFloor1R,finalFloor2R];
      List<dynamic> stair=[finalStair01,finalStair12];
      List<dynamic> floor=[finalFloor0,finalFloor1,finalFloor2];

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
      List<dynamic> placeDetails=[name,lat,lng];

      //get outer route
      //outer route must come from json array
      double a,b;
      for(int i=0;i<outerR.length;i++)  
      {
          a=outerR[i][0];
          b=outerR[i][1];
          finalOuterR.add(LatLng(a,b));
      }
      //get inner routes
      //inner routes should get relevent selecteted floor 

      if(selectedfloorID==2)  //should be 0 1 and 2 floors
      {
          for(int i=0;i<3;i++)
          {
          
            if(jsonresponse[floorRL[i]]!=null || jsonresponse[selectedfloorID]!=null)
            {   
              int n=jsonresponse[floorRL[i]].length;
              for(int j=0;j<n;j++)
              {
                  routes[i].add(LatLng(jsonresponse[floorRL[i]][j][0],jsonresponse[floorRL[i]][j][1]));
              }
            }
          }

          //get stair
          //should be all stair (01  and 12)
          for(int i=0;i<2;i++)
          {
              
              if(jsonresponse[stairRL[i]]!=null )
              {
                  int n=jsonresponse[stairRL[i]].length;
                  for(int j=0;j<n;j++)
                  {
                      stair[i].add(LatLng(jsonresponse[stairRL[i]][j][0],jsonresponse[stairRL[i]][j][1]));
                  }
              }
          }

          //get floor location
          //should be relevent floor location ( floor 2)
          if(jsonresponse["floor_2_locations"]!=null)
          {
              int n=jsonresponse["floor_2_locations"].length;
              for(int i=0;i<n;i++)
              {
                  floor[2].add(LatLng(jsonresponse["floor_2_locations"][i][0],jsonresponse["floor_2_locations"][i][1]));
              }
          }

      }
      else if(selectedfloorID==1) //should be 0  and 1 floos
      {
        for(int i=0;i<2;i++)
        {
          
            if(jsonresponse[floorRL[i]]!=null || jsonresponse[selectedfloorID]!=null)
            {
                int n=jsonresponse[floorRL[i]].length;
                for(int j=0;j<n;j++)
                {
                    routes[i].add(LatLng(jsonresponse[floorRL[i]][j][0],jsonresponse[floorRL[i]][j][1]));
                }
            }
        }

          //get stair
          //should be one (01)
        
            
            if(jsonresponse[stairRL[0]]!=null )
            {
                int n=jsonresponse[stairRL[0]].length;
                for(int j=0;j<n;j++)
                {
                    stair[0].add(LatLng(jsonresponse[stairRL[0]][j][0],jsonresponse[stairRL[0]][j][1]));
                }
            }   

            //get floor location
          //should be relevent floor location ( floor 2)
          if(jsonresponse["floor_1_locations"]!=null)
          {
              int n=jsonresponse["floor_1_locations"].length;
              for(int i=0;i<n;i++)
              {
                  floor[1].add(LatLng(jsonresponse["floor_1_locations"][i][0],jsonresponse["floor_1_locations"][i][1]));
              }
          }  
      }
      else //should be  0 floor
      {
          
          if(jsonresponse[floorRL[0]]!=null || jsonresponse[selectedfloorID]!=null)
          {
              int n=jsonresponse[floorRL[0]].length;
              for(int j=0;j<n;j++)
              {
                routes[0].add(LatLng(jsonresponse[floorRL[0]][j][0],jsonresponse[floorRL[0]][j][1]));
              }
          }

              //get floor location
          //should be relevent floor location ( floor 2)
          if(jsonresponse["floor_0_locations"]!=null)
          {
              int n=jsonresponse["floor_0_locations"].length;
              for(int i=0;i<n;i++)
              {
                  floor[0].add(LatLng(jsonresponse["floor_0_locations"][i][0],jsonresponse["floor_0_locations"][i][1]));
              }
          }

      }
          
      List<dynamic> allData=[];
      allData.add(finalOuterR);
      allData.add(routes);
      allData.add(stair);
      allData.add(floor);
      allData.add(placeDetails);
      return allData;
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

List<dynamic> drawfloorWplace(String response) //getfloorwithplace
{

    var jsonresponse=json.decode(response);

    var floor0=jsonresponse["floor_0_locations"];
    var floor1=jsonresponse["floor_1_locations"];
    var floor2=jsonresponse["floor_2_locations"];
    var releventPlace=jsonresponse["place"];
    var otherplaces=jsonresponse["places"]; //other all places in relevent floor

    int releventfloor=getreleventfloor(jsonresponse);
    List<dynamic> arr=[floor0,floor1,floor2];

    List<dynamic> rPlace=[];
    List<dynamic> allplaces=[];
    //get place details
    if(releventPlace.length>0)
    {
        String name;
        double lat,lng;

        Map<String,dynamic> map=releventPlace;
        name=map["name"];
        lat=map["lat"];
        lng=map["lon"];

        rPlace.add(name);
        rPlace.add(lat);
        rPlace.add(lng);
    }

    //get other all places in relevent floor
    if(otherplaces!=null)
    {
        int count=otherplaces.length;
        
        for(int i=0;i<count;i++)
        {
            List<dynamic> oneplace=[];
            String name;
            double lat,lng;
            Map<String,dynamic> map=otherplaces[i];
            name=map["name"];
            lat=map["lat"];
            lng=map["lon"];

            oneplace.add(name);
            oneplace.add(lat);
            oneplace.add(lng);

            allplaces.add(oneplace);
        }
    }

    //get floor location
    List<LatLng> floorL=[];
    if(arr[releventfloor]!=null)
    {
          for(int i=0;i<arr[releventfloor].length;i++)
          {
            floorL.add(LatLng(arr[releventfloor][i][0],arr[releventfloor][i][1]));
          }
    }
    
    List<dynamic> finalData=[];
    finalData.add(floorL);
    finalData.add(rPlace);
    finalData.add(allplaces);

    return finalData;
}

int getreleventfloor(var data)
{
   if(data["floor_0_locations"]!=null)
      return 0;
   else if(data["floor_1_locations"]!=null)
      return 1;
   else
      return 2;
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
    if(floor.contains(id))
        return 0;
    else if(floor.contains(id))
        return 1;
    else if(floor.contains(id))
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


