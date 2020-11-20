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
    
    // String a='{"floor_2_routelocations":[[5.125896,14.258964],[5.458963,56.489653],[5.125896,86.258964]],"stair_0_1_locations":[[7.125896,27.258964],[7.458963,69.489653],[7.125896,99.258964]],"floor_1_locations":[[3.125896,11.258964],[3.458963,53.489653],[3.125896,83.258964]],"floor_2_locations":[[13.125896000000001,41.258964],[13.458963,83.489653],[13.125896000000001,113.258964]],"floor_1_routelocations":[[1.125896,9.258964],[1.458963,51.489653],[1.125896,81.258964]],"floor_0_routelocations":[[12.125896000000001,19.258964],[12.458963,61.489653],[12.125896000000001,91.258964]],"stair_1_2_locations":[[7.125896,27.258964],[7.458963,69.489653],[7.125896,99.258964]],"floor_0_locations":[[8.125896000000001,16.258964],[8.458963,58.489653],[8.125896000000001,88.258964]],"outerroutelocations":[[1.125896,10.258964],[1.458963,52.489653],[1.125896,82.258964]]}';
      return finaldata;
  }
