import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uor_road_map/Screens/Common/data.dart';


const String KEY="AIzaSyD27-xwm_C9mv9V2mb2hki_XfzKTD5TYRg";
const double CAMERA_ZOOM = 18;
const double CAMERA_TILT = 0;
const double CAMERA_BEARING = 30;

//List<List<double>> location=[[7.353296, 80.932708],[7.354007, 80.933680]];

List<dynamic> floorAplaces; //0=>floor location as latLng paires 1=> all places details

class Drawfloor extends StatefulWidget 
{

  Drawfloor(List<dynamic> data) //this calss use for draw floor and set floor all places
  {
      floorAplaces=data;  
  }

  @override
  //_DrawState  createState() => _DrawState ();
   
  State<StatefulWidget> createState(){   
    return _DrawState();
  } 
}

class _DrawState  extends State<Drawfloor> 
{
 
  GoogleMapController mapcontroller;
  Completer<GoogleMapController> _controller=Completer();

    
     //this will hold marker
    Set<Marker> _marker={};

    //this will hold polyline
    Set<Polyline> _polyline={}; 

    //this will hold each polyline cordinates as Lat and Lng pairs
    List<LatLng> _floorCordinates=[];
  
    //this is the key object -the polylinepoints
    //which genarated every polyiline bitween start and finish
    //PolylinePoints _polylinePoints=PolylinePoints();


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
        
        setMapPing();
        setPolyLine();
    }

    void setMapPing()
    {
        int count=floorAplaces[1].length;
     
        setState(() 
        {
            //set All Marker 
          for(int i=0;i<count;i++)
          {
              String id=i.toString();
            _marker.add(Marker(
              markerId:MarkerId(id),
              position: LatLng(floorAplaces[1][i][1], floorAplaces[1][i][2]),
              ));

          }
              
        });
    }

    void setPolyLine() async
    {       

          if(true)
          {
              _floorCordinates=floorAplaces[0];

              //add first cordinat again for continu polygon
              _floorCordinates.add(LatLng(floorAplaces[0][0].latitude, floorAplaces[0][0].longitude));


             setState(() {
     
            
              Polyline floor=Polyline(
                 polylineId:PolylineId("floor"),
                 color:floorColor,
                 points: _floorCordinates 
                );

                _polyline.add(floor);
            });
          }
    }
   
      @override
    Widget build(BuildContext context) {

        CameraPosition initialLocation=CameraPosition(
          zoom: CAMERA_ZOOM,
          bearing: CAMERA_BEARING,
          tilt: CAMERA_TILT,
          target:LatLng(floorAplaces[0][0].latitude,floorAplaces[0][1].longitude)
          );
      
          return MaterialApp(
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