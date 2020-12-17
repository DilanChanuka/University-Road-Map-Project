
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';


const String KEY="AIzaSyD27-xwm_C9mv9V2mb2hki_XfzKTD5TYRg";
const double CAMERA_ZOOM = 18;
const double CAMERA_TILT = 0;
const double CAMERA_BEARING = 30;

List<dynamic> geolocation=new List<dynamic>();  //0=>name  1=>2d array  (0 => lat  |  1 => lng )
String placeName;
double lat,lng;


class SetPlace extends StatefulWidget  //this class use for drwa floor , route and stair
{

  SetPlace(List<dynamic> data)
  {
      geolocation=data;  
  }

  @override
  //_DrawState  createState() => _DrawState ();
   
  State<StatefulWidget> createState(){   
    return _DrawState();
  } 
}

class _DrawState  extends State<SetPlace> 
{
 
  GoogleMapController mapcontroller;
  Completer<GoogleMapController> _controller=Completer();

    
    //this will hold marker
    Set<Marker> _marker={};

  
    //this is the key object -the polylinepoints
    //which genarated every polyiline bitween start and finish

    String key=KEY;

    //for my custom icon
    BitmapDescriptor sourceIcon;

    void setSourceandDestinationIcons() async{

      sourceIcon=await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'images/destination.png');
    }

    //final LatLng _center=const LatLng(5.939639, 80.576553);

    void _onMapCreated(GoogleMapController controller)
    {
        _controller.complete(controller); 
        setMapPing();
    }



    void setMapPing()
    {
        placeName=geolocation[0];
        lat=geolocation[1][0];
        lng=geolocation[1][1];

        setState(() {
          _marker.add(Marker(
            markerId:MarkerId('place'),
            position: LatLng(lat,lng),
            icon: sourceIcon
            ));
        });
    }
   
      @override
    Widget build(BuildContext context) {

        CameraPosition initialLocation=CameraPosition(
          zoom: CAMERA_ZOOM,
          bearing: CAMERA_BEARING,
          tilt: CAMERA_TILT,
          target:LatLng(geolocation[1][0],geolocation[1][1])
          );
      
          return MaterialApp(
            home: Scaffold(

              body: GoogleMap(
                myLocationEnabled: true,
                compassEnabled: true,
                markers: _marker,
                
                mapType: MapType.normal,
                initialCameraPosition: initialLocation,
                onMapCreated: _onMapCreated,
                ),
            ),
          );      
    }

}