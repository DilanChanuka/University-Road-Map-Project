import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uor_road_map/Screens/Common/data.dart';
import 'package:uor_road_map/Screens/Request/ConvertData.dart';


const String KEY="AIzaSyD27-xwm_C9mv9V2mb2hki_XfzKTD5TYRg";
const double CAMERA_ZOOM = 18;
const double CAMERA_TILT = 0;
const double CAMERA_BEARING = 30;

List<List<double>> location=[[7.353296, 80.932708],[7.354007, 80.933680]];

List<dynamic> allCordinates; 

 //this calss use for draw outer route/ inner routes /stair
class DrawPlace extends StatefulWidget        // getplace
{

  DrawPlace(List<dynamic> data)
  {
      allCordinates=data;
         print(allCordinates);
  }

  @override
  //_DrawState  createState() => _DrawState ();
   
  State<StatefulWidget> createState(){   
    return _DrawState();
  } 
}

class _DrawState  extends State<DrawPlace> 
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
        
        setMapPing();
        setPolyLine();
    }

    void setMapPing()
    {
       
        setState(() 
        {          
            _marker.add(Marker(
              markerId:MarkerId("Place"),
              position: LatLng(allCordinates[4][1],allCordinates[4][2]),
              ));

        });
    }

    void setPolyLine()
    {       

        _outerRoutesCordinates=allCordinates[0];
       

        int n=allCordinates[0].length;
        //set outer route last cordinate in floor 0 first value
        _floorR0.add(LatLng(allCordinates[0][n-1].latitude,allCordinates[0][n-1].longitude));
        for(int i=0;i<allCordinates[1][0].length;i++)
        {
            _floorR0.add(LatLng(allCordinates[1][0][i].latitude,allCordinates[1][0][i].longitude));

        }
        
              //floor 1 route                   //stair 01 
        if(allCordinates[1][1].length>0 && allCordinates[2][0].length>0)
        {
            int n=allCordinates[2][0].length; //stair01 last cordinates
            //joint floor route 0 and floor 1 route
            _floorR1.add(LatLng(allCordinates[2][0][n-1].latitude,allCordinates[2][0][n-1].longitude));
            
          for(int i=0;i<allCordinates[1][1].length;i++)
          {
              _floorR1.add(LatLng(allCordinates[1][1][i].latitude,allCordinates[1][1][i].longitude));
          }
            
        }
              //floor 2                     //stair12
        if(allCordinates[1][2].length>0 && allCordinates[2][1].length>0)
        {
           int n=allCordinates[2][1].length; //stair12 last cordinate
           //join floor 1  route and stair 01 route
           _floorR2.add(LatLng(allCordinates[2][1][n-1].latitude,allCordinates[2][1][n-1].longitude));
                    
          for(int i=0;i<allCordinates[1][2].length;i++)
          {
              _floorR2.add(LatLng(allCordinates[1][2][i].latitude,allCordinates[1][2][i].longitude));
          }
        }
              //stair01                       //floor0 routes
        if(allCordinates[2][0].length>0 && allCordinates[1][0].length>0)  
        {
            int n=allCordinates[1][0].length;//floor0 route last cordinate
            //join floor 0  and stair01
            _stair01Cordinates.add(LatLng(allCordinates[1][0][n-1].latitude,allCordinates[1][0][n-1].longitude));
                
            for(int i=0;i<allCordinates[2][0].length;i++)
            {
                _stair01Cordinates.add(LatLng(allCordinates[2][0][i].latitude,allCordinates[2][0][i].longitude));
            }
            
        }       //stair 12                     //floor 1
        if(allCordinates[2][1].length>0 && allCordinates[1][1].length>0) 
        {
          int n=allCordinates[1][1].length;//floor1 route last cordinate
          //join floor 1 and stair 12
          _stair12Cordinates.add(LatLng(allCordinates[1][1][n-1].latitude,allCordinates[1][1][n-1].longitude));
            for(int i=0;i<allCordinates[2][1].length;i++)
            {
                _stair12Cordinates.add(LatLng(allCordinates[2][1][i].latitude,allCordinates[2][1][i].longitude));
            }
    
        }

        //get floor cordinates
        int floor=getSelectedFloorID(allCordinates[3]);
        if(allCordinates[3][floor].length>0)
        {
            _floorCordinates=allCordinates[3][floor];
            _floorCordinates.add(LatLng(allCordinates[3][floor][0].latitude,allCordinates[3][floor][0].longitude));

        }

        setState((){
     
          //List<String> arrname=["floor0R","floor1R","floor2R","s01","s12"];
          if(_outerRoutesCordinates.length>0)
          {
            Polyline outerR=Polyline(
              polylineId:PolylineId("outer"),
                color: Color.fromARGB(255,40,122,198),
             // color:floorColor,
              points: _outerRoutesCordinates 
              );

              _polyline.add(outerR);
          }
          if(_floorR0.length>0)
          { 
            Polyline floor0R=Polyline(
              polylineId:PolylineId("F0r"),
                color: Color.fromARGB(255,40,122,198),
              //color:floorColor,
              points: _floorR0 
              );

              _polyline.add(floor0R);
          }
          if(_floorR2.length>0)
          {
               
            Polyline floor1R=Polyline(
              polylineId:PolylineId("F1r"),
                color: Color.fromARGB(255,40,122,198),
             // color:floorColor,
              points: _floorR1 
              );

            _polyline.add(floor1R);
          }  
          if(_floorR2.length>0)
          {
              
            Polyline floor2R=Polyline(
              polylineId:PolylineId("F2r"),
                color: Color.fromARGB(255,40,122,198),
             // color:routeColor,
              points: _floorR2 
              );

            _polyline.add(floor2R);
          }
          if(_stair01Cordinates.length>0)
          {
            Polyline s01=Polyline(
              polylineId:PolylineId("S01"),
                color: Color.fromARGB(255,40,122,198),
              //color:stairColor,
              points: _stair01Cordinates 
              );

              _polyline.add(s01);
          }
          if(_stair12Cordinates.length>0)
          {
            Polyline s12=Polyline(
              polylineId:PolylineId("S12"),
                color: Color.fromARGB(255,40,122,198),
            //  color:stairColor,
              points: _stair12Cordinates 
              );

              _polyline.add(s12);
          }
          if(_floorCordinates.length>0)
          {
              
            Polyline releventf=Polyline(
              polylineId:PolylineId("f"),
                color: Color.fromARGB(255,40,122,198),
            //  color:floorColor,
              points: _floorCordinates 
              );

              _polyline.add(releventf);
          }
           
        });
         
    }


    int getSelectedFloorID(List<dynamic> data)
    {
      print(data);
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
              //  markers: _marker,
             //   polylines: _polyline,
                mapType: MapType.normal,
                initialCameraPosition: initialLocation,
             //   onMapCreated: _onMapCreated,
                ),
            ),
          );      
    }

}