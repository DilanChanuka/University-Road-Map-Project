import 'package:map_interfaces/Screens/Common/data.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_interfaces/Screens/Common/placeLatLng.dart';
import 'package:map_interfaces/Screens/Map/Display/Display_getfloor.dart';

List<dynamic> getfloor(List<dynamic> data,int selectedFloorID,String placeName)
{

  //0=> floor location
  //1=> floor all places
  //2=> floor ID ( 0 /1 /2)

    List<dynamic> finaldata=new List<dynamic>();
     //this will hold marker
    Set<Marker> _marker={};

    //this will hold polyline
    Set<Polyline> _polyline={}; 
    List<double> requirdPlaceLatLng=placeLatLng[placeName];
    
    if(data[2]==selectedFloorID)
    {
        //get floor polyline
        if(data[0].length>0)
        {
            Polyline floor =Polyline(
              polylineId:PolylineId("floor"),
              color: floorColor,
              width: floorWidth,
              points:data[0] );

              _polyline.add(floor);
        }


         //get all places marker
    if(data[1].length>0)
    {
        int count=data[1].length;
        for(int i=0;i<count;i++)
        {
            _marker.add(Marker(
              markerId: MarkerId(data[1][i][0]),
              infoWindow: InfoWindow(title: data[1][i][0]),
              position: LatLng(data[1][i][1],data[1][i][2])));
          
        }

    }

    //requird place marker
    if(requirdPlaceLatLng!=null)
    {
        _marker.add(Marker(
          markerId:MarkerId("requird"),
          infoWindow:InfoWindow(title:placeName),
          position:LatLng(requirdPlaceLatLng[0],requirdPlaceLatLng[1]),
          icon:destinationPIN ));

    }


        
    }  

   
    finaldata.add(_polyline);
    finaldata.add(_marker);
    return finaldata;

}


