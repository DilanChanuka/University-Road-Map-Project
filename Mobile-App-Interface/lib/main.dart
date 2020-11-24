import 'package:flutter/material.dart';
//import 'package:uor_road_map/Screens/Map/log_guest_map.dart';
//import 'package:uor_road_map/Screens/Map/main_map.dart';
//import 'package:uor_road_map/Screens/Map/search_map_show_page.dart';
import 'package:uor_road_map/load_page.dart';
//import 'package:uor_road_map/Screens/Welcome/welcome_page.dart';
//import 'package:uor_road_map/Screens/Map/addSearch_map_show_page.dart';
//import 'package:uor_road_map/Screens/Search/search_page.dart';
//import 'package:uor_road_map/Screens/AddSearch/add_search_page.dart';
//import 'package:uor_road_map/Screens/Term&Con/term_con_page.dart';
//import 'package:uor_road_map/Screens/SignUp/signup_page.dart';
//import 'package:uor_road_map/Screens/FPassword/forg_pass_page.dart';
//import 'package:uor_road_map/Screens/FPassword/reset_pwd_page.dart';
import 'Screens/Direction/direction_Page.dart';
import 'Screens/Map/search_map_show_page.dart';
import 'Screens/Search/search_page.dart';
import 'package:uor_road_map/Screens/Map/Display/Display_getfloor.dart';
import 'package:uor_road_map/Screens/Request/ConvertData.dart';
import 'package:uor_road_map/Screens/Map/Display/Display_Route.dart';
import 'package:uor_road_map/Screens/Map/Display/Display_placeInout.dart';
import 'package:uor_road_map/Screens/Map/Display/Display_PlaceInIn.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  //String a='{"floor_2_locations":[[5.940012,80.576011],[5.93991,80.576026],[5.939904,80.575928],[5.939807,80.575936],[5.939803,80.575962],[5.939809,80.57605],[5.939601,80.576067],[5.939599,80.575982],[5.939803,80.575962],[5.939809,80.57605],[5.939601,80.576067],[5.939605,80.576197],[5.939647,80.576225],[5.939609,80.576296],[5.939564,80.57627],[5.939605,80.576197],[5.939564,80.57627],[5.939529,80.576251],[5.939438,80.57642],[5.939617,80.576519],[5.939706,80.576344],[5.939663,80.576322],[5.9396,80.576438],[5.939503,80.576384],[5.939564,80.57627],[5.939503,80.576384],[5.9396,80.576438],[5.939663,80.576322],[5.939726,80.576216],[5.939721,80.576123],[5.939816,80.576124],[5.939813,80.576134],[5.939957,80.576361],[5.940127,80.576241],[5.94002,80.576063],[5.940012,80.576011],[5.940004,80.575923],[5.939904,80.575928]],"outerroutelocations":[[5.939808,80.57612],[5.939771,80.576175],[5.939771,80.576175],[5.939741,80.576355],[5.939741,80.576355],[5.939668,80.576322]],"floor_2_routelocations":[[5.939788,80.576097],[5.939852,80.576095],[5.939852,80.576095],[5.939855,80.576066]],"floor_1_locations":[[5.939934,80.576085],[5.939925,80.576056],[5.939866,80.576075],[5.939867,80.576106],[5.94001,80.576325],[5.939867,80.576106],[5.939934,80.576085],[5.94002,80.576063],[5.940127,80.576241],[5.94001,80.576325],[5.939957,80.576361],[5.939813,80.576134],[5.939816,80.576124],[5.939721,80.576123],[5.939726,80.576216],[5.939663,80.576322],[5.939706,80.576344],[5.939675,80.576407],[5.939631,80.576382],[5.939603,80.576431],[5.939649,80.576455],[5.939675,80.576407],[5.939649,80.576455],[5.939617,80.576519],[5.939569,80.57649],[5.939603,80.576431],[5.939569,80.57649],[5.939438,80.57642],[5.939529,80.576251],[5.939564,80.57627],[5.93954,80.576317],[5.939595,80.576357],[5.939624,80.576303],[5.939564,80.57627],[5.939605,80.576197],[5.939688,80.576185],[5.939681,80.57612],[5.939601,80.576125],[5.939605,80.576197],[5.939601,80.576125],[5.939599,80.575982],[5.939668,80.575977],[5.939677,80.576091],[5.939753,80.576082],[5.939744,80.575969],[5.939668,80.575977],[5.939744,80.575969],[5.939803,80.575962],[5.939817,80.576074],[5.939753,80.576082],[5.939744,80.575969],[5.939803,80.575962],[5.939807,80.575936],[5.939813,80.575988],[5.939893,80.575983],[5.939889,80.575931],[5.939807,80.575936],[5.939889,80.575931],[5.940004,80.575923],[5.94002,80.576063]],"stair_1_2_locations":[[5.939855,80.576066],[5.939842,80.576053]],"floor_1_routelocations":[[5.939842,80.576053],[5.939841,80.576073],[5.939841,80.576073],[5.939788,80.576091],[5.939788,80.576091],[5.939808,80.57612]]}';
  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black26,
      ),
      //home:DrawFloor(drawfloor(a)), 
      //home: DrawRouteLine(drawroute(a)),
      //home: DrawPlaceInOut(drawplaceinout(a),1),
      //home: DrawPlaceInIn(drawplaceinin(a),16,15,1,2),
      //home: SearchPage(),
      home: DirectionPage(),
    );
  }
}

