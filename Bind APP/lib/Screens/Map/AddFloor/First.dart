import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class First extends StatefulWidget { 
  @override
  _FirstState createState() => _FirstState();
}

class _FirstState extends State<First> {

  GoogleMapController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
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
          ],
      ),
    );
  }

   void mapCreated(controller)
  {
    setState(() {
      controller = controller;
    });
  }
}