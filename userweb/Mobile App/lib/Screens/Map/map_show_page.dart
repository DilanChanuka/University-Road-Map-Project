import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class MapDemo extends StatefulWidget
{
  MapDemo() : super();

  final String txt= "University of Ruhuna";
  @override
  MapsDemoState createState() => MapsDemoState();

}
class MapsDemoState extends State<MapDemo>
{

  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(37.42796133580664, -122.085749655962);
  final Set<Marker> _markers = {};
  LatLng _lastMapPosition = _center;
  MapType _currentMapType = MapType.normal;

  _onMapCreated(GoogleMapController controller)
  {
    _controller.complete(controller);
  }

  _onCamMove(CameraPosition position)
  {
    _lastMapPosition = position.target;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(widget.txt),
          backgroundColor: Colors.yellowAccent,
          leading: IconButton(icon: Icon(Icons.menu),
             onPressed: () {}
          ),
        ),
        body: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
                ),
                mapType: _currentMapType,
                markers: _markers,
                onCameraMove: _onCamMove,
              ),
          ],
        ),
      ),
    );
  }
  
}