
import 'package:location/location.dart';
import 'package:map_interfaces/Screens/Common/data.dart';
import 'package:map_interfaces/Screens/Request/Location_shearing.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

Location location1 =new Location();
double lat=0.0,lng=0.0;
double speed=0.0;

List<double> userCurrentLocation=new List<double>();
List<double> data=new List<double>();
//Timer _timer;

const timeout = const Duration(seconds: 20);
const ms = const Duration(milliseconds: 100);

void getUserRealTimeLocation() async
{
      String url="";
      bool _serviceEnabled, _changeSetting;
      PermissionStatus _permissionGranted;
      

      _serviceEnabled=await location1.serviceEnabled();

      if(!_serviceEnabled)
      {
          _serviceEnabled=await location1.requestService();
          if(!_serviceEnabled){

          }
                
      }

      _permissionGranted=await location1.hasPermission();
      if(_permissionGranted ==PermissionStatus.denied)
        {
              _permissionGranted=await location1.requestPermission();
              if(_permissionGranted!=PermissionStatus.granted){
                
              }
                    
        }

        _changeSetting=await location1.changeSettings();
    
        
        //Get user Current location
        if (_changeSetting)
        {
             location1.onLocationChanged.listen((LocationData currentLocation) 
             {       
                lat = currentLocation.latitude;
                lng = currentLocation.longitude;
                data.add(lat);
                data.add(lng);
                url=getuserLocationRequest(data,user);

                sendRequest(url);
             });   
              
        }

      
}

 startTimeout([int milliseconds]) 
 {
     var duration = milliseconds == null ? timeout : ms * milliseconds;
         return new Timer(duration, getUserRealTimeLocation);  
 }

void sendRequest(String address)async
{
    try
    {
        var data=await http.get(address);
        if(data.statusCode==200){

        }

    }
    catch(error){
      print(error);
    }
   
}