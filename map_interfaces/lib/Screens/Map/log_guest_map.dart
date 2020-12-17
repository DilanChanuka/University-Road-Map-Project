import 'package:map_interfaces/Screens/Map/places.dart';
import 'package:map_interfaces/Screens/Welcome/welcome_page.dart';
import 'package:map_interfaces/page_tran.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_interfaces/constanents.dart';

class LogGuest extends StatefulWidget
{
  LogGuest() : super();

  final String txt= "Guest Access";
  @override
  LogGuestState createState() => LogGuestState();

}
class LogGuestState extends State<LogGuest>
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
             onPressed: () {_handleWelcomePage(context);},
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

  Future<void> _handleWelcomePage(BuildContext context) async{
    try{
      Dialogs.showLoadingDialog(context,_keyLoader);
      await Future.delayed(Duration(seconds: 2,));
      Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();

      Navigator.push(context,MaterialPageRoute(builder: (context) => WelcomePage()));
    }
    catch(error){
      print(error);
    }
  }
}