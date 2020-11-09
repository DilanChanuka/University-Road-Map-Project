import 'package:uor_road_map/Screens/Request/ConvertData.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uor_road_map/Screens/Common/data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


  //2d array is lat and lng
  List<List<LatLng>> getplaceinOut(int deptId,int floorId,List<List<double>> array,int selectedfloorId)//Request a outside Place from inside
  {
          //start and destinationa location come from array 
        String deptID=deptId.toString();
        String floorID=floorId.toString();
        String sourcelat=array[0][0].toString();
        String sourcelng=array[0][1].toString();
        String destlat=array[1][0].toString();
        String destlng=array[1][1].toString();

        String url=port+"/getplaceinout/"+deptID+"/"+floorID+"/"+sourcelat+"/"+sourcelng+"/"+destlat+"/"+destlng+"";
        
        Future<String> path=Future(()=>jsondata(url));
        String fpath;
        path.then((value) { 
          fpath=value;
        });
        
        //get data from server (3 json array from )
        //String path1='{"floor_0_locations":[[1.125896,10.258964],[1.458963,52.489653],[1.125896,82.258964],[1.458963,2.489653]],"outerroutelocations":[[1.125896,10.258964],[1.458963,52.489653],[1.125896,82.258964],[1.458963,2.489653]],"innerroutelocations":[[7.467066, 81.012821],[7.467410, 81.017642],[7.466966, 81.018871],[7.467816, 81.019546]]}';
    return drawplaceout(fpath,selectedfloorId,floorId);

  } 

  List<dynamic> getplaceInIn(int deptID,int floorID,int destinationID,List<double> array,int selectedfloorId) //Request a inside Place from inside
  {
        String sourcelat=array[0].toString();
        String sourcelng=array[1].toString();
        String deptId=deptID.toString();
        String floorId=floorID.toString();
        String destinationId=destinationID.toString();

        String url=port+"/getplaceinin/"+deptId+"/"+floorId+"/"+sourcelat+"/"+sourcelng+"/"+destinationId+"";
        Future<String> path=Future(()=>jsondata(url));

        String fpath;
        path.then((value) { 
          fpath=value;
        });

       return drawplaceinin(fpath,selectedfloorId,destinationID,floorID);
  }

  List<dynamic> getfloor(int deptID,int floorID)  //done
  {
          String deptId=deptID.toString();
          String floorId=floorID.toString();

          String url=port+"/getfloor/"+deptId+"/"+floorId+"";
          Future<String> path=Future(()=>jsondata(url));
           String fpath;
          path.then((value) { 
          fpath=value;
          });
          //2 json array from server
      return drawfloor(fpath,2);
          
  }

  List<dynamic> getplace(List<double> array,int placeID,String vORf,int selectedfloorID)  //done
  {
          String sourcelat=array[0].toString();
          String sourcelng=array[1].toString();
          String placeId=placeID.toString();

          String url=port+"/getplace/"+sourcelat+"/"+sourcelng+"/"+placeId+"/"+vORf+"";
          Future<String> path=Future(()=>jsondata(url));
          String fpath;
          path.then((value) { 
            fpath=value;
         });
      return drawplace(fpath,selectedfloorID);  // 10 json array from server
  }

  List<LatLng> getroute(List<List<double>> array ,String vORf) //done
  {
        //start and destinationa location come from array 
        String sourcelat=array[0][0].toString();
        String sourcelng=array[0][1].toString();
        String destlat=array[1][0].toString();
        String destlng=array[1][1].toString();

        String url=port+"/getroute/"+sourcelat+"/"+sourcelng+"/"+destlat+"/"+destlng+"/"+vORf+"";

        Future<String> path=Future(()=>jsondata(url));
        String fpath;
        path.then((value) { 
          fpath=value;
        });
     return drawroute(fpath);  //get data from server (1 json array )
  }
   
   List<dynamic> getfloorwithplace(int placeID)
  {
      String id=placeID.toString();
      String url=port+"/getfloorwithplace/"+id+"";
      Future<String> path=Future(()=>jsondata(url));
      String fpath;
      path.then((value) {
        fpath=value;
      });

      return drawfloorWplace(fpath);
  }

  Future<String> jsondata(String url) async
  {
      var data=await http.get(url);
      String jsonresponse=json.decode(data.body);

      return jsonresponse;
  }


  
