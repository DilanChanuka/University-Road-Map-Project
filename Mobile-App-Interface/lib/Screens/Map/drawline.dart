import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:MapView/Common/data.dart';


const String KEY="AIzaSyD27-xwm_C9mv9V2mb2hki_XfzKTD5TYRg";
const double CAMERA_ZOOM = 18;
const double CAMERA_TILT = 0;
const double CAMERA_BEARING = 30;

//List<List<double>> location=[[7.353296, 80.932708],[7.354007, 80.933680]];
List<LatLng> geolocation=new List<LatLng>();
List<List<double>> location;

class DrawRouteLine extends StatefulWidget 
{

  DrawRouteLine(List<LatLng> data)
  {
      geolocation=data;  
  }

  @override
  //_DrawState  createState() => _DrawState ();
   
  State<StatefulWidget> createState(){   
    return _DrawState();
  } 
}

class _DrawState  extends State<DrawRouteLine> 
{
 
  GoogleMapController mapcontroller;
  Completer<GoogleMapController> _controller=Completer();

    
     //this will hold marker
    Set<Marker> _marker={};

    //this will hold polyline
    Set<Polyline> _polyline={}; 

    //this will hold each polyline cordinates as Lat and Lng pairs
    List<LatLng> _polylinecordinates=[];

  
    //this is the key object -the polylinepoints
    //which genarated every polyiline bitween start and finish
   // PolylinePoints _polylinePoints=PolylinePoints();


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

    //final LatLng _center=const LatLng(5.939639, 80.576553);

    void _onMapCreated(GoogleMapController controller)
    {
        _controller.complete(controller); 
        putData();
        setMapPing();
        setPolyLine();
    }

   void putData()
    {
        location=List.generate(geolocation.length, (_) =>List.generate(2, (_) => 0.0));    
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

    void setPolyLine()
    {       


          if(true)
          {
            
              _polylinecordinates=geolocation;

             setState(() {
               //create a polyline instence
               // with an id, an RGB color and the list of LatLng pairs
              Polyline routes=Polyline(
                 polylineId:PolylineId("route"),
                 color:routeColor,
                 width: routeWidth,
                 points: _polylinecordinates 
                );

                _polyline.add(routes);
           
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
            home: Scaffold(
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