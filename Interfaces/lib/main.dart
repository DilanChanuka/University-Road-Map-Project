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

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black26,
      ),
      home:Uor(), 
    );
  }
}

