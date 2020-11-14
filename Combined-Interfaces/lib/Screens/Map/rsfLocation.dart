import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:MapView/Common/data.dart';


const String KEY="AIzaSyD27-xwm_C9mv9V2mb2hki_XfzKTD5TYRg";
const double CAMERA_ZOOM = 18;
const double CAMERA_TILT = 0;
const double CAMERA_BEARING = 30;

List<List<LatLng>> geolocation=new List<List<LatLng>>();
List<List<double>> location;
List<List<double>> floor;
List<List<double>> stair;

List<dynamic> array=[location,floor,stair];

class Rsflocation extends StatefulWidget 
{

  Rsflocation(List<List<LatLng>> data)
  {
      geolocation=data;  
  }

  @override
  //_DrawState  createState() => _DrawState ();
   
  State<StatefulWidget> createState(){   
    return _DrawState();
  } 
}

class _DrawState  extends State<Rsflocation> 
{
 
  GoogleMapController mapcontroller;
  Completer<GoogleMapController> _controller=Completer();

    
    //this will hold marker
    Set<Marker> _marker={};

    //this will hold polyline
    Set<Polyline> _polyline={}; 

    //this will hold each polyline cordinates as Lat and Lng pairs
    List<LatLng> _polylinecordinates=[];
    List<LatLng> _floorCordinates=[];
    List<LatLng> _stairCordinates=[];
  
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
        location=List.generate(geolocation[0].length, (_) =>List.generate(2, (_) => 0.0));
        floor=List.generate(geolocation[1].length, (_) =>List.generate(2, (_) => 0.0));
        stair=List.generate(geolocation[2].length, (_) =>List.generate(2, (_) => 0.0));

        for(int i=0;i<3;i++) //route and floor
        {
            
            for(int j=0;j<geolocation[i].length;j++)
            {
                array[i][j][0]=geolocation[i][j].latitude;
                array[i][j][1]=geolocation[i][j].longitude;
            }

        }
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
            position: LatLng(stair[stair.length-1][0],stair[stair.length-1][1]),
            icon: destinationIcon
             ));
        });
    }

    void setPolyLine() async
    {       

       /* List<PointLatLng> result=await
        _polylinePoints?.getRouteBetweenCoordinates(
          key,
          location[0][0],
          location[0][1],
          location[location.length-1][0],
          location[location.length-1][1],
          );
*/
          //if(result.isNotEmpty)
          if(true)
          {
             int last=geolocation[0].length-1;

              _polylinecordinates=geolocation[0];

              //add last value for stair as a fist value
              _stairCordinates.add(LatLng(geolocation[0][last].latitude,geolocation[0][last].longitude));
              _stairCordinates=geolocation[2];
              
              _floorCordinates=geolocation[1];

              //add first cordinat again for continu polygon
              _floorCordinates.add(LatLng(geolocation[1][0].latitude, geolocation[1][0].longitude));

             setState(() {
               //create a polyline instence
               // with an id, an RGB color and the list of LatLng pairs
               Polyline routes=Polyline(
                 polylineId:PolylineId("route"),
                 color:routeColor,
                 width: routeWidth,
                 points: _polylinecordinates 
                );


                Polyline floor=Polyline(
                 polylineId:PolylineId("floor"),
                 color: floorColor,
                 width: floorWidth,
                 points: _floorCordinates 
                );

                Polyline stair=Polyline(
                 polylineId:PolylineId("stair"),
                 color:stairColor,
                 width: stairWidth,
                 points: _floorCordinates 
                );

                _polyline.add(routes);
                _polyline.add(floor);
                _polyline.add(stair);
            });
          }
    }
   
      @override
    Widget build(BuildContext context) {

        CameraPosition initialLocation=CameraPosition(
          zoom: CAMERA_ZOOM,
          bearing: CAMERA_BEARING,
          tilt: CAMERA_TILT,
          target:LatLng(geolocation[0][0].latitude,geolocation[0][0].longitude)
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