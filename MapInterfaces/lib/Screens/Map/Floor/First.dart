import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class First extends StatefulWidget {
  @override
  _FirstState createState() => _FirstState();
}

class _FirstState extends State<First> {

  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(37.42796133580664, -122.085749655962);
  final Set<Marker> _markers = {};
  LatLng _lastMapPosition = _center;
  MapType _currentMapType = MapType.normal;

  static final CameraPosition _position = CameraPosition(
    bearing: 192.833,
    target: LatLng(37.43796133580664, -122.085749655962),
    tilt: 59.440,
    zoom: 11.0,
  );

  Future<void> _goToPosition() async{
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_position),);
  }

  _onMapCreated(GoogleMapController controller)
  {
    _controller.complete(controller);
  }

  _onCamMove(CameraPosition position)
  {
    _lastMapPosition = position.target;
  }

  _onMapTypeButtonPressed()
  {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal 
      ? MapType.satellite 
      : MapType.normal;
    });
  }

  _onAddMarkerButtonPressed()
  {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId(_lastMapPosition.toString()),
        position: _lastMapPosition,
        infoWindow: InfoWindow(
          title: "Title",
          snippet: "snippet",
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }
  Widget button(Function function,IconData icon)
  {
    return FloatingActionButton(
      onPressed: function,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      backgroundColor: Colors.blue,
      child: Icon(
        icon,
        size: 36.0,
      ),
      );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
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
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Column(
                    children: <Widget>[
                      button(_onMapTypeButtonPressed, Icons.map),
                      SizedBox(height: 16.0, 
                      ),
                      button(_onAddMarkerButtonPressed, Icons.add_location),
                      SizedBox(
                        height: 16.0,
                      ),
                      button(_goToPosition, Icons.location_searching),
                    ],
                  ),
                ),
                ),
          ],
      ),
    );
  }
}