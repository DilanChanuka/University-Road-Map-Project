import 'package:map_interfaces/Screens/Map/search_map_show_page.dart';
import 'package:map_interfaces/Screens/Welcome/welcome_page.dart';
import 'package:map_interfaces/page_tran.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:map_interfaces/constanents.dart';
import 'package:map_interfaces/Screens/Common/data.dart';
import 'package:map_interfaces/Screens/Disition/disistionFunc.dart';

class SearchPage extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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

  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  String location,destination;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            backgroundColor: firstColor,
            title: Text("Not on University"),
          ),
          body: SingleChildScrollView(
             child: _buildUser(),
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
    );
  }
 
  Widget _buildDestination()
  {
    return Container(
      margin: const EdgeInsets.all(40.0),
      padding: const EdgeInsets.all(10.0),
      height: 70.0,
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
                                  controller: placeNameSelect,
                                  hintText: "Choose destination",
                                  hintStyle: TextStyle(fontSize: 12.8),
                                  enabled: true,
                                  items: placeName,
                                  onValueChanged: (value)
                                  {  
                                    setState(() {
                                      dselectedDestination = value;
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
                          onPressed: (){Navigator.of(context).pop(dselectedDestination);},
                          child: Text("OK"),
                        ),
                      ],       
                    );
                  }
                );
              }
            );
          },
        controller: TextEditingController(text: dselectedDestination),
      ),
    );
  }
  Widget buildEnterButton()
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: (MediaQuery.of(context).size.height / 12),
          width: 5 * (MediaQuery.of(context).size.width /10),
          margin: EdgeInsets.only(bottom: 20),
          child: RaisedButton(
            elevation: 5.0,
            color: firstColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            onPressed: () => {
              //_handleSubmitsearch(context),
              serachPlace(context,dselectedDestination)
            },
            child: Text(
              "Enter",
              style: TextStyle(
                color: mainColor,
                letterSpacing: 1.5,
                fontSize: MediaQuery.of(context).size.height / 30,
              ),
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildUser()
  {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[

        ClipRRect(
          borderRadius: BorderRadius.zero,
          child: Container(
            height:MediaQuery.of(context).size.height * 0.87,
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
                      height: MediaQuery.of(context).size.height * 0.56,
                      width: MediaQuery.of(context).size.width * 0.96,
                      decoration: BoxDecoration(
                        color: mainColor,
                      ),
                        child: SingleChildScrollView(
                          padding: EdgeInsets.only(top: 90.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              _buildDestination(),
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
                        height: MediaQuery.of(context).size.height * 0.22 ,
                        width: MediaQuery.of(context).size.width * 0.96,
                        decoration: BoxDecoration(
                          color: mainColor,
                        ),
                          child: SingleChildScrollView(
                            padding: EdgeInsets.only(top: 40.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                buildEnterButton(),
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

  Future<void> _handleSubmitsearch(BuildContext context) async{
    try{
      Dialogs.showLoadingDialog(context,_keyLoader);
      await Future.delayed(Duration(seconds: 3,));
      Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();

      Navigator.push(context,MaterialPageRoute(builder: (context) => Search()));
    }
    catch(error){
      print(error);
    }
  }
}



String dselectedStart="";
String dselectedDestination = "";
String dvOr="";
String dselectedFloorName= "Ground floor";
String dselectedDepartment="";

List<String> arr=[dselectedStart,dselectedDestination,dselectedDepartment,dselectedFloorName,dvOr];
