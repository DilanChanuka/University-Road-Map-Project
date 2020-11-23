import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:MapInterfaces/constanents.dart';
import 'package:MapInterfaces/Screens/Common/data.dart';

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
  String vlu = '';
  Future<String> createAlertDialog(BuildContext context) async {
    return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: Text("Select Department and Floor",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
            content: Form(

              child: SingleChildScrollView(
                child: Column(
                  //mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text("Select Department",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0
                        ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.076,
                      width: MediaQuery.of(context).size.width,
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
                                    child: Text(departmentvalue,
                                      style: TextStyle(
                                        fontSize: 15.0
                                      ),
                                    ),
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
                    SizedBox(height: 40.0,),
                    Text("Select Floor",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0
                        ),
                    ),
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
                                    child: Text(floorvlue,
                                      style: TextStyle(
                                        fontSize: 15.0
                                      ),
                                    ),
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
                  Navigator.of(context).pop(vlu = floorvalue);
                },
                child: Text("OK",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
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
            title: Text("Find Out"),
            actions: <Widget>[

              DropdownButton<int>(
                iconSize: 40.0,
                iconEnabledColor: mainColor,
                dropdownColor: mainColor,
                value: itm,
                items: [
                  DropdownMenuItem(
                    child: Text("Out Side",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25.0,
                        color: blackcolor,
                        fontWeight: FontWeight.bold
                        ),
                    ),
                    value: 0,
                  ),
                  DropdownMenuItem(
                      child: Text("In Side",
                        textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25.0,
                        color: blackcolor,
                        fontWeight: FontWeight.bold
                        ),
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
              
            ],
          
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
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                
                UserAccountsDrawerHeader(
                  accountName: Text("User Name"), 
                  accountEmail: Text("User Email"),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: mainColor,
                    child: Text("A"),
                  ),
                  decoration: BoxDecoration(
                    color: firstColor,
                  ),
                ),

                ListTile(
                  title: Text("Sign Out",style: TextStyle(fontSize: 18.0),),
                  leading: Icon(Icons.exit_to_app,color: blackcolor,), 
                  onTap: (){},
                ),

                ListTile(
                  title: Text("Profile",style: TextStyle(fontSize: 18.0),),
                  leading: Icon(Icons.person,color: blackcolor,),
                  onTap: (){},
                ),

                ListTile(
                  title: Text("Contacts",style: TextStyle(fontSize: 18.0),),
                  leading: Icon(Icons.contacts,color: blackcolor,),
                  onTap: (){},
                ),

                ListTile(
                  title: Text("Settings",style: TextStyle(fontSize: 18.0),),
                  leading: Icon(Icons.settings,color: blackcolor,),
                  onTap: (){},
                ),

                ListTile(
                  title: Text("Help and feedback",style: TextStyle(fontSize: 20.0),),
                  leading: Icon(Icons.help,color: blackcolor,),
                  onTap: (){},
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _tab1()
  {
    if(itm == 0)
    {
      return SingleChildScrollView(
        child: _buildUserVehicleOutSide(),
      );
    }
    else
    {
      return IgnorePointer(
        child: SingleChildScrollView(
          child: _buildUserVehicleInSide(),
        ),
      );
    } 
  } 
  Widget _tab2()
  {
    if(itm == 0)
    {
      return SingleChildScrollView(
        child: _buildUserWalkOutSide(),
      );
    }
    else
    {
      return SingleChildScrollView(
        child: _buildUserWalkInSide(),
      );
    }
  }

  Widget _buildUserLocationVehicleOutSide()
  {
    return Padding(padding: EdgeInsets.zero,  
      child: DropDownField(
        controller: vehicleoutUserLocselect,
        hintText: "Enter your location",
        enabled: true,
        items: vehicleoutUserLoc,
        onValueChanged: (value)
        {
           setState(() {
             vehicleoutUserLocselected = value == vehicleoutDestiLocselected || null ? "Invalid" : null;
           });
        },
      ),
    );  
  }
  Widget _buildUserLocationVehicleInSide()
  {
    return Padding(padding: EdgeInsets.zero,
      child: DropDownField(
        controller: vehicleinUserLocselect,
        hintText: "Enter your location",
        enabled: true,
        items: vehicleinUserLoc,
        onValueChanged: (value)
        {
           setState(() {
             vehicleinUserLocselected = value == vehicleinDestiLocselected || null ? "Invalid" : null;
           });
        },
      ),
    );  
  }

  Widget _buildUserLocationWalkInSide()
  {
    if(vlu == "Ground floor")
    {
      return _groundw();
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
  Widget _groundw()
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
                groundselected = value == ifgroundselected || null ? "Invalid" : null;
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
            firstselected = value == iffirstselected || null ? "Invalid" : null;
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
          setState(() {
            secoundselected = value == ifsecoundselected || null ? "Invalid" : null;
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
             walkoutUserLocselected = value == walkoutDestiLocselected || null ? "Invalid" : null;
           });
        },
      ),
    );  
  }
  Widget _buildDestinationVehicleInSide()
  {
    return Padding(padding: EdgeInsets.zero,
      child: DropDownField(
        controller: vehicleinDestiLocselect,
        hintText: "Choose destination",
        enabled: true,
        items: vehicleinDestiLoc,
        onValueChanged: (value)
        {
           setState(() {
             vehicleinDestiLocselected = value == vehicleinUserLocselected || null ? "Invalid" : null;
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
             vehicleoutDestiLocselected = value == vehicleoutUserLocselected || null ? "Invalid" : null;
           });
        },
      ),
    );
  }

  Widget _buildDestinationWalkInSide()
  {
    if(vlu == "Ground floor")
    {
      return _ifgroundw();
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
  Widget _ifgroundw()
  {
    return Padding(padding: EdgeInsets.zero,
      child: DropDownField(
            //itemsVisibleInDropdown: 2,
            controller: ifgroundf,
            hintText: "Enter your location",
            enabled: true,
            items: ifground,
            onValueChanged: (value)
            {
              setState(() {
              ifgroundselected = value == groundselected || null ? "Invalid" : null;
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
            iffirstselected = value == firstselected || null ? "Invalid" : null;
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
            ifsecoundselected = value == secoundselected || null ? "Invalid" : null;
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
             walkoutDestiLocselected = value == walkoutUserLocselected || null ? "Invalid" : null;
           });
        },
      ),
    );
  }
  
  Widget buildEnterButtonVehicleInSide()
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
            onPressed: () { },
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
  Widget buildEnterButtonVehicleOutSide()
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
            onPressed: () { },
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

  Widget buildEnterButtonWalkInSide()
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
            onPressed: () =>{},
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

  Widget _buildUserVehicleOutSide()
  {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[

        ClipRRect(
          borderRadius: BorderRadius.zero,
          child: Container(
            height:MediaQuery.of(context).size.height * 0.75,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              //padding: EdgeInsets.only(top: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  SizedBox(height: 20.0,),
                  ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.3,
                      width: MediaQuery.of(context).size.width*0.96,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.8),
                            spreadRadius: 10,
                            blurRadius: 10,
                            offset: Offset(0, 3),
                          ),
                        ],
                        color: mainColor,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            _buildUserLocationVehicleOutSide(),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20.0,),
                  ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.3,
                      width: MediaQuery.of(context).size.width* 0.96,
                      decoration: BoxDecoration(
                        color: mainColor,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            _buildDestinationVehicleOutSide(),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20.0,),
                  ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.3,
                      width: MediaQuery.of(context).size.width*0.96,
                      decoration: BoxDecoration(
                        color: mainColor,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            buildEnterButtonVehicleOutSide(),
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
  Widget _buildUserVehicleInSide()
  {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[

        ClipRRect(
          borderRadius: BorderRadius.zero,
          child: Container(
            height:MediaQuery.of(context).size.height * 0.75,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              //padding: EdgeInsets.only(top: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  SizedBox(height: 20.0,),
                  ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.3,
                      width: MediaQuery.of(context).size.width * 0.96,
                      decoration: BoxDecoration(
                        color: mainColor,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            _buildUserLocationVehicleInSide(),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20.0,),
                  ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.3,
                      width: MediaQuery.of(context).size.width *0.96,
                      decoration: BoxDecoration(
                        color: mainColor,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            _buildDestinationVehicleInSide(),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20.0,),
                  ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.3,
                      width: MediaQuery.of(context).size.width * 0.96,
                      decoration: BoxDecoration(
                        color: mainColor,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            buildEnterButtonVehicleInSide(),
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

  Widget _buildUserWalkOutSide()
  {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[

        ClipRRect(
          borderRadius: BorderRadius.zero,
          child: Container(
            height:MediaQuery.of(context).size.height * 0.75,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              //padding: EdgeInsets.only(top: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  SizedBox(height: 20.0,),
                  ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.3,
                      width: MediaQuery.of(context).size.width* 0.96,
                      decoration: BoxDecoration(
                        color: mainColor,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            _buildUserLocationWalkOutSide(),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20.0,),
                  ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.3,
                      width: MediaQuery.of(context).size.width *0.96,
                      decoration: BoxDecoration(
                        color: mainColor,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            _buildDestinationWalkOutSide(),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20.0,),
                  ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.3,
                      width: MediaQuery.of(context).size.width * 0.96,
                      decoration: BoxDecoration(
                        color: mainColor,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            buildEnterButtonWalkOutSide(),
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
  Widget _buildUserWalkInSide()
  {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[

        ClipRRect(
          borderRadius: BorderRadius.zero,
          child: Container(
            height:MediaQuery.of(context).size.height * 0.75,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              //padding: EdgeInsets.only(top: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  SizedBox(height: 20.0,),
                  ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.3,
                      width: MediaQuery.of(context).size.width * 0.96,
                      decoration: BoxDecoration(
                        color: mainColor,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            _buildUserLocationWalkInSide(),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20.0,),
                  ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.3,
                      width: MediaQuery.of(context).size.width *0.96,
                      decoration: BoxDecoration(
                        color: mainColor,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            _buildDestinationWalkInSide(),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20.0,),
                  ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.3,
                      width: MediaQuery.of(context).size.width * 0.96,
                      decoration: BoxDecoration(
                        color: mainColor,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            buildEnterButtonWalkInSide(),
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
