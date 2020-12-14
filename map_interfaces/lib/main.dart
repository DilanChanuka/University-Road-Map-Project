import 'package:flutter/material.dart';
import 'package:map_interfaces/Screens/Welcome/welcome_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black26,
      ),
      home:WelcomePage(), 
    );
  }
}
