import 'package:map_interfaces/Screens/Search/search_page.dart';
import 'package:map_interfaces/page_tran.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:map_interfaces/constanents.dart';

class Search extends StatefulWidget
{
  Search() : super();

  final String txt= "Find Out";
  @override
  SearchState createState() => SearchState();

}
class SearchState extends State<Search>
{
  GoogleMapController controller;
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  int floor = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(widget.txt,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width / 20,
            color: Colors.white,
          ),
          ),
          backgroundColor: firstColor,
          leading: IconButton(icon: Icon(
              Icons.arrow_back,
              size: MediaQuery.of(context).size.width / 15,
              color: mainColor,
            ),
             onPressed: () =>
               _handleBack(context),
          ),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height - 50.0,
              width: MediaQuery.of(context).size.width,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(5.9382181, 80.576216),
                  zoom: 17.0, 
                  ), 
                  onMapCreated: mapCreated,
                ),
            ),
            Container(
              padding: EdgeInsets.all(MediaQuery.of(context).size.height / 80),
             child: buildDistanceUpButton(),
            ),
          ],
        ),
      ),
    );
  }

  void mapCreated(controller)
  {
    setState(() {
      controller = controller;
    });
  }

  Widget buildDistanceUpButton()
  {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.height / 35)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.6),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            height: 1.4 * (MediaQuery.of(context).size.height / 20),
            width: 4 * (MediaQuery.of(context).size.width /10),
            margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 35),
            child: RaisedButton(
              elevation: 5.0,
              color: firstColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height / 30),
              ),
              onPressed: () => {},
              child: SingleChildScrollView(
                child: Text(
                  "Distance",
                    style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 1.5, 
                      fontSize: MediaQuery.of(context).size.width / 20,
                    ),
                  ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _handleBack(BuildContext context) async{
    try{
      Dialogs.showLoadingDialog(context,_keyLoader);
      await Future.delayed(Duration(seconds: 2,));
      Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();

      Navigator.push(context,MaterialPageRoute(builder: (context) => AddSSPage()));
    }
    catch(error){
      print(error);
    }
  }
}