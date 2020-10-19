import 'package:flutter/material.dart';

class AddSSPage extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "University of Ruhuna",
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: Spage(),
    );
  }
}
class Spage extends StatefulWidget 
{
  @override
  _MHPage createState() => _MHPage();
}
class _MHPage extends State<Spage>
{
  String location,destination;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text("University of Ruhuna"),
            leading: IconButton(icon: Icon(Icons.menu),
             onPressed: () {}
             ),
          ),
          body: Center(
             child: _buildUser(),
          ),
        ), 
      ),
    );
  }
  Widget _buildUserLocation()
  {
    return Padding(
      padding: EdgeInsets.all(8),
        child: TextFormField(
          keyboardType: TextInputType.text,
          onChanged: (value){
            setState(() {
              location = value;
            });
          },
          decoration: InputDecoration(
            prefixIcon: Icon(
                Icons.my_location,
                color: Colors.blueAccent,
              ),
              labelText: "Enter your location"
          ),
        ),
      );
  }
  Widget _buildDestination()
  {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        keyboardType: TextInputType.text,
        onChanged: (value){
          setState(() {
            destination = value;
          });
        },
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.location_on,
              color: Colors.red,
            ),
            labelText: "Choose destination"
        ),
      ),
    );
  }
  Widget buildEnterButton()
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 2.5 * (MediaQuery.of(context).size.height / 20),
          width: 5 * (MediaQuery.of(context).size.width /10),
          margin: EdgeInsets.only(bottom: 20),
          child: RaisedButton(
            elevation: 5.0,
            color: Colors.greenAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            onPressed: () => {},
            child: Text(
              "Enter",
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1.5,
                fontSize: MediaQuery.of(context).size.height / 40,
              ),
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildUser()
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height*0.74,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Best Path",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height / 10,
                      ),
                    ),
                  ],
                ),
                _buildUserLocation(),
                _buildDestination(),
                 buildEnterButton(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}