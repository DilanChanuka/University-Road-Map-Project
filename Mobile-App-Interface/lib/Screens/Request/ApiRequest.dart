import 'package:flutter/material.dart';
import 'ConvertData.dart';

String port=" https://localhost:44342/API";

class RequestHanddler extends StatefulWidget
{
        //get Route
      void getroute(List<List<double>> array ,String vORf)
      {
        //start and destinationa location come from array 
        String sourcelat=array[0][0].toString();
        String sourcelng=array[0][1].toString();
        String destlat=array[1][0].toString();
        String destlng=array[1][1].toString();

        String url=port+"/getroute/"+sourcelat+"/"+sourcelng+"/"+destlat+"/"+destlng+"/"+vORf+"";

        String path="F:\Flutter\Selanium\getroute.txt";
        drawroute(path);  //get data from server (1 json array )
      }

      void getplace(List<double> array,int placeID,String vORf)
      {
          String sourcelat=array[0].toString();
          String sourcelng=array[1].toString();
          String placeId=placeID.toString();

          String url=port+"/getplace/"+sourcelat+"/"+sourcelng+"/"+placeId+"/"+vORf+"";

          drawplace(url);  // 4 json array from server
      }

      void getfloor(int deptID,int floorID)
      {
          String deptId=deptID.toString();
          String floorId=floorID.toString();

          String url=port+"/getfloor/"+deptId+"/"+floorId+"";

          //2 json array from server
          drawfloor(url);
          
      }

      void getplaceinOut(int deptId,int floorId,List<List<double>> array,int selectedfloorId)//Request a outside Place from inside
      {
          //start and destinationa location come from array 
        String deptID=deptId.toString();
        String floorID=floorId.toString();
        String sourcelat=array[0][0].toString();
        String sourcelng=array[0][1].toString();
        String destlat=array[1][0].toString();
        String destlng=array[1][1].toString();

        String url=port+"/getplaceinout/"+deptID+"/"+floorID+"/"+sourcelat+"/"+sourcelng+"/"+destlat+"/"+destlng+"";

          //get data from server (3 json array from )
        drawplaceout(url,selectedfloorId,floorId);

      }

      void getplaceInIn(int deptID,int floorID,int destinationID,List<double> array,int selectedfloorId) //Request a inside Place from inside
      {
        String sourcelat=array[0].toString();
        String sourcelng=array[1].toString();
        String deptId=deptID.toString();
        String floorId=floorID.toString();
        String destinationId=destinationID.toString();

        String url=port+"/getplaceinin/"+deptId+"/"+floorId+"/"+sourcelat+"/"+sourcelng+"/"+destinationId+"";

        drawplacaeinin(url,selectedfloorId,destinationID,floorID);
      }

      void registeruser(String username,String email,String password)
      {

      }

      void loging(String username,String password)
      {

        String url=port+"/"+username+"/"+password+"";
        
      }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

}

