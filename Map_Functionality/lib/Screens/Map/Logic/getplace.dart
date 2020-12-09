import 'package:map_interfaces/Screens/Disition/disistionFunc.dart';
import 'package:map_interfaces/Screens/Map/Display/Display_getPlace.dart';
import 'package:map_interfaces/Screens/Common/data.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


List<dynamic> getplace(List<dynamic> data,int selectedFloorID,int destinationFID)
{

    //0=>outer routes
    //1=> floor routes 
    //      0 =>groud floor
    //      1 =>first floor
    //      2 =>second floor
    //2=>stair  (01  /  12)
    //3=>floor  (0 / 1 / 2)
    //4=>place 
    //      0=>name
    //      1=>lat
    //      2=>lng

    List<dynamic> finaldata=new List<dynamic>();
     //this will hold marker
    Set<Marker> _marker={};

    //this will hold polyline
    Set<Polyline> _polyline={}; 
    List<int> flage=[1,1,1];
    List<int> flageStar=[1,1];
  
    if(data[3][selectedFloorID].length>0)
    {
        flage[selectedFloorID]=0;
         //get outer routes polyline
        if(data[0].length>0 && selectedFloorID==0)
        {
            Polyline outerR=Polyline(
              polylineId:PolylineId("outerR"),
              color: routeColor,
              width: routeWidth,
              points: data[0] );

              _polyline.add(outerR);
        }

        //get floor Routes
        if(data[1][selectedFloorID].length>0)
        {
            Polyline floorR=Polyline(
              polylineId:PolylineId("floorR"),
              color: routeColor,
              width: routeWidth,
              points: data[1][selectedFloorID] );

              _polyline.add(floorR);
        }


        //get stair routes polyline
        if(selectedFloorID==0)
        {
            //stair 01
            if(data[2][selectedFloorID].length>0)
            {
              flageStar[0]=0;
              Polyline stair01=Polyline(
                polylineId:PolylineId("stair01"),
                color: stairColor,
                width: stairWidth,
                points: data[2][selectedFloorID] );

                _polyline.add(stair01);           
            }
        }
        if(selectedFloorID==1)
        {
            //stair12
            if(data[2][selectedFloorID].length>0)
            {
              flageStar[1]=0;
              Polyline stair12=Polyline(
                polylineId:PolylineId("stair12"),
                color: stairColor,
                width: stairWidth,
                points: data[2][selectedFloorID] );

                _polyline.add(stair12);           
            }       
        }

        //get floor polyline
        if(data[3][selectedFloorID].length>0)
        {
              Polyline floor=Polyline(
                polylineId:PolylineId("floor"),
                color: floorColor,
                width: floorWidth,
                points: data[3][selectedFloorID] );

                _polyline.add(floor);
        }

        //get destination marker
        if(data[4].length>0)
        {
          String name=data[4][0];
                _marker.add(Marker(
                  markerId: MarkerId(data[4][0]),
                  infoWindow: InfoWindow(title: name),
                  icon: destLocation,
                  position: LatLng(data[4][1],data[4][2])));
              
        }
        //get user location pin
        if(data[0].length>0)
        {
            //in this selected floor should be ground
            _marker.add(Marker(
              markerId:MarkerId("userPin"),
              infoWindow: InfoWindow(title:"Start Location"),
              icon: userLocation,
              position: LatLng(data[0][0].latitude,data[0][0].longitude) ));
        }
      
    }
    //get outer route dotted line
    if(data[0].length>0 && selectedFloorID!=0 && destinationFID >= selectedFloorID )
    {
       Polyline outerDotLine=Polyline(
        polylineId:PolylineId("outerDL"),
        color:routesDColor,
        width: routeWidth,
        patterns: [PatternItem.dot,PatternItem.gap(10)],
        points: data[0] );

       _polyline.add(outerDotLine);
    }

    Polyline grdRPL; //ground Routes Poly Line
    Polyline firsrRPL;
    Polyline secondRPL;

    List<Polyline> floorRName=[grdRPL,firsrRPL,secondRPL];
    List<String> floorRoutesID=["groundFR","firstFR","secondFR"];

    //get dotted line for routes
    for(int i=0;i<3;i++)
    {
        if(flage[i]>0)
        {
            //get floor Routes dotted Line
            if(data[1][i].length >0 && destinationFID >= selectedFloorID)
            {      
                   
                floorRName[i] =Polyline(
                  polylineId:PolylineId(floorRoutesID[i]),
                  color: routesDColor,
                  width: routeWidth,
                  points: data[1][i],
                  patterns: [PatternItem.dot,PatternItem.gap(10)]
                );

                _polyline.add(floorRName[i]);
            }

        }
    }

    Polyline stair01;
    Polyline stair12;

    List<Polyline> stairName=[stair01,stair12];
    List<String> stairRID=["stair01","stair12"];
    //get dotted Line for Stair
    for(int i=0;i<2;i++)
    {
        if(flageStar[i]>0)
        {
            if(data[2][i].length>0 && destinationFID >= selectedFloorID)
            {
                 stairName[i]=Polyline(
                  polylineId:PolylineId(stairRID[i]),
                  color:stairDColor,
                  width: stairWidth,
                  points:data[2][i],
                  patterns: [PatternItem.dot,PatternItem.gap(10)] );

                _polyline.add(stairName[i]);
            }
           
        }
    }

    finaldata.add(_polyline);
    finaldata.add(_marker);

    return finaldata;


}


