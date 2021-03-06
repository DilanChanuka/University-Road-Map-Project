import 'dart:ffi';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uor_road_map/Screens/Map/drawplaceInIn.dart'as a;
import 'package:uor_road_map/Screens/Map/drawplaceinout.dart';
import 'package:uor_road_map/Screens/Map/drwaplace.dart';
import 'package:uor_road_map/Screens/Request/ConvertData.dart';
import 'package:uor_road_map/Screens/Request/JsonBody.dart';
import 'package:uor_road_map/constanents.dart';
import 'package:uor_road_map/Screens/Common/data.dart';
import 'package:http/http.dart' as http;
import 'package:uor_road_map/Screens/AddSearch/class.dart' as c;
import 'dart:convert';
import 'package:uor_road_map/Screens/Request/request.dart';
import 'package:uor_road_map/Screens/Map/drawRouteLine.dart';

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

class _MHPage extends State<Hpage> {

  int itm = 0;

//GlobalKey<FormState> _fromkey = GlobalKey<FormState>();

  Future<String> createAlertDialog(BuildContext context) async {
    return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
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
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text("Select Department"),
                    Container(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.1,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      decoration: BoxDecoration(
                        color: Colors.lightGreen,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            DropdownButton(
                                isExpanded: true,
                                //hint: Text("Select Department"),
                                value: departmentvalue,
                                underline: Container(
                                  height: 3,
                                  color: Colors.deepPurpleAccent,
                                ),
                                items: department.map((departmentvalue) {
                                  return DropdownMenuItem(
                                    value: departmentvalue,
                                    child: Text(departmentvalue),
                                  );
                                }).toList(),
                                onChanged: (String dp) {
                                  setState(() {
                                    departmentvalue = dp;
                                  });
                                }
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
                                items: floor.map((floorvlue) {
                                  return DropdownMenuItem(
                                    value: floorvlue,
                                    child: Text(floorvlue),
                                  );
                                }).toList(),
                                onChanged: (String fl) {
                                  setState(() {
                                    floorvalue = fl;
                                  });
                                }
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
                onPressed: () {
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
   final source = c.LatLng(coordsOrg[org].latitude, coordsOrg[org].longitude);
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
        String url=getrouteRequest(arr, type);
        Future<String> myFuture=getjsonvalue(url);
        myFuture.then((response) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context)=>DrawRouteLine(drawroute(response))));

        });
      }
    }

  }

  getplaceCoord(int org,int placeId,String type) async {
    var responseOrg = await http.post("http://10.0.2.2/origin.json");
    Map<String, dynamic> decodedo = json.decode(responseOrg.body);
    List<dynamic> co1 = decodedo['origins'];
    List<LatLng> coordsOrg = co1.map((pair) => LatLng(pair[0], pair[1])).toList();
    final source = c.LatLng(coordsOrg[org].latitude, coordsOrg[org].longitude);
    double sourcelat=source.lat;
    double sourcelng=source.lng;
    List<double> arr=[0.344441,1.331234];

    if (responseOrg.statusCode == 200) {
      String url=getplaceRequest(arr, 1,type,1);
      Future<String> myFuture=getjsonvalue(url);
      myFuture.then((response) {

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context)=>DrawPlace(drawplace(response,2))));

      });

      }

  }

  getPlaceInoutCoord(int depId,int floorId,int startid,int finishid,String vORf) async {
    var responseOrg = await http.post("http://10.0.2.2/origin.json");
    var responseDes = await http.post("http://10.0.2.2/dest.json");

    Map<String, dynamic> decodedo = json.decode(responseOrg.body);
    List<dynamic> co1 = decodedo['origins'];

    List<LatLng> coordsOrg = co1.map((pair) => LatLng(pair[0], pair[1])).toList();
    final source = c.LatLng(coordsOrg[startid].latitude, coordsOrg[startid].longitude);
    Map<String, dynamic> decodedd = json.decode(responseDes.body);
    List<dynamic> co2 = decodedd['destinations'];
    List<LatLng> coordsDes = co2.map((pair) => LatLng(pair[0], pair[1])).toList();
    final destination = c.LatLng(coordsDes[finishid].latitude, coordsDes[finishid].longitude);
    double sourcelat=source.lat;
    double sourcelng=source.lng;
    double destlat=destination.lat;
    double destlng=destination.lng;
    List<List<double>> arr=[[sourcelat,sourcelng],[destlat,destlng]];
    if (responseOrg.statusCode == 200 && responseDes.statusCode == 200) {
        String url=getplaceinOutRequest(depId,floorId,arr,1);
        Future<String> myFuture=getjsonvalue(url);
        myFuture.then((response) {

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context)=>DrawPlaceinout(drawplaceinout(response,2))));

        });
      }
    }


  getPlaceIninCoord(int depId,int floorId,int destinationid,int startid,String vORf) async {
    var responseOrg = await http.post("http://10.0.2.2/origin.json");


    Map<String, dynamic> decodedo = json.decode(responseOrg.body);
    List<dynamic> co1 = decodedo['origins'];

    List<LatLng> coordsOrg = co1.map((pair) => LatLng(pair[0], pair[1])).toList();
    final source = c.LatLng(coordsOrg[startid].latitude, coordsOrg[startid].longitude);

    double sourcelat=source.lat;
    double sourcelng=source.lng;

    List<double> arr=[0.258963,80.258963];
    if (responseOrg.statusCode == 200) {
      String url=getplaceInInRequest(depId, floorId,9, arr, 1);
      Future<String> myFuture=getjsonvalue(url);
      myFuture.then((response) {

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context)=>a.DrawPlaceInIn(drawplaceinin(response,destinationid,2,startid))));

      });
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
<<<<<<< HEAD
    if(itm == 0)
    {
      return SingleChildScrollView(
        child: _buildUserVehicleOutSide(),
      );
    }
    else
    {
      return AbsorbPointer(
        absorbing: true,
        child: SingleChildScrollView(
          child: _buildUserVehicleInSide(),
        ),
      );
    } 
  } 
