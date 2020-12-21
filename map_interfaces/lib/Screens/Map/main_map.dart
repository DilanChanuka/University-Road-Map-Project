import 'package:map_interfaces/Screens/AddSearch/add_search_page.dart';
import 'package:map_interfaces/Screens/HelpandFeedBack/HelpandFeedback.dart';
import 'package:map_interfaces/Screens/LocationShare/manage_friends_page.dart';
import 'package:map_interfaces/Screens/Map/places.dart';
import 'package:map_interfaces/Screens/Profile/PrifilePage.dart';
import 'package:map_interfaces/Screens/Search/search_page.dart';
import 'package:map_interfaces/Screens/Welcome/welcome_page.dart';
import 'package:map_interfaces/page_tran.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_interfaces/constanents.dart';

class MainMap extends StatefulWidget
{
  MainMap() : super();

  final String txt= "University Road Map";
  @override
  MainMapState createState() => MainMapState();

}
class MainMapState extends State<MainMap>
{
  GoogleMapController controller;
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  List<Marker> allMarker = [];

  @override
  void initState(){
    super.initState();
  
    canteenplaces.forEach((element) async {
      allMarker.add(Marker(
        markerId: MarkerId(element.canteenname),
        position: element.canteendeplocationCoords,
        infoWindow: InfoWindow(title: element.canteenname),
        icon:await BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(32.0,32.0)),'assets/images/3.png'),
      ));
    });
    medical.forEach((element) async { 
      allMarker.add(Marker(
        markerId:MarkerId(element.name),
        position: element.locationCoords,
        infoWindow: InfoWindow(title: element.name),
        icon:await BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(32.0,32.0)),'assets/images/2.png'),
      ));
    });
    insideplaces.forEach((element) async { 
      allMarker.add(Marker(
        markerId:MarkerId(element.insidename),
        position: element.insidedeplocationCoords,
        infoWindow: InfoWindow(title: element.insidename),
        icon:await BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(32.0,32.0)),'assets/images/4.png'),
      ));
    });
    readingplaces.forEach((element) async { 
      allMarker.add(Marker(
        markerId:MarkerId(element.readname),
        position: element.readdeplocationCoords,
        infoWindow: InfoWindow(title: element.readname),
        icon:await BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(32.0,32.0)),'assets/images/5.png'),
      ));
    });
    department.forEach((element) async { 
      allMarker.add(Marker(
        markerId:MarkerId(element.depname),
        position: element.deplocationCoords,
        infoWindow: InfoWindow(title: element.depname),
        icon:await BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(32.0,32.0)),'assets/images/6.png'),
      ));
    });
    uorplaces.forEach((element) async { 
      allMarker.add(Marker(
        markerId:MarkerId(element.name),
        position: element.locationCoords,
        infoWindow: InfoWindow(title: element.name),
        icon:await BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(32.0,32.0)),'assets/images/7.png'),
      ));
    });
  }

  
  void mapCreated(controller)
  {
    setState(() {
      controller = controller;
    });
  }
  
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
                  title: Text("Profile",style: TextStyle(fontSize: MediaQuery.of(context).size.width / 20,),),
                  leading: Icon(Icons.person,color: blackcolor,),
                  onTap: (){
                    _handleSetProfile(context);
                  },
                ),

                ListTile(
                  title: Text("Manage Friends",style: TextStyle(fontSize: MediaQuery.of(context).size.width / 20),),
                  leading: Icon(Icons.contacts,color: blackcolor,),
                  onTap: (){
                    _handleManageFriends(context);
                  },
                ),

                /*ListTile(
                  title: Text("Settings",style: TextStyle(fontSize: MediaQuery.of(context).size.width / 20),),
                  leading: Icon(Icons.settings,color: blackcolor,),
                  onTap: (){},
                ),*/

                ListTile(
                  title: Text("Help and feedback",style: TextStyle(fontSize: MediaQuery.of(context).size.width / 20),),
                  leading: Icon(Icons.help,color: blackcolor,),
                  onTap: (){
                    _hadlehelpandfeedback(context);
                  },
                ),

              ],
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
                  zoom: 19.0, 
                  ), 
                  markers: Set.from(allMarker),
                  onMapCreated: mapCreated,
                ),
            ),
              Padding(
                padding: EdgeInsets.all(MediaQuery.of(context).size.height / 60),
                child: SingleChildScrollView(
                  child: Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 35,
                        ),
                        addsearch(),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 35,
                          width: MediaQuery.of(context).size.width / 80,
                        ),
                        search(),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
  
  Widget addsearch()
  {
    return Column(
      children: <Widget>[
        SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.height / 35)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(0, 3),
                ),
              ],
              border: Border.all(color: colorborder),
            ),
            height: 1.4 * (MediaQuery.of(context).size.height / 20),
            width: 3 * (MediaQuery.of(context).size.width /9),
            margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 35),
            child: RaisedButton(
              elevation: 3.0,
              color: tridColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height / 35),
              ),
              onPressed: () => {
                _handleSubmitaddsearch(context),
              },
              child: SingleChildScrollView(
                child: Text( 
                  "Inside Campus",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 1.5,
                      fontSize: MediaQuery.of(context).size.width / 22,
                    ),
                  ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget search()
  {
    return Column(
      children: <Widget>[
        SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.height / 35)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(0, 3),
                ),
              ],
              border: Border.all(color: colorborder),
            ),
            height: 1.4 * (MediaQuery.of(context).size.height / 20),
            width: 3 * (MediaQuery.of(context).size.width /9),
            margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 35),
            child: RaisedButton(
              elevation: 5.0,
              color: tridColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height / 35),
              ),
              onPressed: () => {
                _handleSubmitsearch(context),
              },
              child: SingleChildScrollView(
                child: Text( 
                  "Outside Campus",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 1.5,
                      fontSize: MediaQuery.of(context).size.width / 22,
                    ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _handleSubmitsearch(BuildContext context) async{
    try{
      Dialogs.showLoadingDialog(context,_keyLoader);
      await Future.delayed(Duration(seconds: 3,));
      Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();

      Navigator.push(context,MaterialPageRoute(builder: (context) => AddSSPage()));
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

      Navigator.push(context,MaterialPageRoute(builder: (context) => AddSPage()));
    }
    catch(error){
      print(error);
    }
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

  Future<void> _handleManageFriends(BuildContext context) async{
    try{
      Dialogs.showLoadingDialog(context,_keyLoader);
      await Future.delayed(Duration(seconds: 3,));
      Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();

      Navigator.push(context,MaterialPageRoute(builder: (context) => Managefriends()));
    }
    catch(error){
      print(error);
    }
  }

  Future<void> _handleSetProfile(BuildContext context) async{
    try{
      Dialogs.showLoadingDialog(context,_keyLoader);
      await Future.delayed(Duration(seconds: 3,));
      Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();

      Navigator.push(context,MaterialPageRoute(builder: (context) => ProfilePage()));
    }
    catch(error){
      print(error);
    }
  }
  
  Future<void> _hadlehelpandfeedback(BuildContext context) async{
    try{
      Dialogs.showLoadingDialog(context,_keyLoader);
      await Future.delayed(Duration(seconds: 3,));
      Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();

      Navigator.push(context,MaterialPageRoute(builder: (context) => HelpandFeedBack()));
    }
    catch(error){
      print(error);
    }
  }
}