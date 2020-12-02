import 'package:map_interfaces/Screens/Map/search_map_show_page.dart';
import 'package:map_interfaces/Screens/Welcome/welcome_page.dart';
import 'package:map_interfaces/page_tran.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:map_interfaces/constanents.dart';
import 'package:map_interfaces/Screens/Common/data.dart';

class AddSSPage extends StatelessWidget
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
            title: Text("Outside University",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width / 20,
              ),
            ),
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
                  title: Text("Sign Out",style: TextStyle(fontSize: MediaQuery.of(context).size.width / 20),),
                  leading: Icon(Icons.exit_to_app,color: blackcolor,), 
                  onTap: () =>
                    _handleSubmitwelcome(context),
                  
                ),

                ListTile(
                  title: Text("Profile",style: TextStyle(fontSize: MediaQuery.of(context).size.width / 20),),
                  leading: Icon(Icons.person,color: blackcolor,),
                  onTap: (){},
                ),

                ListTile(
                  title: Text("Contacts",style: TextStyle(fontSize: MediaQuery.of(context).size.width / 20),),
                  leading: Icon(Icons.contacts,color: blackcolor,),
                  onTap: (){},
                ),

                ListTile(
                  title: Text("Settings",style: TextStyle(fontSize: MediaQuery.of(context).size.width / 20),),
                  leading: Icon(Icons.settings,color: blackcolor,),
                  onTap: (){},
                ),

                ListTile(
                  title: Text("Help and feedback",style: TextStyle(fontSize: MediaQuery.of(context).size.width / 20),),
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
    return SingleChildScrollView(        
      child: Container(
        height: 70.0,
        width: MediaQuery.of(context).size.width / 1.5,
        decoration: BoxDecoration(
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
          child: SingleChildScrollView(
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
                                        hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.width / 28),
                                        enabled: true,
                                        items: placeName,
                                        onValueChanged: (value)
                                        {  
                                        setState(() {
                                        placeNameselected = value;
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
                          onPressed: (){Navigator.of(context).pop(placeNameselected);},
                          child: Text("OK"),
                        ),
                      ],       
                    );
                  }
                );
              }
            );
          },
        controller: TextEditingController(text: placeNameselected),
      ),
    ),
    ),
    );
  }
  Widget buildEnterButton()
  {
    return SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.height / 30)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.6),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            height: (MediaQuery.of(context).size.height / 12),
            width: 5 * (MediaQuery.of(context).size.width /10),
            child: RaisedButton(
              elevation: 5.0,
              color: firstColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height / 30),
              ),
              onPressed: () => {
                _handleSubmitsearch(context),
              },
              child: SingleChildScrollView(
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
          ),
    );
  }
  Widget _buildUser()
  {
    return SingleChildScrollView(
        child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    SizedBox(height: MediaQuery.of(context).size.height / 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.height / 30)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.6),
                                spreadRadius: 2,
                                blurRadius: 3,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: SingleChildScrollView(
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(
                              Radius.circular(MediaQuery.of(context).size.height / 30),
                            ),
                            child: Container(
                            height: MediaQuery.of(context).size.height * 0.56,
                            width: MediaQuery.of(context).size.width * 0.96,
                            decoration: BoxDecoration(
                              color: mainColor,
                            ),
                              child: Container(
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
                        ),
                      ],
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height / 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.height / 30)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.6),
                                spreadRadius: 2,
                                blurRadius: 3,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: SingleChildScrollView(
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(MediaQuery.of(context).size.height / 30),
                              ),
                              child: Container(
                                height: MediaQuery.of(context).size.height * 0.22 ,
                                width: MediaQuery.of(context).size.width * 0.96,
                                decoration: BoxDecoration(
                                  color: mainColor,
                                ),
                                  child: Container(
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
                        ),
                      ],
                    ),

                ],
              ),
        ),
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