=======
    return Container(
      child: _buildUserVehicle(),
    );
  }
>>>>>>> 1b368c0aa523b3360afeaec8200540b87927eb16
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
        controller: placeNameSelect,
        hintText: "Enter your location",
        enabled: true,
        items: placeName,
        onValueChanged: (value)
        {
<<<<<<< HEAD
           setState(() {
             placeNameselected = value;
           });
        },
      ),
    );  
  }

  Widget _buildUserLocationWalkInSide()
  {
    if(vlu == "Ground floor")
    {
      return _ground();
    }
    if(vlu == "First floor")
    {
      return _firstw();
    }
    else
    {
      return _secondw();
    }
  }
  Widget _ground()
  {
    return Padding(padding: EdgeInsets.zero,
      child: DropDownField(
            //itemsVisibleInDropdown: 2,
            controller: groundf,
            hintText: "Enter your location",
            enabled: true,
            items: ground,
            onValueChanged: (value)
            {
              setState(() {
              groundselected = value;
              });
            },
          ),
    );
  }
  Widget _firstw()
  {
    return Padding(padding: EdgeInsets.zero,
      child: DropDownField(
          controller: firstf,
          hintText: "Enter your location",
          enabled: true,
          items: first,
          onValueChanged: (value)
          {
            setState(() {
            firstselected = value;
          });
        },
      ),
    );
  }
  Widget _secondw()
  {
    return Padding(padding: EdgeInsets.zero,
      child: DropDownField(
        controller: secoundf,
        hintText: "Enter your location",
        enabled: true,
        items: secound,
          onValueChanged: (value)
        {
=======
>>>>>>> 1b368c0aa523b3360afeaec8200540b87927eb16
          setState(() {
            selected = value;
          });
        },
      ),
    );
  }
