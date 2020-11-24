/*
import 'dart:ffi';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uor_road_map/constanents.dart';
import 'package:uor_road_map/Screens/Common/data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:uor_road_map/Screens/Request/request.dart';

class AddSPage extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "University of Ruhuna",
      theme: ThemeData(
        primaryColor: Colors.white,
        backgroundColor: firstColor,
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

class _MHPage extends State<Hpage>
{

  int itm=0;

//GlobalKey<FormState> _fromkey = GlobalKey<FormState>();

  Future<String> createAlertDialog(BuildContext context) async{
    return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context,setState){

          return AlertDialog(
            title: Text("Select Department and Floor",
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
            content: Form(
              // key: _fromkey,


              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize:MainAxisSize.min,
                  children:<Widget>[
                    Text("Select Department"),
                    Container(
                      height:MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.lightGreen,
                      ),
                      child:SingleChildScrollView(
                        child: Column(
                          children: [
                            DropdownButton(
                                isExpanded: true,
                               hint: Text("Select Department"),
                                //value: departmentvalue,
                                underline: Container(
                                  height: 3,
                                  color: Colors.deepPurpleAccent,
                                ),
                                items: department.map((departmentvalue){
                                  return DropdownMenuItem(
                                    value: departmentvalue,
                                    child: Text(departmentvalue),
                                  );
                                }).toList(),
                                onChanged: (String dp){setState((){departmentvalue  = dp;});}
                            ),
                          ],
                        ),
                      ),
                    ),

                    Text("Select Floor"),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            //Padding(padding: EdgeInsets.all(12.0)),
                            DropdownButton(
                                isExpanded: true,
                                //hint: Text("Select Floor"),
                                value: floorvalue,
                                underline: Container(
                                  height: 3,
                                  color: Colors.deepPurpleAccent,
                                ),
                                items: floor.map((floorvlue){
                                  return DropdownMenuItem(
                                    value: floorvlue,
                                    child: Text(floorvlue),
                                  );
                                }).toList(),
                                onChanged: (String fl){setState((){floorvalue = fl;});}
                            ),
                          ],
                        ),
                      ),
                    ),


                  ],
                ),
              ),
            ),

            actions: <Widget>[
              MaterialButton(
                onPressed: (){
                  Navigator.of(context).pop();
                },
                child: Text("OK",
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          );
        },
        );
      },
    );
  }


  getrouteCoord(int org,int des,String type) async {
    var responseOrg = await http.post("http://10.0.2.2/origin.json");
    var responseDes = await http.post("http://10.0.2.2/dest.json");

    Map<String, dynamic> decodedo = json.decode(responseOrg.body);
    List<dynamic> co1 = decodedo['origins'];

    List<LatLng> coordsOrg = co1.map((pair) => LatLng(pair[0], pair[1])).toList();
   final source = c.LatLng(coordsOrg[0].latitude, coordsOrg[0].longitude);
    Map<String, dynamic> decodedd = json.decode(responseDes.body);
    List<dynamic> co2 = decodedd['destinations'];
    List<LatLng> coordsDes = co2.map((pair) => LatLng(pair[0], pair[1])).toList();
   final destination = c.LatLng(coordsDes[des].latitude, coordsDes[des].longitude);
    double sourcelat=source.lat;
    double sourcelng=source.lng;
    double destlat=destination.lat;
    double destlng=destination.lng;
    List<List<double>> arr=[[sourcelat,sourcelng],[destlat,destlng]];
    if (responseOrg.statusCode == 200 && responseDes.statusCode == 200) {
      if (coordsOrg[org].latitude != coordsDes[des].latitude &&
          coordsOrg[org].longitude != coordsDes[des].longitude) {
        Navigator.of(context).pushNamed(getrouteRequest(arr, type));
      }
    }

  }

  getplaceCoord(int org,int placeId,String type) async {
    var responseOrg = await http.post("http://10.0.2.2/origin.json");
    Map<String, dynamic> decodedo = json.decode(responseOrg.body);
    List<dynamic> co1 = decodedo['origins'];
    List<LatLng> coordsOrg = co1.map((pair) => LatLng(pair[0], pair[1])).toList();
    final source = c.LatLng(coordsOrg[0].latitude, coordsOrg[0].longitude);
    double sourcelat=source.lat;
    double sourcelng=source.lng;
    List<double> arr=[sourcelat,sourcelng];
    if (responseOrg.statusCode == 200) {
        Navigator.of(context).pushNamed(getplaceRequest(arr, placeId,type,1));
      }


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
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: firstColor,
            title: Text("UOR MAP"),
            actions: <Widget>[

              DropdownButton<int>(
                iconSize: 30.0,
                iconEnabledColor: mainColor,
                value: itm,
                items: [
                  DropdownMenuItem(
                    child: Text("Out Side",
                      style: TextStyle(fontSize: 25.0),
                    ),
                    value: 0,
                  ),
                  DropdownMenuItem(
                      child: Text("In Side",
                        style: TextStyle(fontSize: 25.0),
                      ),
                      value: 1,
                      onTap: () async {
                        await createAlertDialog(context);
                      }
                  ),
                ],
                onChanged: (int value){
                  setState(() {
                    itm = value;
                  });
                },
              ),

              //SizedBox(width: 40.0,),
              /* DropdownButton(
                   value: _selectedSide,
                   items: _dropdownMenuitem,
                   onChanged: onChangeDropdwonItem,
                   iconSize: 50.0,
                   onTap: (){
                     createAlertDialog(context).then((value) => "In Side");
                   },
                   ),*/
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
    return Padding(padding: EdgeInsets.all(8),
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
    );
  }

  Widget _buildUserLocationWalk()
  {
    return Padding(padding: EdgeInsets.all(8),
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
    );
  }

  Widget _buildDestinationVehicle()
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

  Widget _buildDestinationWalk()
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

  Widget buildEnterButtonVehicle()
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: (MediaQuery.of(context).size.height / 10),
          width: 6 * (MediaQuery.of(context).size.width /10),
          margin: EdgeInsets.only(bottom: 10,top: 60),
          child: RaisedButton(
            elevation: 5.0,
            color: firstColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            onPressed: () async {
              String type="v";
              String org=listSelect.text;
              String des=listSelecta.text;
              int a,b;
              bool _inside=false;
              if(itm==0) {

                for (int i = 0; i < list.length; i++) {
                  if (org == list[i]) {
                    a = i;
                  }
                }
                if(_inside==true) {
                  for (int j = 0; j < outside.length; j++) {
                    if (des == outside[j])
                      b = j;
                  }
                  getrouteCoord(a, b, type);
                   _inside=true;
                }
                else {
                  for (int j = 0; j < placeName.length; j++) {
                    if (des == placeName[j])
                      b = j;
                  }
                  getplaceCoord(a, b, type);
                }
              }
            },
            child: Text(
              "Enter",
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1.5,
                fontSize: MediaQuery.of(context).size.height / 20,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildEnterButtonWalk()
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: (MediaQuery.of(context).size.height / 10),
          width: 6 * (MediaQuery.of(context).size.width /10),
          margin: EdgeInsets.only(bottom: 10,top: 60),
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

  Widget _buildUserVehicle()
  {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[

        ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          child: Container(
            height:MediaQuery.of(context).size.height * 0.75,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              padding: EdgeInsets.only(top: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.3,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: mainColor,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            _buildUserLocationVehicle(),
                          ],
                        ),
                      ),
                    ),
                  ),

                  ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.3,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: mainColor,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            _buildDestinationVehicle(),
                          ],
                        ),
                      ),
                    ),
                  ),

                  ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.3,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: mainColor,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            buildEnterButtonVehicle(),
                          ],
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUserWalk()
  {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[

        ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          child: Container(
            height:MediaQuery.of(context).size.height * 0.75,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              padding: EdgeInsets.only(top: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.3,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: mainColor,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            _buildUserLocationWalk(),
                          ],
                        ),
                      ),
                    ),
                  ),

                  ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.3,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: mainColor,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            _buildDestinationWalk(),
                          ],
                        ),
                      ),
                    ),
                  ),

                  ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.3,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: mainColor,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            buildEnterButtonWalk(),
                          ],
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

//for text
List<String> list = ["Main Gate","Library","Scenes Library","Scenes Auditorium","Scenes Cantin","Art Cantin"];

final listSelect = TextEditingController();

String selected = "";

List<String> lista = ["Library" ,"E-Learning","Lab 1","Main Gate","Library","Art Canteen"];
List<String> inside = ["Auditorium" ,"E-Learning","Lab 1"];
List<String> outside = ["Main Gate","Library","Art Canteen"];
final listSelecta = TextEditingController();

String selecteda = "";

*/