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
     //String a='{"floor_2_locations":[[7.357911, 80.935412],[7.352394, 80.930181],[7.348597, 80.935259],[7.353203, 80.942557]],"places":[{"name":"Instructore\u0027s Room","lat":7.353330,"lon":80.936152},{"name":"Computer Lab 1","lat":7.353178,"lon": 80.934136},{"name":"Lecturers\u0027s Room","lat":7.354697,"lon": 80.934697}],"place":{"name":"Mini Auditorium","lat":7.353229,"lon":80.933804}}';
      return finaldata;
  }
