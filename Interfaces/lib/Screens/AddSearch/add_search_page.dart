import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:uor_road_map/constanents.dart';
import 'package:uor_road_map/Screens/Common/data.dart';

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
String vlu = "";
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
                height:MediaQuery.of(context).size.height * 0.076,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.lightGreen,
                ),
                child:SingleChildScrollView(
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
                          //onTap: (){return floorvalue;},
                        );
                      }).toList(),
                      onChanged: (String fl){setState((){floorvalue = fl;});},
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
                  Navigator.of(context).pop(vlu = floorvalue);
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

  String location,destination;
  bool con = true;
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
            title: Text("Find out"),
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

  Widget _buildUserLocationVehicleInSide()
  {
    return Padding(padding: EdgeInsets.zero,  
      child: DropDownField(
        controller: placeNameSelect,
        hintText: "Enter your location",
        enabled: true,
        items: placeName,
        onValueChanged: (value)
        {
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
          setState(() {
          secoundselected = value;
          });
        },
      ),
    );
  }
  /*Widget _thirdw()
  {
    return Padding(padding: EdgeInsets.zero,
      child: DropDownField(
        //itemsVisibleInDropdown: 2,
        controller: thirdf,
        hintText: "Enter your location",
        enabled: true,
        items: third,
          onValueChanged: (value)
        {
          setState(() {
          thirdselected = value;
          });
        },
      ),
    );
  }*/

  Widget _buildDestinationVehicleInSide()
  {
    return Padding(padding: EdgeInsets.zero,
      child: DropDownField(
        controller: placeNameSelect,
        hintText: "Choose destination",
        enabled: true,
        items: placeName,
        onValueChanged: (value)
        {
           setState(() {
             placeNameselected = value;
           });
        },
      ),
    );
  }

  Widget _buildDestinationWalkInSide()
  {
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
          ifsecoundselected = value;
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

  Widget buildEnterButtonWalkInSide()
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

                SizedBox(height: 15.0,),
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
                              _buildUserLocationVehicleInSide(),
                            ],
                        ),
                      ),
                  ),
                ),

                SizedBox(height: 15.0,),
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
                            _buildDestinationVehicleInSide(),
                          ],
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 15.0,),
                ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.2,
                    width: MediaQuery.of(context).size.width,
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
              
                SizedBox(height: 15.0,),
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
                              _buildUserLocationWalkInSide(),
                            ],
                        ),
                      ),
                  ),
                ),

                SizedBox(height: 15.0,),
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
                            _buildDestinationWalkInSide(),
                          ],
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 15.0,),
                ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.2,
                    width: MediaQuery.of(context).size.width,
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

                SizedBox(height: 15.0,),
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
                              _buildUserLocationVehicleOutSide(),
                            ],
                        ),
                      ),
                  ),
                ),

                SizedBox(height: 15.0,),
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
                            _buildDestinationVehicleOutSide(),
                          ],
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 15.0,),
                ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.2,
                    width: MediaQuery.of(context).size.width,
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
              
                SizedBox(height: 15.0,),
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
                              _buildUserLocationWalkOutSide(),
                            ],
                        ),
                      ),
                  ),
                ),

                SizedBox(height: 15.0,),
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
                            _buildDestinationWalkOutSide(),
                          ],
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 15.0,),
                ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.2,
                    width: MediaQuery.of(context).size.width,
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
}
