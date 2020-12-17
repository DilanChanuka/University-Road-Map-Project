//import 'package:MapView/Request/ConvertData.dart';
import 'package:uor_road_map/Screens/Request/ConvertData.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:MapView/Map/drawline.dart';
import 'package:uor_road_map/Screens/Map/drawline.dart';
//import 'package:MapView/Common/data.dart';
import 'package:uor_road_map/Screens/Common/data.dart';
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
    List<List<double>> arr=[[7.2154,80.2145],[7.01265,80.21457]];
      return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(     
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home:DrawRouteLine(getroute(arr,"v"))
      );
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
