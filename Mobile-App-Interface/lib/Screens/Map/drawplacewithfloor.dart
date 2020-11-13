import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uor_road_map/Screens/Common/data.dart';


const String KEY=GOOGL_KEY;
const double CAMERA_ZOOM = 18;
const double CAMERA_TILT = 0;
const double CAMERA_BEARING = 30;


List<dynamic> location; //0=>floorL  1=>relevent floor details  2=>all place details

//this class use  for draw floor and displace relevent floor all places
//drawplacewithfloor
class Drawplacewithfloor extends StatefulWidget  
{

  Drawplacewithfloor(List<dynamic> data)
  {
      location=data;  
  }

  @override
  //_DrawState  createState() => _DrawState ();
   
  State<StatefulWidget> createState(){   
    return _DrawState();
  } 
}

class _DrawState  extends State<Drawplacewithfloor> 
{
 
  GoogleMapController mapcontroller;
  Completer<GoogleMapController> _controller=Completer();

    
     //this will hold marker
    Set<Marker> _marker={};

    //this will hold polyline
    Set<Polyline> _polyline={}; 

    //this will hold each polyline cordinates as Lat and Lng pairs
    List<LatLng> _floorCordinates=[];
  
    String key=KEY;

    void _onMapCreated(GoogleMapController controller)
    {
        _controller.complete(controller); 
        setMapPing();
        setPolyLine();
    }


    void setMapPing()
    {
        setState(() {
          
           //relevent place
          _marker.add(Marker(
            markerId:MarkerId('main'),
            infoWindow: InfoWindow(title:location[1][0]),
            alpha: 0.9,
            position: LatLng(location[1][1], location[1][2]),
            
            ));

            for(int i=0;i<location[2].length;i++)
            {
                 String id=i.toString();
                _marker.add(Marker(
                  markerId:MarkerId(id),
                  infoWindow: InfoWindow(title:location[2][i][0]),
                  //place name =>location[2][i][0]
                  position: LatLng(location[2][i][1],location[2][i][2]) ));
            }

        });
    }

    void setPolyLine() 
    {       
          _floorCordinates=location[0];
          _floorCordinates.add(LatLng(location[0][0].latitude,location[0][0].longitude));

             setState(() {
               //create a polyline instence
               // with an id, an RGB color and the list of LatLng pairs
              Polyline floor=Polyline(
                 polylineId:PolylineId("route"),
                 color:routeColor,
                 points: _floorCordinates 
                );
                        
                _polyline.add(floor);
              
            });
          
    }
   
      @override
    Widget build(BuildContext context) {

        CameraPosition initialLocation=CameraPosition(
          zoom: CAMERA_ZOOM,
          bearing: CAMERA_BEARING,
          tilt: CAMERA_TILT,
          target:LatLng(location[0][0].latitude, location[0][0].longitude)
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