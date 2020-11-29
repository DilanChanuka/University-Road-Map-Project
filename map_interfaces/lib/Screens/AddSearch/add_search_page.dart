import 'package:map_interfaces/Screens/Map/addSearch_map_show_page.dart';
import 'package:map_interfaces/Screens/Welcome/welcome_page.dart';
import 'package:map_interfaces/page_tran.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:map_interfaces/constanents.dart';
import 'package:map_interfaces/Screens/Common/data.dart';

class AddSPage extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "On University",
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

  final GlobalKey<State> _keyLoader = GlobalKey<State>();
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
                color: firstColor,
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
                        color: grycolor,
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
                        color: grycolor,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            //Padding(padding: EdgeInsets.all(12.0)),
                            DropdownButton(
                                isExpanded: true,
                                // 
                                hint: Text("Select Floor"),
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
                    color: firstColor,
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
            title: Text("On University",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height / 30,
              ),
            ),
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
                        backgroundColor: grycolor,
                        fontSize: 20.0,
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
                        backgroundColor: grycolor ,
                        fontSize: 20.0,
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
                Tab(icon: Icon(Icons.directions_walk),
                  text: "Walk",
                ),
                Tab(icon: Icon(Icons.directions_car),
                  text: "Vehicle",
                ),
              ],
            ),
          ),
          body:
          TabBarView(
            children:[
              _tab2(),
              _tab1(),
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
                  onTap: () =>
                    _handleSubmitwelcome(context),
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
    return Container(
      margin: const EdgeInsets.all(30.0),
      padding: const EdgeInsets.all(10.0),
      height: 68.0,
      width: 260.0,
      decoration: BoxDecoration(
        //borderRadius: BorderRadius.all(Radius.circular(20.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.6),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
        color: colorwhite,
        border: Border.all(),
      ),
      child: TextFormField(
        readOnly: true,
        decoration: InputDecoration(
          labelText: 'Enter Your Location',
        ),
          onTap: (){
            return showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return StatefulBuilder(builder: (context, setState) {
                    return AlertDialog(
                      content: Form(
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              Container(  
                                child: DropDownField(
                                  controller: vehicleoutUserLocselect,
                                  hintText: "Your Location",
                                  hintStyle: TextStyle(fontSize: 12.8),
                                  enabled: true,
                                  items: vehicleoutUserLoc,
                                  onValueChanged: (value)
                                  {  
                                    setState(() {
                                      vehicleoutUserLocselected = value;
                                    });
                                  },
                                ), 
                              ),
                            ],  
                          ),   
                        ),      
                      ), 
                      actions: [
                        FlatButton(
                          onPressed: (){Navigator.of(context).pop(vehicleoutUserLocselected);},
                          child: Text("OK"),
                        ),
                      ],       
                    );
                  }
                );
              }
            );
          },
        controller: TextEditingController(text: vehicleoutUserLocselected),
      ),
    );
  }
  Widget _buildUserLocationVehicleInSide()
  {
    return Container(
      margin: const EdgeInsets.all(30.0),
      padding: const EdgeInsets.all(10.0),
      height: 68.0,
      width: 260.0,
      decoration: BoxDecoration(
        //borderRadius: BorderRadius.all(Radius.circular(20.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.6),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
        color: colorwhite,
        border: Border.all(),
      ),
      child: TextFormField(
        readOnly: true,
        decoration: InputDecoration(
          labelText: 'Enter Your Location',
        ),
          onTap: (){
            return showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return StatefulBuilder(builder: (context, setState) {
                    return AlertDialog(
                      content: Form(
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              Container(  
                                child: DropDownField(
                                  controller: vehicleinUserLocselect,
                                  hintText: "Your Location",
                                  hintStyle: TextStyle(fontSize: 12.8),
                                  enabled: true,
                                  items: vehicleinUserLoc,
                                  onValueChanged: (value)
                                  {  
                                    setState(() {
                                      vehicleinUserLocselected = value;
                                    });
                                  },
                                ), 
                              ),
                            ],  
                          ),   
                        ),      
                      ), 
                      actions: [
                        FlatButton(
                          onPressed: (){Navigator.of(context).pop(vehicleinUserLocselected);},
                          child: Text("OK"),
                        ),
                      ],       
                    );
                  }
                );
              }
            );
          },
        controller: TextEditingController(text: vehicleinUserLocselected),
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
    return Container(
      margin: const EdgeInsets.all(30.0),
      padding: const EdgeInsets.all(10.0),
      height: 68.0,
      width: 260.0,
      decoration: BoxDecoration(
        //borderRadius: BorderRadius.all(Radius.circular(20.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.6),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
        color: colorwhite,
        border: Border.all(),
      ),
      child: TextFormField(
        readOnly: true,
        decoration: InputDecoration(
          labelText: 'Enter Your Location',
        ),
          onTap: (){
            return showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return StatefulBuilder(builder: (context, setState) {
                    return AlertDialog(
                      content: Form(
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              Container(  
                                child: DropDownField(
                                  controller: groundf,
                                  hintText: "Your Location",
                                  hintStyle: TextStyle(fontSize: 12.8),
                                  enabled: true,
                                  items: ground,
                                  onValueChanged: (value)
                                  {  
                                    setState(() {
                                      groundselected = value;
                                    });
                                  },
                                ), 
                              ),
                            ],  
                          ),   
                        ),      
                      ), 
                      actions: [
                        FlatButton(
                          onPressed: (){Navigator.of(context).pop(groundselected);},
                          child: Text("OK"),
                        ),
                      ],       
                    );
                  }
                );
              }
            );
          },
        controller: TextEditingController(text: groundselected),
      ),
    );
  }
  Widget _firstw()
  {
    return Container(
      margin: const EdgeInsets.all(30.0),
      padding: const EdgeInsets.all(10.0),
      height: 68.0,
      width: 260.0,
      decoration: BoxDecoration(
        //borderRadius: BorderRadius.all(Radius.circular(20.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.6),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
        color: colorwhite,
        border: Border.all(),
      ),
      child: TextFormField(
        readOnly: true,
        decoration: InputDecoration(
          labelText: 'Enter Your Location',
        ),
          onTap: (){
            return showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return StatefulBuilder(builder: (context, setState) {
                    return AlertDialog(
                      content: Form(
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              Container(  
                                child: DropDownField(
                                  controller: firstf,
                                  hintText: "Your Location",
                                  hintStyle: TextStyle(fontSize: 12.8),
                                  enabled: true,
                                  items: first,
                                  onValueChanged: (value)
                                  {  
                                    setState(() {
                                      firstselected = value;
                                    });
                                  },
                                ), 
                              ),
                            ],  
                          ),   
                        ),      
                      ), 
                      actions: [
                        FlatButton(
                          onPressed: (){Navigator.of(context).pop(firstselected);},
                          child: Text("OK"),
                        ),
                      ],       
                    );
                  }
                );
              }
            );
          },
        controller: TextEditingController(text: firstselected),
      ),
    );
  }
  Widget _secondw()
  {
    return Container(
      margin: const EdgeInsets.all(30.0),
      padding: const EdgeInsets.all(10.0),
      height: 68.0,
      width: 260.0,
      decoration: BoxDecoration(
        //borderRadius: BorderRadius.all(Radius.circular(20.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.6),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
        color: colorwhite,
        border: Border.all(),
      ),
      child: TextFormField(
        readOnly: true,
        decoration: InputDecoration(
          labelText: 'Enter Your Location',
        ),
          onTap: (){
            return showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return StatefulBuilder(builder: (context, setState) {
                    return AlertDialog(
                      content: Form(
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              Container(  
                                child: DropDownField(
                                  controller: secoundf,
                                  hintText: "Your Location",
                                  hintStyle: TextStyle(fontSize: 12.8),
                                  enabled: true,
                                  items: secound,
                                  onValueChanged: (value)
                                  {  
                                    setState(() {
                                      secoundselected = value;
                                    });
                                  },
                                ), 
                              ),
                            ],  
                          ),   
                        ),      
                      ), 
                      actions: [
                        FlatButton(
                          onPressed: (){Navigator.of(context).pop(secoundselected);},
                          child: Text("OK"),
                        ),
                      ],       
                    );
                  }
                );
              }
            );
          },
        controller: TextEditingController(text: secoundselected),
      ),
    );
  }
  Widget _buildUserLocationWalkOutSide()
  {
    return Container(
      margin: const EdgeInsets.all(30.0),
      padding: const EdgeInsets.all(10.0),
      height: 68.0,
      width: 260.0,
      decoration: BoxDecoration(
        //borderRadius: BorderRadius.all(Radius.circular(20.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.6),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
        color: colorwhite,
        border: Border.all(),
      ),
      child: TextFormField(
        readOnly: true,
        decoration: InputDecoration(
          labelText: 'Enter Your Location',
        ),
          onTap: (){
            return showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return StatefulBuilder(builder: (context, setState) {
                    return AlertDialog(
                      content: Form(
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              Container(  
                                child: DropDownField(
                                  controller: walkoutUserLocselect,
                                  hintText: "Your Location",
                                  hintStyle: TextStyle(fontSize: 12.8),
                                  enabled: true,
                                  items: walkoutUserLoc,
                                  onValueChanged: (value)
                                  {  
                                    setState(() {
                                      walkoutUserLocselected = value;
                                    });
                                  },
                                ), 
                              ),
                            ],  
                          ),   
                        ),      
                      ), 
                      actions: [
                        FlatButton(
                          onPressed: (){Navigator.of(context).pop(walkoutUserLocselected);},
                          child: Text("OK"),
                        ),
                      ],       
                    );
                  }
                );
              }
            );
          },
        controller: TextEditingController(text: walkoutUserLocselected),
      ),
    );
  }
  Widget _buildDestinationVehicleInSide()
  {
    return Container(
      margin: const EdgeInsets.all(30.0),
      padding: const EdgeInsets.all(10.0),
      height: 68.0,
      width: 260.0,
      decoration: BoxDecoration(
        //borderRadius: BorderRadius.all(Radius.circular(20.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.6),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
        color: colorwhite,
        border: Border.all(),
      ),
      child: TextFormField(
        readOnly: true,
        decoration: InputDecoration(
          labelText: 'Enter Destination',
        ),
          onTap: (){
            return showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return StatefulBuilder(builder: (context, setState) {
                    return AlertDialog(
                      content: Form(
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              Container(  
                                child: DropDownField(
                                  controller: vehicleinDestiLocselect,
                                  hintText: "Choose destination",
                                  hintStyle: TextStyle(fontSize: 12.8),
                                  enabled: true,
                                  items: vehicleinDestiLoc,
                                  onValueChanged: (value)
                                  {  
                                    setState(() {
                                      vehicleinDestiLocselected = value;
                                    });
                                  },
                                ), 
                              ),
                            ],  
                          ),   
                        ),      
                      ), 
                      actions: [
                        FlatButton(
                          onPressed: (){Navigator.of(context).pop(vehicleinDestiLocselected);},
                          child: Text("OK"),
                        ),
                      ],       
                    );
                  }
                );
              }
            );
          },
        controller: TextEditingController(text: vehicleinDestiLocselected),
      ),
    );
  }
  
  Widget _buildDestinationVehicleOutSide()
  {
    return Container(
      margin: const EdgeInsets.all(30.0),
      padding: const EdgeInsets.all(10.0),
      height: 68.0,
      width: 260.0,
      decoration: BoxDecoration(
        //borderRadius: BorderRadius.all(Radius.circular(20.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.6),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
        color: colorwhite,
        border: Border.all(),
      ),
      child: TextFormField(
        readOnly: true,
        decoration: InputDecoration(
          labelText: 'Enter Destination',
        ),
          onTap: (){
            return showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return StatefulBuilder(builder: (context, setState) {
                    return AlertDialog(
                      content: Form(
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              Container(  
                                child: DropDownField(
                                  controller: vehicleoutDestiLocselect,
                                  hintText: "Choose destination",
                                  hintStyle: TextStyle(fontSize: 12.8),
                                  enabled: true,
                                  items: vehicleoutDestiLoc,
                                  onValueChanged: (value)
                                  {  
                                    setState(() {
                                      vehicleoutDestiLocselected = value;
                                    });
                                  },
                                ), 
                              ),
                            ],  
                          ),   
                        ),      
                      ), 
                      actions: [
                        FlatButton(
                          onPressed: (){Navigator.of(context).pop(vehicleoutDestiLocselected);},
                          child: Text("OK"),
                        ),
                      ],       
                    );
                  }
                );
              }
            );
          },
        controller: TextEditingController(text: vehicleoutDestiLocselected),
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
    return Container(
      margin: const EdgeInsets.all(30.0),
      padding: const EdgeInsets.all(10.0),
      height: 68.0,
      width: 260.0,
      decoration: BoxDecoration(
        //borderRadius: BorderRadius.all(Radius.circular(20.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.6),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
        color: colorwhite,
        border: Border.all(),
      ),
      child: TextFormField(
        readOnly: true,
        decoration: InputDecoration(
          labelText: 'Enter Destination',
        ),
          onTap: (){
            return showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return StatefulBuilder(builder: (context, setState) {
                    return AlertDialog(
                      content: Form(
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              Container(  
                                child: DropDownField(
                                  controller: ifgroundf,
                                  hintText: "Choose destination",
                                  hintStyle: TextStyle(fontSize: 12.8),
                                  enabled: true,
                                  items: ifground,
                                  onValueChanged: (value)
                                  {  
                                    setState(() {
                                      ifgroundselected = value;
                                    });
                                  },
                                ), 
                              ),
                            ],  
                          ),   
                        ),      
                      ), 
                      actions: [
                        FlatButton(
                          onPressed: (){Navigator.of(context).pop(ifgroundselected);},
                          child: Text("OK"),
                        ),
                      ],       
                    );
                  }
                );
              }
            );
          },
        controller: TextEditingController(text: ifgroundselected),
      ),
    );
  }
  Widget _iffirstw()
  {
    return Container(
      margin: const EdgeInsets.all(30.0),
      padding: const EdgeInsets.all(10.0),
      height: 68.0,
      width: 260.0,
      decoration: BoxDecoration(
        //borderRadius: BorderRadius.all(Radius.circular(20.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.6),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
        color: colorwhite,
        border: Border.all(),
      ),
      child: TextFormField(
        readOnly: true,
        decoration: InputDecoration(
          labelText: 'Enter Destination',
        ),
          onTap: (){
            return showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return StatefulBuilder(builder: (context, setState) {
                    return AlertDialog(
                      content: Form(
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              Container(  
                                child: DropDownField(
                                  controller: iffirstf,
                                  hintText: "Choose destination",
                                  hintStyle: TextStyle(fontSize: 12.8),
                                  enabled: true,
                                  items: iffirst,
                                  onValueChanged: (value)
                                  {  
                                    setState(() {
                                      iffirstselected = value;
                                    });
                                  },
                                ), 
                              ),
                            ],  
                          ),   
                        ),      
                      ), 
                      actions: [
                        FlatButton(
                          onPressed: (){Navigator.of(context).pop(iffirstselected);},
                          child: Text("OK"),
                        ),
                      ],       
                    );
                  }
                );
              }
            );
          },
        controller: TextEditingController(text: iffirstselected),
      ),
    );
  }
  Widget _ifsecondw()
  {
    return Container(
      margin: const EdgeInsets.all(30.0),
      padding: const EdgeInsets.all(10.0),
      height: 68.0,
      width: 260.0,
      decoration: BoxDecoration(
        //borderRadius: BorderRadius.all(Radius.circular(20.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.6),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
        color: colorwhite,
        border: Border.all(),
      ),
      child: TextFormField(
        readOnly: true,
        decoration: InputDecoration(
          labelText: 'Enter Destination',
        ),
          onTap: (){
            return showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return StatefulBuilder(builder: (context, setState) {
                    return AlertDialog(
                      content: Form(
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              Container(  
                                child: DropDownField(
                                  controller: ifsecoundf,
                                  hintText: "Choose destination",
                                  hintStyle: TextStyle(fontSize: 12.8),
                                  enabled: true,
                                  items: ifsecound,
                                  onValueChanged: (value)
                                  {  
                                    setState(() {
                                      ifsecoundselected = value;
                                    });
                                  },
                                ), 
                              ),
                            ],  
                          ),   
                        ),      
                      ), 
                      actions: [
                        FlatButton(
                          onPressed: (){Navigator.of(context).pop(ifsecoundselected);},
                          child: Text("OK"),
                        ),
                      ],       
                    );
                  }
                );
              }
            );
          },
        controller: TextEditingController(text: ifsecoundselected),
      ),
    );
  }
  Widget _buildDestinationWalkOutSide()
  {
    return Container(
      margin: const EdgeInsets.all(30.0),
      padding: const EdgeInsets.all(10.0),
      height: 68.0,
      width: 260.0,
      decoration: BoxDecoration(
        //borderRadius: BorderRadius.all(Radius.circular(20.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.6),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
        color: colorwhite,
        border: Border.all(),
      ),
      child: TextFormField(
        readOnly: true,
        decoration: InputDecoration(
          labelText: 'Enter Destination',
        ),
          onTap: (){
            return showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return StatefulBuilder(builder: (context, setState) {
                    return AlertDialog(
                      content: Form(
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              Container(  
                                child: DropDownField(
                                  controller: walkoutDestiLocselect,
                                  hintText: "Choose destination",
                                  hintStyle: TextStyle(fontSize: 12.8),
                                  enabled: true,
                                  items: walkoutDestiLoc,
                                  onValueChanged: (value)
                                  {  
                                    setState(() {
                                      walkoutDestiLocselected = value;
                                    });
                                  },
                                ), 
                              ),
                            ],  
                          ),   
                        ),      
                      ), 
                      actions: [
                        FlatButton(
                          onPressed: (){Navigator.of(context).pop(walkoutDestiLocselected);},
                          child: Text("OK"),
                        ),
                      ],       
                    );
                  }
                );
              }
            );
          },
        controller: TextEditingController(text: walkoutDestiLocselected),
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
          margin: EdgeInsets.only(bottom: 10,top: 40),
          child: RaisedButton(
            elevation: 5.0,
            color: firstColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            onPressed: () =>
              _handleSubmitaddsearch(context),
            child: Text(
              "Enter",
              style: TextStyle(
                color: mainColor,
                letterSpacing: 1.5,
                fontSize: MediaQuery.of(context).size.height / 25,
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
          margin: EdgeInsets.only(bottom: 10,top: 40),
          child: RaisedButton(
            elevation: 5.0,
            color: firstColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            onPressed: () => _handleSubmitaddsearch(context),
            child: Text(
              "Enter",
              style: TextStyle(
                color: mainColor,
                letterSpacing: 1.5,
                fontSize: MediaQuery.of(context).size.height / 25,
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
          margin: EdgeInsets.only(bottom: 10,top: 40),
          child: RaisedButton(
            elevation: 5.0,
            color: firstColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            onPressed: () => _handleSubmitaddsearch(context),
            child: Text(
              "Enter",
              style: TextStyle(
                color: mainColor,
                letterSpacing: 1.5,
                fontSize: MediaQuery.of(context).size.height / 25,
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
          margin: EdgeInsets.only(bottom: 10,top: 40),
          child: RaisedButton(
            elevation: 5.0,
            color: firstColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            onPressed: () => _handleSubmitaddsearch(context),
            child: Text(
              "Enter",
              style: TextStyle(
                color: mainColor,
                letterSpacing: 1.5,
                fontSize: MediaQuery.of(context).size.height / 25,
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
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.6),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child:ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      child: Container(
                        height: MediaQuery.of(context).size.height*0.2,//
                        width: MediaQuery.of(context).size.width*0.96,
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
                  ),

                  SizedBox(height: 20.0,),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.6),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      child: Container(
                        height: MediaQuery.of(context).size.height*0.2,//
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
                  ),

                  SizedBox(height: 20.0,),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.6),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      child: Container(
                        height: MediaQuery.of(context).size.height*0.23,//
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
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.6),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      child: Container(
                        height: MediaQuery.of(context).size.height*0.2,
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
                  ),

                  SizedBox(height: 20.0,),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.6),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      child: Container(
                        height: MediaQuery.of(context).size.height*0.2,
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
                  ),

                  SizedBox(height: 20.0,),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.6),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      child: Container(
                        height: MediaQuery.of(context).size.height*0.23,
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
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.6),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      child: Container(
                        height: MediaQuery.of(context).size.height*0.2,
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
                  ),

                  SizedBox(height: 20.0,),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.6),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      child: Container(
                        height: MediaQuery.of(context).size.height*0.2,
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
                  ),

                  SizedBox(height: 20.0,),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.6),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      child: Container(
                        height: MediaQuery.of(context).size.height*0.23,
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
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.6),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      child: Container(
                        height: MediaQuery.of(context).size.height*0.2,
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
                  ),

                  SizedBox(height: 20.0,),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.6),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      child: Container(
                        height: MediaQuery.of(context).size.height*0.2,
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
                  ),

                  SizedBox(height: 20.0,),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.6),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      child: Container(
                        height: MediaQuery.of(context).size.height*0.23,
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
                  ),

                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _handleSubmitwelcome(BuildContext context) async{
    try{
      Dialogs.showLoadingDialog(context,_keyLoader);
      await Future.delayed(Duration(seconds: 3,));
      Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();

      Navigator.push(context,MaterialPageRoute(builder: (context) => WelcomePage()));
    }
    catch(error){
      print(error);
    }
  }

  Future<void> _handleSubmitaddsearch(BuildContext context) async{
    try{
      Dialogs.showLoadingDialog(context,_keyLoader);
      await Future.delayed(Duration(seconds: 3,));
      Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();

      Navigator.push(context,MaterialPageRoute(builder: (context) => AddSearch()));
    }
    catch(error){
      print(error);
    }
  }
}