<<<<<<< HEAD
  /*Widget _thirdw()
=======

  Widget _buildUserLocationWalk()
>>>>>>> 1b368c0aa523b3360afeaec8200540b87927eb16
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
  }*/

  Widget _buildDestinationVehicle()
  {
    return Padding(padding: EdgeInsets.all(8),
      child: DropDownField(
        controller: placeNameSelect,
        hintText: "Choose destination",
        enabled: true,
        items: placeName,
        onValueChanged: (value)
        {
<<<<<<< HEAD
           setState(() {
             placeNameselected = value;
           });
=======
          setState(() {
            selecteda = value;
          });
>>>>>>> 1b368c0aa523b3360afeaec8200540b87927eb16
        },
      ),
    );
  }

  Widget _buildDestinationWalk()
  {
<<<<<<< HEAD
    if(vlu == "Ground floor")
    {
      return _ifground();
    }
    if(vlu == "First floor")
    {
      return _iffirstw();
    }
    else
    {
      return _ifsecondw();
    }
  }
  Widget _ifground()
  {
    return Padding(padding: EdgeInsets.zero,
=======
    return Padding(padding: EdgeInsets.all(8),
>>>>>>> 1b368c0aa523b3360afeaec8200540b87927eb16
      child: DropDownField(
            //itemsVisibleInDropdown: 2,
            controller: ifgroundf,
            hintText: "Enter your location",
            enabled: true,
            items: ifground,
            onValueChanged: (value)
            {
              setState(() {
              ifgroundselected = value;
              });
            },
          ),
    );
  }
  Widget _iffirstw()
  {
    return Padding(padding: EdgeInsets.zero,
      child: DropDownField(
          controller: iffirstf,
          hintText: "Enter your location",
          enabled: true,
          items: iffirst,
          onValueChanged: (value)
          {
            setState(() {
            iffirstselected = value;
          });
        },
      ),
    );
  }
  Widget _ifsecondw()
  {
    return Padding(padding: EdgeInsets.zero,
      child: DropDownField(
        controller: ifsecoundf,
        hintText: "Enter your location",
        enabled: true,
        items: ifsecound,
          onValueChanged: (value)
        {
          setState(() {
<<<<<<< HEAD
          ifsecoundselected = value;
=======
            selecteda = value;
>>>>>>> 1b368c0aa523b3360afeaec8200540b87927eb16
          });
        },
      ),
    );
  }
<<<<<<< HEAD
  Widget buildEnterButtonVehicleInSide()
=======

  Widget buildEnterButtonVehicle()
>>>>>>> 1b368c0aa523b3360afeaec8200540b87927eb16
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
            onPressed: () {
              String type="v";
              String org=listSelect.text;
              String des=listSelecta.text;
              int OrgId,DesId,floorId,deptId;
              bool _inside=false;
              if(itm==0) {
                for (int i = 0; i < list.length; i++) {
                  if (org == list[i]) {
                    OrgId = i;
                  }
                }
                for (int j = 0; j < outside.length; j++) {
                  if (des == outside[j]) {
                    DesId = j;
                    print(DesId);
                    _inside = true;
                  }

                }
                for (int j = 0; j < placeName.length; j++) {
                  if (des == placeName[j]) {
                    DesId = j;
                    print(DesId);
                    _inside = false;
                  }
                }
                if (_inside == true) {
                  getrouteCoord(OrgId, DesId, type);
                }
                else {
                  getplaceCoord(OrgId, DesId, type);
                }
              }

              if(itm==1) {

                for(int j=0;j<department.length;j++) {
                  if (departmentvalue == department[j])
                    deptId = j;
                }
                for(int k=0;k<floor.length;k++) {
                  if(floorvalue==floor[k])
                    floorId=k;

                }
                for (int i = 0; i < list.length; i++) {
                  if (org == list[i]) {
                    OrgId = i;

                  }
                }
                for (int j = 0; j < outside.length; j++) {
                  if (des == outside[j]) {
                    DesId = j;
                    _inside = false;
                  }
                }

                for (int j = 0; j < placeName.length; j++) {
                  if (des == placeName[j]) {
                    DesId = j;
                    _inside = true;
                  }
                }
                if(_inside==false) {
                  getPlaceInoutCoord(deptId, floorId, OrgId, DesId, type);
                }
                else {
                  getPlaceIninCoord(deptId, floorId, DesId, OrgId, type);
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
                fontSize: MediaQuery.of(context).size.height / 20,
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

<<<<<<< HEAD
              ],
            ),
          ),
          ),
        ),
      ],
    );
  }

  Widget _buildUserLocationVehicleOutSide()
  {
    return Padding(padding: EdgeInsets.zero,  
      child: DropDownField(
        controller: walkoutDestiLocselect,
        hintText: "Enter your location",
        enabled: true,
        items: walkoutDestiLoc,
        onValueChanged: (value)
        {
           setState(() {
             walkoutDestiLocselected = value;
           });
        },
      ),
    );  
  }
  Widget _buildUserLocationWalkOutSide()
  {
    return Padding(padding: EdgeInsets.zero,  
      child: DropDownField(
        controller: walkoutUserLocselect,
        hintText: "Enter your location",
        enabled: true,
        items: walkoutUserLoc,
        onValueChanged: (value)
        {
           setState(() {
             walkoutUserLocselected = value;
           });
        },
      ),
    );  
  }
  Widget _buildDestinationVehicleOutSide()
  {
    return Padding(padding: EdgeInsets.zero,
      child: DropDownField(
        controller: vehicleoutDestiLocselect,
        hintText: "Choose destination",
        enabled: true,
        items: vehicleoutDestiLoc,
        onValueChanged: (value)
        {
           setState(() {
             vehicleoutDestiLocselected = value;
           });
        },
      ),
    );
  }
  Widget _buildDestinationWalkOutSide()
  {
    return Padding(padding: EdgeInsets.zero,
      child: DropDownField(
        controller: walkoutDestiLocselect,
        hintText: "Choose destination",
        enabled: true,
        items: walkoutDestiLoc,
        onValueChanged: (value)
        {
           setState(() {
             walkoutDestiLocselected = value;
           });
        },
      ),
    );
  }
  Widget buildEnterButtonVehicleOutSide()
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: (MediaQuery.of(context).size.height / 10),
          width: 6 * (MediaQuery.of(context).size.width /10),
          margin: EdgeInsets.only(bottom: 10,top: 35),
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
                fontSize: MediaQuery.of(context).size.height / 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
  Widget buildEnterButtonWalkOutSide()
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: (MediaQuery.of(context).size.height / 10),
          width: 6 * (MediaQuery.of(context).size.width /10),
          margin: EdgeInsets.only(bottom: 10,top: 35),
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
                fontSize: MediaQuery.of(context).size.height / 20,
=======
                ],
>>>>>>> 1b368c0aa523b3360afeaec8200540b87927eb16
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

List<String> lista = ["Library" ,"E-Learning","Computer Lab 01","Main Gate","Library","Art Canteen"];
List<String> inside = ["Auditorium" ,"E-Learning","Computer Lab 01"];
List<String> outside = ["Main Gate","Library","Art Canteen"];
final listSelecta = TextEditingController();

String selecteda = "";