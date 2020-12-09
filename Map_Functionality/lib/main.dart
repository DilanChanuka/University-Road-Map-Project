import 'Screens/Direction/Direction_page.dart';
import 'package:flutter/material.dart';
import 'Screens/Search/search_page.dart';
import 'Screens/Map/main_map.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black26,
      ),
     // home:Uor(), 
     //home: DirectionPage(),
   // home: SearchPage(),
   home: MainMap(),
    );
  }
}

