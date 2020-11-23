import 'package:flutter/material.dart';
import 'package:MapInterfaces/Screens/Map/addSearch_map_show_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black26,
      ),
      home:AddSearch(), 
    );
  }
}

