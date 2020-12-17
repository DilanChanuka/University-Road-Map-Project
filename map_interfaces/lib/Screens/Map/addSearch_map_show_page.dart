import 'package:map_interfaces/Screens/AddSearch/add_search_page.dart';
import 'package:map_interfaces/Screens/Map/AddFloor/First.dart';
import 'package:map_interfaces/Screens/Map/AddFloor/Ground.dart';
import 'package:map_interfaces/Screens/Map/AddFloor/Second.dart';
import 'package:map_interfaces/page_tran.dart';
import 'package:flutter/material.dart';
import 'package:map_interfaces/constanents.dart';

class AddSearch extends StatefulWidget
{
  AddSearch() : super();
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
              fontSize: MediaQuery.of(context).size.width / 20,
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
          leading: IconButton(icon: Icon(
              Icons.arrow_back,
              size: MediaQuery.of(context).size.width / 15,
              color: mainColor,
            ),
             onPressed: () =>
               _handleBack(context),
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
        ),
      ),
    );
  }

  Future<void> _handleBack(BuildContext context) async{
    try{
      Dialogs.showLoadingDialog(context,_keyLoader);
      await Future.delayed(Duration(seconds: 2,));
      Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();

      Navigator.push(context,MaterialPageRoute(builder: (context) => AddSPage()));
    }
    catch(error){
      print(error);
    }
  }
}