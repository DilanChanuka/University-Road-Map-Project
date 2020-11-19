import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uor_road_map/Screens/Common/data.dart';

const String KEY=GOOGL_KEY;
const double CAMERA_ZOOM = 18;
const double CAMERA_TILT = 0;
const double CAMERA_BEARING = 30;


List<dynamic> allCordinates; 

 //this class use for draw outer routes , floor routes and floor
class DrawPlaceinout extends StatefulWidget     //getplceinout
{

  DrawPlaceinout(List<dynamic> data)
  {
      allCordinates=data;  
  }

  @override
  //_DrawState  createState() => _DrawState ();
   
  State<StatefulWidget> createState(){   
    return _DrawState();
  } 
}

class _DrawState  extends State<DrawPlaceinout> 
{
 
  GoogleMapController mapcontroller;
  Completer<GoogleMapController> _controller=Completer();

    
     //this will hold marker
    Set<Marker> _marker={};

    //this will hold polyline
    Set<Polyline> _polyline={}; 

    //this will hold each polyline cordinates as Lat and Lng pairs
    List<LatLng> _outerRoutesCordinates=[];
    List<LatLng> _floorR0=[];
    List<LatLng> _floorR1=[];
    List<LatLng> _floorR2=[];
    List<LatLng> _stair01Cordinates=[];
    List<LatLng> _stair12Cordinates=[];
    List<LatLng> _floorCordinates=[];

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
        
        //setMapPing();
        setPolyLine();
    }

    void setMapPing()
    {
       
        setState(() 
        {          
            _marker.add(Marker(
              markerId:MarkerId("dest"),
              position: LatLng(allCordinates[4][1],allCordinates[4][2]),
              ));

        });
    }

    void setPolyLine()
    {       
       
       
              //floor 0 route                   //outer route 
        if(allCordinates[1][0].length>0 && allCordinates[0].length>0)
        {
            for(int i=0;i<allCordinates[1][0].length;i++)
            {
                _floorR0.add(LatLng(allCordinates[1][0][i].latitude,allCordinates[1][0][i].longitude));
            }

             int n=allCordinates[1][0].length;
            //set outer route first cordinate in floor 0 last value
            _outerRoutesCordinates.add(LatLng(allCordinates[1][0][n-1].latitude,allCordinates[1][0][n-1].longitude));
            for(int i=0;i<allCordinates[0].length;i++)
            {
                _outerRoutesCordinates.add(LatLng(allCordinates[0][i].latitude,allCordinates[0][i].longitude));
            }
        }
              //stair01
        if(allCordinates[2][0].length>0)
        {
           _stair01Cordinates=allCordinates[2][0];
           //add last value in floor0 first value
           if(allCordinates[1][0].length>0)
           {
              _stair01Cordinates.add(LatLng(allCordinates[1][0][0].latitude,allCordinates[1][0][0].latitude));
           }
        }
              //floor 1
        if(allCordinates[1][1].length>0)
        { 
            _floorR1=allCordinates[1][1];
            //add stair01 first value as floor 1 last value
            if(allCordinates[2][0].length>0)
            {
                _floorR1.add(LatLng(allCordinates[2][0][0].latitude,allCordinates[2][0][0].longitude));
            }
        }
         //stair12
         if(allCordinates[2][1].length>0)
         {
           _stair12Cordinates=allCordinates[2][1];
           //add floor1 route first value as stair12 last value if exist
           if(allCordinates[1][1].length>0)
           {
              _stair12Cordinates.add(LatLng(allCordinates[1][1][0].latitude,allCordinates[1][1][0].longitude));
           }
           else if(allCordinates[1][0].length>0)
           {
                //add stair01 first value as stair12 last value
              _stair12Cordinates.add(LatLng(allCordinates[2][0][0].latitude,allCordinates[2][0][0].longitude));
           }
         }

         //floor2
         if(allCordinates[1][2].length>0)
         {
            _floorR2=allCordinates[1][2];
            //add stair12 first value as floor2 last value
            if(allCordinates[2][1].length>0)
              _floorR2.add(LatLng(allCordinates[2][1][0].latitude,allCordinates[2][1][0].longitude));
         }

        //get floor cordinates
        int floor=getSelectedFloorID(allCordinates[3]);
        if(allCordinates[3][floor].length>0)
        {
            _floorCordinates=allCordinates[3][floor];
            _floorCordinates.add(LatLng(allCordinates[3][floor][0].latitude,allCordinates[3][floor][0].longitude));

        }

        setState((){
     
          if(_outerRoutesCordinates.length>0)
          {
            Polyline outerR=Polyline(
              polylineId:PolylineId("outer"),
              color:floorColor,
              points: _outerRoutesCordinates 
              );

              _polyline.add(outerR);
          }
          if(_floorR0.length>0)
          { 
            Polyline floor0R=Polyline(
              polylineId:PolylineId("F0r"),
              color:floorColor,
              points: _floorR0 
              );

              _polyline.add(floor0R);
          }
          if(_floorR2.length>0)
          {
               
            Polyline floor1R=Polyline(
              polylineId:PolylineId("F1r"),
              color:floorColor,
              points: _floorR1 
              );

            _polyline.add(floor1R);
          }  
          if(_floorR2.length>0)
          {
              
            Polyline floor2R=Polyline(
              polylineId:PolylineId("F2r"),
              color:routeColor,
              points: _floorR2 
              );

            _polyline.add(floor2R);
          }
          if(_stair01Cordinates.length>0)
          {
            Polyline s01=Polyline(
              polylineId:PolylineId("S01"),
              color:stairColor,
              points: _stair01Cordinates 
              );

              _polyline.add(s01);
          }
          if(_stair12Cordinates.length>0)
          {
            Polyline s12=Polyline(
              polylineId:PolylineId("S12"),
              color:stairColor,
              points: _stair12Cordinates 
              );

              _polyline.add(s12);
          }
          if(_floorCordinates.length>0)
          {
              
            Polyline releventf=Polyline(
              polylineId:PolylineId("f"),
              color:floorColor,
              points: _floorCordinates 
              );

              _polyline.add(releventf);
          }
           
        });
         
    }


    int getSelectedFloorID(List<dynamic> data)
    {
        if(data[0].length>0)
          return 0;
        else if(data[1].length>0)
          return 1;
        else
          return 2;
    }

      @override
    Widget build(BuildContext context) {

        CameraPosition initialLocation=CameraPosition(
          zoom: CAMERA_ZOOM,
          bearing: CAMERA_BEARING,
          tilt: CAMERA_TILT,
          target:LatLng(allCordinates[1][0][0].latitude,allCordinates[1][0][0].longitude)
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