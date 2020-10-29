import 'dart:convert';
import 'dart:async';
//import 'dart:html';
//import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:MapView/Map/drawline.dart';
import  'package:MapView/Common/data.dart';

 

void drawroute(String jsonplaceholder) async  //getroute -------------done
{

  var data=await http.get(jsonplaceholder);
  var jsonresponse=json.decode(data.body)['routelocations'];


  if(data.statusCode == 200)
  {
    List<dynamic> values=new List<dynamic>();
    values=jsonresponse;

    //create 2d array
    List<List<double>> data=List.generate(0,(_)=>List.generate(2, (_) => 0.0));
    if(values.length>0)
    {
      for(int i=0;i<values.length;i++)
      {
         if(values[i]!=null)
         {
            data[i][0]=values[i][0];
            data[i][1]=values[i][1]; 
         }
      }  
    }
     
    DrawRouteLine line=new DrawRouteLine(data);
    line.createState();

  }
  else
  {
    throw Exception('Failed to load');  
  }
}

void drawfloor(String jsonplaceholder) async  //getfloor
{

    var data=await http.get(jsonplaceholder);
    var jsonresponse=json.decode(data.body);
    List<List<double>> floorlocation=jsonresponse["floor_2_locations"];

    if(data.statusCode == 200)
    {
      

    }
    else
    {
      throw Exception('Failed to load');  
    }
}

void drawplaceout(String jsonplaceholder,int selectedfloorId,int floorID) async //getplaceinout
{

    var data=await http.get(jsonplaceholder);
    var jsonresponse=json.decode(data.body);

    if(data.statusCode==200)
    {
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
          
           //in here drwa route acoudinf to  innera  and outer 2d aray

   
    }
   
}

void drawplacaeinin(String jsonplaceholder,int destinationID,int selectedFloorID,int floorID) async  //getplaceinin
{

  var data=await http.get(jsonplaceholder);
  var jsonresponse=json.decode(data.body);

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

    List<String> floorlocation=["floor_0_locations","floor_1_locations","floor_2_locations"];
    List<String> floorRlocation=["floor_0_routelocations","floor_1_routelocations","floor_2_routelocations"];
    List<String> stair=["stair_0_1_locations","stair_1_2_locations"];

    List<List<double>> stair01;
    List<List<double>> stair12;

    //int start=getUserFloor(jsonresponse);  // get user sitting floor number (0/1/2)
    int start=floorID;

    int destFloor=getdestionationFloor(destinationID);  //get destination floor number(0/1/2)

    if(stair12location!=null || stair01location!=null) //check user wants to stair
    {
         derection=getderection(start,destFloor);  //get dierection (UP /DOWN)

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
            print(fRarray[selectedFloorID]);
      }
      if(selectedFloorID<2 && stairArray[selectedFloorID]!=null)
      {
          //draw stair -->> stairArray[selectedFloorID]
          print(stairArray[selectedFloorID]);
      }

  }
  else if(derection=="DOWN")
  {
     
      if(fRarray[selectedFloorID]!=null)
       {
             //draw route --->>  fRarray[selectedFloorID]
       }

       if(selectedFloorID==2)
       {
            //draw stair 1 to 2 -->> stairArray[selectedFloorID]
       }
       else if(selectedFloorID==1)
       {
            //draw stair 1 to 0 -->>  stairArray[selectedFloorID]
       }

  }
  else if(derection=="NO" && fRarray[selectedFloorID]!=null)
  {
      //draw route -->> fRarray[selectedFloorID]
  }  


}

void drawplace(String jsonplaceholder) async  //getplace
{

  var data=await http.get(jsonplaceholder);
  var jsonresponse=json.decode(data.body);

  List<List<double>> innerroute = jsonresponse['innerroutelocations'];
  List<List<double>> outerroute = jsonresponse['outerroutelocations'];
  List<List<double>> floor1location = jsonresponse['floor_1_locations'];
  var place=jsonresponse["place"];
  String name;
  double lat,lng;

  //or
    //Draw route
   DrawRouteLine line=new DrawRouteLine(innerroute);
   line.createState();
   
   DrawRouteLine line1=new DrawRouteLine(outerroute);
   line1.createState();

   DrawRouteLine line2=new DrawRouteLine(floor1location);
   line2.createState();

  //get place details
  if(data.statusCode==200)
  {
    if(place.length>0)
    {         
         if(place!=null){
            Map<String,dynamic> map=place;
            name=map["name"];
            lat=map["lat"];
            lng=map["lon"];
         }  
  }

  ///consider this later
  /*List<String> placeholder=["innerroutelocations","outerroutelocations","floor_1_locations"];
  if(data.statusCode == 200)
  {
    
    for(int i=0;i<3;i++)
    {
         List<dynamic> values=new List<dynamic>();
         values=jsonresponse[placeholder[i]];
          //create 2d array
          List<List<double>> data=List.generate(0,(_)=>List.generate(2, (_) => 0.0));
          if(values.length>0)
          {
            for(int i=0;i<values.length;i++)
            {
              if(values[i]!=null)
              {
                  data[i][0]=values[i][0];
                  data[i][1]=values[i][1];                
              }
            }  
          }
    }    
  }
  else
  {
    throw Exception('Failed to load');  
  }
  */
  }

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


