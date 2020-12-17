import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:uor_road_map/constanents.dart';
import 'package:uor_road_map/Screens/Common/data.dart';

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
  String location,destination;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            backgroundColor: firstColor,
            title: Text("University of Ruhuna"),
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
    );
  }
 
  Widget _buildDestination()
  {
    return Padding(padding: EdgeInsets.zero,
      child: DropDownField(
        itemsVisibleInDropdown: 7,
        controller: walkoutDestiLocselect,
        hintText: "Choose destination",
        enabled: true,
        items: walkoutDestiLoc,
        onValueChanged: (value)
        {
           setState(() {
             walkoutDestiLocselected = value == null ? "required" : null;
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
      //mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.64,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              padding: EdgeInsets.only(top: 30.0),
              child: Column(
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _buildDestination(),
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
            height: MediaQuery.of(context).size.height * 0.22 ,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              padding: EdgeInsets.only(top: 30.0),
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
      ],
    );
  }

}
