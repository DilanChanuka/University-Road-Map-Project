import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:uor_road_map/constanents.dart';

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
      home: Scaffold(
          resizeToAvoidBottomPadding: false,
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
    );
  }
  Widget _buildUserLocation()
  {
    return Padding(
      padding: EdgeInsets.all(8),
        child: TextFormField(
          keyboardType: TextInputType.name,
          onChanged: (value){
            setState(() {
              location = value;
            });
          },
          decoration: InputDecoration(
            prefixIcon: Icon(
                Icons.my_location,
                color: firstColor,
              ),
              labelText: "Enter your location"
          ),
        ),
      );
    /*return Padding(padding: EdgeInsets.all(8),
      child: DropDownField(
        controller: listSelect,
        hintText: "Enter your location",
        enabled: true,
        items: list,
        onValueChanged: (value)
        {
           setState(() {
             selected = value;
           });
        },
      ),
    );*/
  }
  Widget _buildDestination()
  {
    return Padding(padding: EdgeInsets.all(8),
      child: DropDownField(
        controller: listSelecta,
        hintText: "Choose destination",
        enabled: true,
        items: lista,
        onValueChanged: (value)
        {
           setState(() {
             selecteda = value;
           });
        },
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
            color: firstColor,
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
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _buildUserLocation(),
                _buildDestination(),
                 buildEnterButton(),
                /* Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      "Texting!!! \n Texting!!!",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height / 30,
                      ),
                    ),
                  ],
                ),*/
              ],
            ),
          ),
        ),
      ],
    );
  }
}
//String selected = "";

/*List<String> list = ["Main Gate","Library","Scenes Library","Scenes Auditorium","Scenes Cantin","Art Cantin"];*/

//List<String> list = ["Matara","Dicwalla","Tangalle","Galle","Colombo","Kaluthara"];

//final listSelect = TextEditingController();

String selecteda = "";

List<String> lista = ["Auditorium" ,"E-Learning","Lab 1","Lab 2","Mini Auditorium"];

final listSelecta = TextEditingController();