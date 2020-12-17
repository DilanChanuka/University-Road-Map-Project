import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:route_app/memberPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:route_app/memberPage.dart';
//import 'package:route_app/login_page.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        accentColor: Colors.white70
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      routes: <String, WidgetBuilder> {
        '/memberPage': (BuildContext context)=> new memberPage(),
      }
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  TextEditingController user = new TextEditingController();
  TextEditingController pass = new TextEditingController();
String msg='';
  Future<List> _login() async {
    final response = await http.post(
        "http://127.0.0.1/route_app/login.php", body: {
      "username": user.text,
      "password": pass.text,
    });

    var datauser =jsonDecode(response.body);

    if(datauser.length==0) {
      setState(() {
        msg='Login Failed !!!!!';
      });
    }
else {
  Navigator.pushReplacementNamed(context, '/memberPage');
    }



    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login"),),
      body: Container(
        child: Center(
            child: Column(
              children: <Widget>[
                Text("Username", style: TextStyle(fontSize: 18.0),),
                TextField(
                  controller: user,
                  decoration: InputDecoration(
                      hintText: 'username'

                  ),
                ),
                Text("Password", style: TextStyle(fontSize: 18.0),),
                TextField(
                  obscureText: true,
                  controller: pass,
                  decoration: InputDecoration(
                      hintText: 'password'
                  ),
                ),

                RaisedButton(
                    child: Text("Login"),
                    onPressed: () {
                      _login();
                    }),
                Text(msg,style: TextStyle(fontSize: 20.0,color: Colors.red),),
              ],
            )
        ),
      ),
    );
  }
}
