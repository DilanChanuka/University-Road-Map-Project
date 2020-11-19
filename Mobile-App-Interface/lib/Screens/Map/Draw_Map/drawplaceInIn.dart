import 'dart:async';
import 'package:uor_road_map/Screens/Common/data.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


const String KEY=GOOGL_KEY;
const double CAMERA_ZOOM = 18;
const double CAMERA_TILT = 0;
const double CAMERA_BEARING = 30;

List<dynamic> geolocation=new List<dynamic>();
List<LatLng> location;
List<LatLng> floor;
List<LatLng> stair;
String placeName;
double lat,lng;

List<dynamic> array=[location,floor,stair];

//this class use for < drawplaceinin >
class DrawPlaceInIn extends StatefulWidget  //this class use for drwa floor , route and stair
{

  DrawPlaceInIn(List<dynamic> data)
  {
      geolocation=data;  
  }

  @override
  //_DrawState  createState() => _DrawState ();
   
  State<StatefulWidget> createState(){   
    return _DrawState();
  } 
}

class _DrawState  extends State<DrawPlaceInIn> 
{
 
  GoogleMapController mapcontroller;
  Completer<GoogleMapController> _controller=Completer();

    
    //this will hold marker
    Set<Marker> _marker={};

    //this will hold polyline
    Set<Polyline> _polyline={}; 

    //this will hold each polyline cordinates as Lat and Lng pairs
    List<LatLng> _floorRouteCordinates=[];
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
        //putData();
        setMapPing();
        setPolyLine();
    }

   void putData()
    {
        placeName=geolocation[2];
        lat=geolocation[1][0];
        lng=geolocation[1][1];

        for(int i=0;i<3;i++) //route and floor
        {
            
            for(int j=0;j<geolocation[0][i].length;j++)
            {
                array[i][j][0]=geolocation[0][i][j].latitude;
                array[i][j][1]=geolocation[0][i][j].longitude;
            }

        }
    }

    void setMapPing()
    {
        setState(() {

          //destination pin
          _marker.add(Marker(
            markerId:MarkerId('destination'),
            position: LatLng(geolocation[1][0],geolocation[1][1]),
            icon: destinationIcon
             ));
        });
    }

    void setPolyLine() 
    {       
      int last=geolocation[0][0].length-1;
      if(geolocation[0][0].length>0)
          _floorRouteCordinates=geolocation[0][0];//route
      
      if(geolocation[0][1].length>0)
      {
         //add last value for stair as a fist value
          _stairCordinates.add(LatLng(geolocation[0][0][last].latitude,geolocation[0][0][last].longitude));
          for(int i=0;i<geolocation[0][1].length;i++)
          {
              double a=geolocation[0][1][i].latitude;
              double b=geolocation[0][1][i].longitude;
              _stairCordinates.add(LatLng(a,b));          
          }
      }   


      if(geolocation[0][2].length>0)
        _floorCordinates=geolocation[0][2];

        //add first cordinat again for continu polygon
       _floorCordinates.add(LatLng(geolocation[0][2][0].latitude, geolocation[0][2][0].longitude));

             setState(() {
     
               if(_floorRouteCordinates.length>0)
               {
                  Polyline routes=Polyline(
                  polylineId:PolylineId("route"),
                  color: routeColor,
                  width: routeWidth,
                  points: _floorRouteCordinates 
                  );

                  _polyline.add(routes);
               }
               if(_floorCordinates.length>0)
               {
                  Polyline floor=Polyline(
                  polylineId:PolylineId("floor"),
                  color: floorColor,
                  width: floorWidth,
                  points: _floorCordinates 
                  );

                  _polyline.add(floor);
               }
               if(_stairCordinates.length>0)
               {
                  Polyline stair=Polyline(
                  polylineId:PolylineId("stair"),
                  color: stairColor,
                  width: stairWidth,
                  points: _stairCordinates 
                  );
                  _polyline.add(stair);
               }
              
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
                polylines: _polyline,
                mapType: MapType.normal,
                initialCameraPosition: initialLocation,
                onMapCreated: _onMapCreated,
                ),
            ),
          );      
    }

}