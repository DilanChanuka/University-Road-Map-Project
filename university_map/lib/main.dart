import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart' as a;
import 'package:map_view/polygon.dart';
import 'package:map_view/figure_joint_type.dart';
import 'package:map_view/polyline.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as b;
import 'package:google_map_polyline/google_map_polyline.dart';
import 'package:permission/permission.dart';
import 'package:geolocator/geolocator.dart';

var myKey="AIzaSyD27-xwm_C9mv9V2mb2hki_XfzKTD5TYRg";

void main() {
  a.MapView.setApiKey(myKey);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // get current location
  b.LatLng _center ;
  Position currentLocation;

  final Set<b.Polyline> polyline ={};
  b.GoogleMapController _controller;
  List<b.LatLng> routeCoords;
  GoogleMapPolyline googleMapPolyline = new  GoogleMapPolyline(apiKey: myKey);

  getsomepoints() async{
    var permissions=await Permission.getPermissionsStatus([PermissionName.Location]);
    if(permissions[0].permissionStatus == PermissionStatus.notAgain) {
      var askpermissions=await Permission.requestPermissions([PermissionName.Location]);
    }else {
      routeCoords = await googleMapPolyline.getCoordinatesWithLocation(
          origin:  getUserLocation(), //b.LatLng(40.6782, -73.9442),
          destination: b.LatLng(40.6944, -73.9212), //shortest path algorithm,
          mode: RouteMode.driving);
    }
  }
  void initState() {
    super.initState();
    getsomepoints();
    getUserLocation();
  }
//get current location
  Future<Position> locateUser() async {
    return Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  getUserLocation() async {
    currentLocation = await locateUser();
    setState(() {
      _center = b.LatLng(currentLocation.latitude, currentLocation.longitude);
    });
    
  }
 // a.MapView mapView= new a.MapView();
 // List<a.Marker> markers=<a.Marker> [
 //       new a.Marker("1","Main Gate", 30.2672, -97.7431,color: Colors.green,draggable: true)
 // ];

  List<Polygon> polygons=<Polygon> [
      new Polygon("CS dept",
          <a.Location>[
            new a.Location(35.22,-101.83),
            new a.Location(32.77,-96.79),
            new a.Location(29.76,-95.36),
            new a.Location(29.42,-98.49),

          ],
        jointType: FigureJointType.round,
        strokeColor: Colors.blue,
        strokeWidth: 10.0,
        fillColor: Colors.blue.withOpacity(0.1)

      )
  ];



 // displayMap() {
    //mapView.show(new a.MapOptions(
     // mapViewType: a.MapViewType.normal,
     // initialCameraPosition: new a.CameraPosition(new a.Location(35.22, -101.83), 15.0),
     // showUserLocation: true,
     // title: 'University Map'
   // ));
   // mapView.onMapTapped.listen((tapped) {
    //  mapView.setMarkers(markers);
    ////  mapView.setPolygons(polygons);
      //mapView.zoomToFit(padding: 100);

      
  //  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: b.GoogleMap(
      onMapCreated: onMapCreated,
        polylines: polyline,
        initialCameraPosition: b.CameraPosition(target: b.LatLng(40.6782, -73.9442),
          zoom: 14.0
        ),
        mapType: b.MapType.normal,
      )
      //appBar: AppBar(

        //title: Text("University maps"),
     // ),
      //body: new Center(
        //child: Container(
          //child: RaisedButton(
            //child: Text("Search Location"),
           // color: Colors.blue,
            //textColor: Colors.white,
           // elevation: 7.0,
           // onPressed: displayMap,
        //  ),
       // ),
    //  ),

      ); // This trailing comma makes auto-formatting nicer for build methods.

  }
  void onMapCreated(b.GoogleMapController controller) {
      setState(() {
        _controller=controller;
        polyline.add(b.Polyline(polylineId: b.PolylineId('Route1'),
        visible: true,
          points: routeCoords,
        width: 4,
          color: Colors.blue,
          startCap: b.Cap.roundCap,
          endCap: b.Cap.buttCap
        ));
      });
  }
}



