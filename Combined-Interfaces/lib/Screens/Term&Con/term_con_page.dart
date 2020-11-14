import 'package:flutter/material.dart';
import 'package:uor_road_map/Screens/SignUp/signup_page.dart';

class TCPage extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: TCBody(),
    );
  }
}
class TCBody extends StatefulWidget
{
  @override
  _TermConPageState createState() => _TermConPageState();
}
class _TermConPageState extends State<TCBody>
{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            title: Text("University of Ruhuna"),
            leading: IconButton(icon: Icon(Icons.close),
             onPressed: () {
              Navigator.pop(context);
             }
             ),
          ),
          body: Container(
             child: Text("texting !!!! \n texting !!!! \n texting !!!!"),
          ),
      ),
    );
  }
}