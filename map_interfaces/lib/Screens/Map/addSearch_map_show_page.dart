import 'package:map_interfaces/Screens/Map/AddFloor/First.dart';
import 'package:map_interfaces/Screens/Map/AddFloor/Ground.dart';
import 'package:map_interfaces/Screens/Map/AddFloor/Second.dart';
import 'package:map_interfaces/Screens/Welcome/welcome_page.dart';
import 'package:map_interfaces/page_tran.dart';
import 'package:flutter/material.dart';
import 'package:map_interfaces/constanents.dart';

class AddSearch extends StatefulWidget
{
  AddSearch() : super();

  final String txt= "UOR";
  @override
  AddSearchState createState() => AddSearchState();

}
class AddSearchState extends State<AddSearch>
{
 final GlobalKey<State> _keyLoader = GlobalKey<State>();
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
          title: Text("Find Out",
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width / 15,
            ),
          ),
          bottom: TabBar(
            indicator: ShapeDecoration(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(MediaQuery.of(context).size.width / 15),
                      topRight: Radius.circular(MediaQuery.of(context).size.width / 15),
                      bottomLeft: Radius.circular(MediaQuery.of(context).size.width / 15),
                      bottomRight: Radius.circular(MediaQuery.of(context).size.width / 15),
                    ),
                ),
              color: mainColor,
              ),
            tabs: [
              Tab(
                child: SingleChildScrollView(
                  child: Text("Ground \nFloor",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width / 20,
                      color: blackcolor,
                    ),
                  ),
                ),

              ),
              Tab(
                child: SingleChildScrollView(
                  child: Text("First \nFloor",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width / 20,
                      color: blackcolor,
                    ),
                  ),
                ),
              ),
              Tab(
                child: SingleChildScrollView(
                  child: Text("Second \nFloor",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width / 20,
                      color: blackcolor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ), 
        body: TabBarView(
            children: <Widget>[
              SingleChildScrollView(
                child: Container(
                  child: Ground(),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  child: First(),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  child: Second(),
                ),
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
                  title: Text("Sign Out",style: TextStyle(fontSize: MediaQuery.of(context).size.width / 20),),
                  leading: Icon(Icons.exit_to_app,color: blackcolor,), 
                  onTap: () => _handleSubmitwelcome(context),
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
}