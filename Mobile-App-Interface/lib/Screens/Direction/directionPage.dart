import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:uor_road_map/Screens/Map/drawRouteLine.dart';
import 'package:uor_road_map/constanents.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uor_road_map/Screens/Request/ConvertData.dart';
import 'package:uor_road_map/Screens/Common/data.dart';
import 'package:uor_road_map/Screens/Request/request.dart';

class AddDirection extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "University of Ruhuna",
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: Hpage(),
    );
  }
}
class Hpage extends StatefulWidget 
{
  @override
  _MHPage createState() => _MHPage();
}

class Side{
  int id;
  String name;

  Side(this.id,this.name);

  static List<Side> getSide(){
    return <Side>[
      Side(1, 'Out Side'),
      Side(2, 'In Side'),
    ];
  }
}

class _MHPage extends State<Hpage>
{

List<Side> _side = Side.getSide();
List<DropdownMenuItem<Side>> _dropdownMenuitem;
Side _selectedSide;

@override
void initState()
{
  _dropdownMenuitem = buildDropdownMenuItems(_side).cast<DropdownMenuItem<Side>>();
  _selectedSide = _dropdownMenuitem[0].value;
  super.initState();
} 

List<DropdownMenuItem<Side>> buildDropdownMenuItems(List sides){
  List<DropdownMenuItem<Side>> items = List();
  for(Side side in sides){
    items.add(
      DropdownMenuItem(
        value: side,
        child: Text(side.name),
      ),
    );
  }
  return items;
}

onChangeDropdwonItem(Side selectedSide){
  setState(() {
    _selectedSide = selectedSide;
  });
}

  String location,destination;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
           // title: Text("University of Ruhuna"),
            actions: <Widget>[
               SizedBox(width: 40.0,),
               DropdownButton(
                   value: _selectedSide,
                   items: _dropdownMenuitem, 
                   onChanged: onChangeDropdwonItem,
                   ),
              IconButton(
                icon: Icon(Icons.more_vert), 
                onPressed: () {},
                ),
            ],
            leading: IconButton(icon: Icon(Icons.menu),
             onPressed: () {}
             ),
             bottom: TabBar(
               tabs:[
                 Tab(icon: Icon(Icons.directions_car),
                 text: "Vehicle",
                 ),
                 Tab(icon: Icon(Icons.directions_walk),
                 text: "Walk",
                 ),
               ], 
               ),
          ), 
          body:
              TabBarView(
              children:[
                _tab1(),
                _tab2(),
               ],
              ),
        ),
      ),
    );
  }
  Widget _tab1()
  {
    return Container(
      child: _buildUserVehicle(),
    );
  }
  Widget _tab2()
  {
    return Container(
      child: _buildUserWalk(),
    );
  }

  Widget _buildUserLocationVehicle()
  {
    String vOr="v";
    return Padding(padding: EdgeInsets.all(8),
      child: DropDownField(
        controller: listSelect,
        hintText: "start location",
        enabled: true,
        items: list,
        onValueChanged: (value)
        {
           setState(() {
             startlocation = value;
           });
        },
      ),
    );
  }

  Widget _buildUserLocationWalk()
  {
    String vOr="f";
    return Padding(padding: EdgeInsets.all(8),
      child: DropDownField(
        controller: listSelect,
        hintText: "start location",
        enabled: true,
        items: list,
        onValueChanged: (value)
        {
           setState(() {
             startlocation = value;
           });
        },
      ),
    );
  }

  Widget _buildDestinationVehicle()
  {
    String vOr="v";
    return Padding(padding: EdgeInsets.all(8),
      child: DropDownField(
        controller: listSelecta,
        hintText: "Choose destination",
        enabled: true,
        items: lista,
        onValueChanged: (value)
        {
           setState(() {
             destination = value;
           });
        },
      ),
    );
  }

  Widget _buildDestinationWalk()
  {
    String vOr="f";
    return Padding(padding: EdgeInsets.all(8),
      child: DropDownField(
        controller: listSelecta,
        hintText: "Choose destination",
        enabled: true,
        items: lista,
        onValueChanged: (value)
        {
           setState(() {
             destination = value;
           });
        },
      ),
    );
  }

  Widget buildEnterButtonVehicle()
  {
    String vOr="v";
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: (MediaQuery.of(context).size.height / 20),
          width: 4 * (MediaQuery.of(context).size.width /10),
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

  Widget buildEnterButtonWalk()
  {
    String vOr="f";
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: (MediaQuery.of(context).size.height / 20),
          width: 4 * (MediaQuery.of(context).size.width /10),
          margin: EdgeInsets.only(bottom: 20),
          child: RaisedButton(
            elevation: 5.0,
            color: firstColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
              
           onPressed:(){
             
          },


            child: Text(
              "Enter....",
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

  Widget _buildUserVehicle()
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          child: Container(
            height: 2*(MediaQuery.of(context).size.height),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _buildUserLocationVehicle(),
                _buildDestinationVehicle(),
                 buildEnterButtonVehicle(),
                /*Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Texting!!! \n Texting!!!",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height / 10,
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

  Widget _buildUserWalk()
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _buildUserLocationWalk(),
                _buildDestinationWalk(),
                 buildEnterButtonWalk(),
                /* Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Texting!!! \nTexting!!!",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height / 10,
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

class initState {
}

//for text
List<String> list = ["Main Gate","Library","Scenes Library","Scenes Auditorium","Scenes Cantin","Art Cantin"];

final listSelect = TextEditingController();

String destination = "";
String startlocation = "";

List<String> lista = ["Auditorium" ,"E-Learning","Lab 1","Lab 2","Mini Auditorium"];

final listSelecta = TextEditingController();

String selecteda = "";



