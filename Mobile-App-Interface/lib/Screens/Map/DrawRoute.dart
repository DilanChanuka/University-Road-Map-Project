import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';


const String KEY="AIzaSyD27-xwm_C9mv9V2mb2hki_XfzKTD5TYRg";
//Demo pouruse
const double CAMERA_ZOOM = 18;
const double CAMERA_TILT = 0;
const double CAMERA_BEARING = 30;

List<List<double>> location=List.generate(0, (_) =>List.generate(2, (_) => 0.0));


//runApp(DrawRouteLine(paserdata));
class DrawRouteLine extends StatefulWidget 
{

  DrawRouteLine(List<List<double>> data) //Constructor for this class
  {
      location=data;
  }

  @override
  _DrawState  createState() => _DrawState ();

}

class _DrawState  extends State<DrawRouteLine> 
{
 
  GoogleMapController mapcontroller;
  Completer<GoogleMapController> _controller=Completer();

   
    Set<Marker> _marker={};
    Set<Polyline> _polyline={}; 
    List<LatLng> _polylinecordinates=[];
    PolylinePoints _polylinePoints=PolylinePoints();
    String key=KEY;

    //for my custom icon
    BitmapDescriptor sourceIcon;
    BitmapDescriptor destinationIcon;

    void setSourceandDestinationIcons() async{

      sourceIcon=await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'images/destination.png');

      destinationIcon=await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'images/destination.png');
    }

    void _onMapCreated(GoogleMapController controller)
    {
        _controller.complete(controller);
        setMapPing();
        setPolyLine();
    }

    void setMapPing()
    {
        setState(() {
          //source ping
          _marker.add(Marker(
            markerId:MarkerId('source'),
            position: LatLng(location[0][0], location[0][1]),
            icon: sourceIcon
            ));

          //destination pin
          _marker.add(Marker(
            markerId:MarkerId('destination'),
            position: LatLng(location[location.length-1][0], location[location.length-1][1]),
            icon: destinationIcon
             ));
        });
    }

    void setPolyLine() async
    {       

        List<PointLatLng> result=await
        _polylinePoints?.getRouteBetweenCoordinates(
          key,
          location[0][0],
          location[0][1],
          location[location.length-1][0],
          location[location.length-1][1], );

          if(result.isNotEmpty)
          {
            
               for(int i=0;i<location.length;i++)
               {
                 _polylinecordinates.add(LatLng(location[i][0], location[i][1]));
               }
         
             setState(() {
               //create a polyline instence
               // with an id, an RGB color and the list of LatLng pairs
               Polyline polyline=Polyline(
                 polylineId:PolylineId("poly"),
                 color: Color.fromARGB(255,40,122,198),
                 points: _polylinecordinates 
                );

              _polyline.add(
                polyline
              );
            });
          }
    }
   
      @override
    Widget build(BuildContext context) {

        CameraPosition initialLocation=CameraPosition(
          zoom: CAMERA_ZOOM,
          bearing: CAMERA_BEARING,
          tilt: CAMERA_TILT,
          target:LatLng(location[0][0], location[0][1])
          );
      
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              appBar: AppBar(
                title: Text("UOR RoadMap"),
                backgroundColor: Colors.green[700],
              ),
              body: GoogleMap(
                myLocationEnabled: true,
                compassEnabled: true,
                markers: _marker,
                polylines: _polyline,
                mapType: MapType.normal,
                initialCameraPosition: initialLocation,
                onMapCreated: _onMapCreated,
                ),
            ),
          );      
    }

}