import 'package:MapInterfaces/Screens/Map/Floor/First.dart';
import 'package:MapInterfaces/Screens/Map/Floor/Ground.dart';
import 'package:MapInterfaces/Screens/Map/Floor/Second.dart';
import 'package:flutter/material.dart';
import 'package:MapInterfaces/constanents.dart';

class AddSearch extends StatefulWidget
{
  AddSearch() : super();

  final String txt= "UOR";
  @override
  AddSearchState createState() => AddSearchState();

}
class AddSearchState extends State<AddSearch>
{
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          resizeToAvoidBottomPadding: false,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
          backgroundColor: firstColor,
          title: Text("Find Out"),
          bottom: TabBar(
            indicator: ShapeDecoration(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                ),
              color: tridColor,
              ),
            tabs: [
              Tab(
                child: Text("Ground \nFloor",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: blackcolor,
                  ),
                ),
              ),
              Tab(
                child: Text("First \nFloor",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: blackcolor,
                  ),
                ),
              ),
              Tab(
                child: Text("Secound \nFloor",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: blackcolor,
                  ),
                ),
              ),
            ],
          ),
        ), 
        body: TabBarView(
            children: <Widget>[
              new Container(
                child: Ground(),
              ),
              new Container(
                child: First(),
              ),
              new Container(
                child: Second(),
              ),
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
}