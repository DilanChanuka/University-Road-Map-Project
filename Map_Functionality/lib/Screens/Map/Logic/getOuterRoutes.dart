import 'package:map_interfaces/Screens/Map/Display/Display_OuterRoutes.dart';
import 'package:map_interfaces/Screens/Common/data.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


List<dynamic> getOuterRoutes(List<dynamic> data,int selectedfloorid,List<String> startAendL)
{

    //0=>routetsLocation
    //1=> 0=>Distence
    //    1=>Time

     //this will hold marker
    Set<Marker> _marker={};

    //this will hold polyline
    Set<Polyline> _polyline={}; 

  
    if(data[0].length>0 && selectedfloorid==0)
    { 
         //source ping
          _marker.add(Marker(
            markerId:MarkerId('source'),
            infoWindow: InfoWindow(title: startAendL[0]),
            position: LatLng(data[0][0].latitude, data[0][0].longitude),
            icon: sourceIcon
            ));

          //destination pin
          _marker.add(Marker(
            markerId:MarkerId('destination'),
            infoWindow: InfoWindow(title: startAendL[1]),
            position: LatLng(data[0][data[0].length-1].latitude, data[0][data[0].length-1].longitude),
            icon: destinationIcon
             ));
       


          Polyline routes=Polyline(
                 polylineId:PolylineId("route"),
                 color:routeColor,
                 points: data[0]
                );
                        
                _polyline.add(routes);           
        
    }
   
    List<dynamic> finalData=new List<dynamic>();
    finalData.add(_polyline);
    finalData.add(_marker);

    return finalData;
}


