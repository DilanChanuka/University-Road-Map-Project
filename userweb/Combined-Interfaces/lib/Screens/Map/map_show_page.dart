import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uor_road_map/Screens/Search/search_page.dart';
import 'package:uor_road_map/Screens/Direction/directionPage.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:uor_road_map/constanents.dart';
import 'package:dropdownfield/dropdownfield.dart';

class MapDemo extends StatefulWidget
{
  void setPermissions() async{
    Map<PermissionGroup, PermissionStatus> permissions = await PermissionHandler().requestPermissions([PermissionGroup.location]);
  }
  MapDemo() : super();


  @override
  MapsDemoState createState() => MapsDemoState();

}

class MapsDemoState extends State<MapDemo> {
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: new HomeScreen(),
    routes: <String, WidgetBuilder>{
      '/main': (BuildContext context) => new AddSSPage()
    },


    );
  }
}
  class HomeScreen extends StatefulWidget {
    HomeScreenState createState() => HomeScreenState();
  }
class HomeScreenState extends State<HomeScreen> 
{
  final Geolocator geolocator = Geolocator();


  Widget build(BuildContext context) {

    final String txt = "UOR MAP";
    final Map<String, Marker> _markers1 = {};
    Completer<GoogleMapController> _controller = Completer();
    const LatLng _center = const LatLng(
        37.42796133580664, -122.085749655962);
    final Set<Marker> _markers = {};
    LatLng _lastMapPosition = _center;
    MapType _currentMapType = MapType.normal;

    final CameraPosition _position = CameraPosition(
      bearing: 192.833,
      target: LatLng(37.43796133580664, -122.085749655962),
      tilt: 59.440,
      zoom: 11.0,
    );

    Future<void> _goToPosition() async {
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(_position),);
    }

    _onMapCreated(GoogleMapController controller) {
      _controller.complete(controller);
    }

    _onCamMove(CameraPosition position) {
      _lastMapPosition = position.target;
    }

    _onMapTypeButtonPressed() {
      //setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    }

    _onSearchRoute() async {
      //Navigator.of(context).pushNamed('/main');
      Navigator.push(context,MaterialPageRoute(builder: (context)=>AddSSPage()));  //go to Search page
    }

    _onDirectionRoute() async {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AddDirection()));  //go to Direction page
    }

    _onAddMarkerButtonPressed() {
      //  setState(() {
      _markers.add(Marker(
        markerId: MarkerId(_lastMapPosition.toString()),
        position: _lastMapPosition,
        infoWindow: InfoWindow(
          title: "Title",
          snippet: "snippet",
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
      //});
    }
     _getLocation() async {
      var currentLocation = await Geolocator
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);

      setState(() {
        _markers1.clear();
        final marker = Marker(
          markerId: MarkerId("curr_loc"),
          position: LatLng(currentLocation.latitude, currentLocation.longitude),
          infoWindow: InfoWindow(title: 'Your Location'),
        );
        _markers1['current location'] = marker;
      });
    }



    //Side Button

    Widget button(Function function, IconData icon) {
      return FloatingActionButton(
        heroTag: null,
        onPressed: function,
        materialTapTargetSize: MaterialTapTargetSize.padded,
        backgroundColor: Colors.blue,
        child: Icon(
          icon,
          size: 36.0,
        ),
      );
    }

    return new Scaffold(
      appBar: AppBar(
        title: Text(txt,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: forthColor,
        leading: IconButton(icon: Icon(Icons.menu),
            onPressed: () {}
        ),
        actions: <Widget>[
          SizedBox(width: 60.0,),
          /*DropdownButton(
                   value: _selectedFloor,
                   items: _dropdownMenuitem, 
                   onChanged: onChangeDropdwonItem,
                   ),  */
        ],
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
           // onMapCreated: _getLocation(),
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
            mapType: _currentMapType,
            markers: _markers,
            onCameraMove: _onCamMove,
            //markers1: _markers1.values.toSet(),
          ),

          Padding(
            padding: EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.topRight,
              child: Column(
                children: <Widget>[
                  button(_onMapTypeButtonPressed, Icons.map),                      //map Type
                  SizedBox(height: 16.0,
                  ),
                  button(_onAddMarkerButtonPressed, Icons.add_location),       //Add Marker
                  SizedBox(
                    height: 16.0,
                  ),
                  button(_goToPosition, Icons.location_searching),    //Location Searching
                  SizedBox(
                    height: 16.0,
                  ),
                  button(_onSearchRoute, Icons.search),       //Search Button
                  SizedBox(
                    height: 16.0,
                  ),
                  button(_onDirectionRoute, Icons.directions),         //Direction
                  SizedBox(
                    height: 16.0,
                  )

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


