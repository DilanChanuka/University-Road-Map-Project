import 'dart:async';
import 'package:http/http.dart' as http;
//import 'package:uor_road_map/Screens/Map/drwaplace.dart';

 Future<String> getjsonvalue(String url) async
  {
      var data=await http.get(url);
      String finaldata;
      if(data.statusCode==200)
      {
         finaldata=data.body;        
      }
    
     String a='{"floor_0_locations":[[7.458963,69.489653],[7.125896,99.258964],[7.458963,19.489653]],"floor_2_routelocations":[[7.458963,69.489653],[7.125896,99.258964],[7.458963,19.489653]],"floor_1_routelocations":[[7.458963,69.489653],[7.125896,99.258964],[7.458963,19.489653]],"floor_0_routelocations":[[7.458963,69.489653],[7.125896,99.258964],[7.458963,19.489653]],"place":{"name":"Presentatio Room","lat":0.458963,"lon":80.458963},"floor_2_locations":[[7.458963,69.489653],[7.125896,99.258964],[7.458963,19.489653]],"stair_0_1_locations":[[7.458963,69.489653],[7.125896,99.258964],[7.458963,19.489653]],"stair_1_2_locations":[[7.458963,69.489653],[7.125896,99.258964],[7.458963,19.489653]],"floor_1_locations":[[7.458963,69.489653],[7.125896,99.258964],[7.458963,19.489653]]}';
      return a;
  }
