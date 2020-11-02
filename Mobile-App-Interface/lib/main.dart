import 'package:MapView/Request/ConvertData.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:MapView/Map/drawline.dart';
import 'package:MapView/Common/data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget 
{
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) 
  {
       
      return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(     
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
  
        home:DrawRouteLine(getplaceinOut())
      );
  }

  //2d array is lat and lng
  List<List<LatLng>> getplaceinOut(int deptId,int floorId,List<List<double>> array,int selectedfloorId)//Request a outside Place from inside
  {
          //start and destinationa location come from array 
        String deptID=deptId.toString();
        String floorID=floorId.toString();
        String sourcelat=array[0][0].toString();
        String sourcelng=array[0][1].toString();
        String destlat=array[1][0].toString();
        String destlng=array[1][1].toString();

        String url=port+"/getplaceinout/"+deptID+"/"+floorID+"/"+sourcelat+"/"+sourcelng+"/"+destlat+"/"+destlng+"";
        
        Future<String> path=jsondata(url);
        
        //get data from server (3 json array from )
        //String path1='{"floor_0_locations":[[1.125896,10.258964],[1.458963,52.489653],[1.125896,82.258964],[1.458963,2.489653]],"outerroutelocations":[[1.125896,10.258964],[1.458963,52.489653],[1.125896,82.258964],[1.458963,2.489653]],"innerroutelocations":[[7.467066, 81.012821],[7.467410, 81.017642],[7.466966, 81.018871],[7.467816, 81.019546]]}';
    return drawplaceout(path,selectedfloorId,floorId);

  } 

  List<List<LatLng>> getplaceInIn(int deptID,int floorID,int destinationID,List<double> array,int selectedfloorId) //Request a inside Place from inside
  {
        String sourcelat=array[0].toString();
        String sourcelng=array[1].toString();
        String deptId=deptID.toString();
        String floorId=floorID.toString();
        String destinationId=destinationID.toString();

        String url=port+"/getplaceinin/"+deptId+"/"+floorId+"/"+sourcelat+"/"+sourcelng+"/"+destinationId+"";
        Future<String> path=jsondata(url);

       return drawplacaeinin(path,selectedfloorId,destinationID,floorID);
  }

  List<LatLng> getfloor(int deptID,int floorID)
  {
          String deptId=deptID.toString();
          String floorId=floorID.toString();

          String url=port+"/getfloor/"+deptId+"/"+floorId+"";
           Future<String> path=jsondata(url);
      
          //2 json array from server
      return drawfloor(path);
          
  }

  List<List<LatLng>> getplace(List<double> array,int placeID,String vORf)
  {
          String sourcelat=array[0].toString();
          String sourcelng=array[1].toString();
          String placeId=placeID.toString();

          String url=port+"/getplace/"+sourcelat+"/"+sourcelng+"/"+placeId+"/"+vORf+"";
           Future<String> path=jsondata(url);
      return drawplace(path);  // 4 json array from server
  }

  List<LatLng> getroute(List<List<double>> array ,String vORf)
  {
        //start and destinationa location come from array 
        String sourcelat=array[0][0].toString();
        String sourcelng=array[0][1].toString();
        String destlat=array[1][0].toString();
        String destlng=array[1][1].toString();

        String url=port+"/getroute/"+sourcelat+"/"+sourcelng+"/"+destlat+"/"+destlng+"/"+vORf+"";

        Future<String> path=jsondata(url);
      
     return drawroute(path);  //get data from server (1 json array )
  }
  
  Future<String> jsondata(String url) async
  {
      var data=await http.get(url);
      String jsonresponse=json.decode(data.body);

      return jsonresponse;
  }

}
  

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
 
}
