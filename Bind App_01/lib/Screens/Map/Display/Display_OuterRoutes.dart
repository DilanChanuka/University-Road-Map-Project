import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_interfaces/Screens/Common/data.dart';
import 'package:map_interfaces/Screens/Direction/Direction_page.dart';
import 'package:map_interfaces/Screens/Map/Function/GetUser_Location.dart';
import 'dart:async';
import 'package:map_interfaces/constanents.dart';
import 'package:map_interfaces/Screens/Map/Logic/getOuterRoutes.dart';
import 'package:map_interfaces/Screens/Map/Display/Notification.dart';
import 'package:map_interfaces/Screens/Search/search_page.dart';
import 'package:map_interfaces/page_tran.dart';
import 'package:map_interfaces/Screens/Profile/PrifilePage.dart';
import 'package:map_interfaces/Screens/Map/Display/Display_SideBar.dart';
import 'package:map_interfaces/Screens/Map/Display/Display_2User_Path.dart';
import 'package:map_interfaces/Screens/Request/JsonBody.dart';
import 'package:map_interfaces/Screens/Request/ConvertData.dart';
import 'package:map_interfaces/Screens/Map/Function/RealTimeULoc.dart';
import 'package:map_interfaces/Screens/Request/Location_shearing.dart';


const String KEY=GOOGL_KEY;
const double CAMERA_ZOOM = 17.5;
const double CAMERA_TILT = 0;
const double CAMERA_BEARING = 30;

List<dynamic> location;
//0=>polyline
//1=>marker

List<dynamic> data1;
List<dynamic> sAend;
List<double> camaraLocation=new List<double>();
int floorID=0;

BitmapDescriptor sourceIcon;
BitmapDescriptor destinationIcon;

class DrawRouteLine extends StatefulWidget
{


  DrawRouteLine(List<dynamic> data,List<dynamic> startAend)
  {   

      sAend=startAend;
      camaraLocation.insert(0,data[0][0].latitude);
      camaraLocation.insert(1,data[0][0].longitude);
      data1=data;
      location=getOuterRoutes(data,0,startAend);
  }

  final String txt= "UOR";
  @override
  
  State<StatefulWidget> createState(){
        return _DrawState();
  }

}
class Floor
{
  int id;
  String name;

  Floor(this.id,this.name);

  static List<Floor> getFloor(){
    return <Floor>[
    
      Floor(0, 'Ground Floor'),
      Floor(1, 'First Floor'),
      Floor(2, 'Second Floor'),
    ];
  
    

  }
}
class _DrawState extends State<DrawRouteLine>
{
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  List<Floor> _floor = Floor.getFloor();
  List<DropdownMenuItem<Floor>> _dropdownMenuitem;
  Set<Marker> _realtimeMarker={};
  Floor _selectedFloor; 

  GoogleMapController mapcontroller;
  Completer<GoogleMapController> _controller=Completer();
    
    //for my custom icon
    BitmapDescriptor sourceIcon;
    BitmapDescriptor destinationIcon;

  
    String key=KEY;

   void customMapPing() async{
      sourceIcon =await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/destination_PIn.png');

      destinationIcon=await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5,size: Size(0.5, 0.5)),
        'assets/userPin.png');
    }
     
    void _onMapCreated(GoogleMapController controller)
    {
        _controller.complete(controller);   
    }

    

@override
void initState()
{
  _dropdownMenuitem = buildDropdownMenuItems(_floor).cast<DropdownMenuItem<Floor>>();
  _selectedFloor = _dropdownMenuitem[floorID].value;
  customMapPing();
  super.initState();
  
}

List<DropdownMenuItem<Floor>> buildDropdownMenuItems(List floors){
  List<DropdownMenuItem<Floor>> items = List();
  for(Floor floor in floors){
    items.add(
      DropdownMenuItem(
        value: floor, // have to change default selected floor value acoding to relevent floor
	////////////////////////////////////////////////////////////////////////////////////////////////
        child: Container(
          width: 110.0,
          height: 30.0,
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.0), ),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.6),
                spreadRadius: 2,
                blurRadius: 2,
                offset: Offset(0, 3),
              ),
            ],
            color: tridColor,
            border: Border.all(color: blackcolor),
          ),
          child: Text(floor.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: mainColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ///////////////////////////////////////////////////////////////////////////////////////////  
      ),
    );
  }

  return items;
}

onChangeDropdwonItem(Floor selectedFloor){
  setState(() 
  {
    _selectedFloor = selectedFloor;
    location=getOuterRoutes(data1,_selectedFloor.id,sAend);
    if(_selectedFloor.id!=0)
          message("Outer..");

  });
}

  static LatLng _center =LatLng(camaraLocation[0],camaraLocation[1]);
  final Set<Marker> _markers = {};
  LatLng _lastMapPosition = _center;
 // MapType _currentMapType = MapType.normal;

static CameraPosition initialLocation = CameraPosition(
    bearing: CAMERA_BEARING,
    target:LatLng(camaraLocation[0],camaraLocation[1]),
    tilt: CAMERA_TILT,
    zoom: CAMERA_ZOOM,
  );

  Future<void> _goToPosition() async{
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(initialLocation),);
  }


  _onCamMove(CameraPosition position)
  {
    _lastMapPosition = position.target;
  }

  _onlocationShereOuterRoutes(){

      //in this i have to tern on user location system
      startTimeout();
      List<dynamic> frendData=new List<dynamic>();
      List<dynamic> frendList=new List<dynamic>();
      String url=getFirendLocationRequest(user);
      Future<dynamic> myfuture=getjsonvalue(url);
      myfuture.then((jsonresponse) => {
            frendList=getUserLocations(jsonresponse),
            frendData.add(frendList),
            frendData.add(400),//this use for inform frend location 
            _loadingshireLocation(context,frendData),
      });

  }


  _onAddMarkerButtonPressed()
  {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId(_lastMapPosition.toString()),
        position: _lastMapPosition,
        infoWindow: InfoWindow(
          title: "Your posistion",
          //snippet: "snippet",
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }
   _onSearchButtonPress()
  {
      location.clear();
      data1.clear();
      Navigator.push(
        context,
        MaterialPageRoute(builder:(context)=>SearchPage()));

  }

  _onDirectionButtonPress()
  {
      location.clear();
      data1.clear();
      Navigator.pop(context);
  }

  Widget button(Function function,IconData icon)
  {
    return FloatingActionButton(
      heroTag: null,
      onPressed: function,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      backgroundColor: Colors.blue,
      child: Icon(
        icon,
        size: 36.0,
      ),
      );
  }
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      home: Scaffold(    
          
        appBar: AppBar(
          title: Text(widget.txt,
          style: TextStyle(
            color: Colors.white,
          ),
          ),
          backgroundColor: firstColor,
          actions: <Widget>[
             SizedBox(width: 60.0,),
               DropdownButton(
		  dropdownColor: Colors.transparent,//////////////////////////////////////////////////////////////////////
                  iconSize: 25.0,
                  iconEnabledColor: mainColor,
                  value: _selectedFloor,
                  items: _dropdownMenuitem, 
                  onChanged: onChangeDropdwonItem,
                  ),
          ],
        ),
        drawer:getSideBar(context, _keyLoader),
       
        body: Stack(
          children: <Widget>[
            
            Container(
              child:
              GoogleMap(                
                onMapCreated: _onMapCreated,
                initialCameraPosition:initialLocation,
                polylines:location[0],
                markers:location[1],             
                mapType: MapType.normal,
                onCameraMove: _onCamMove,
                myLocationButtonEnabled: true,

              ),
            ),
                     

              Container(
                padding: EdgeInsets.all(10.0),
                child: FractionallySizedBox(
                  widthFactor: 0.65,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: RaisedButton(
                      onPressed:null,
                      color: Colors.blue,
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children:<Widget> [
                          Icon(Icons.directions_walk,
                          color: Colors.white),
                          Text(data1[1][1].toString()+"min("+data1[1][0].toString()+"m)",
                          style: TextStyle(color: Colors.white),textScaleFactor: 1.3,),
                          

                        ],
                      ) , ),
                  ),
                ),
              ),
              
              Container(
                padding:EdgeInsets.all(16.0),
                child:Align(
                  alignment: Alignment.topRight,
                  child: Column(
                    children: <Widget>[
                     // button(_onLocationShereButtonPress(), Icons.person_pin),
                      button(_onlocationShereOuterRoutes,Icons.person_pin),
                      SizedBox(height: 16.0),

                      button(_goToPosition, Icons.location_searching),
                      SizedBox(height: 16.0,),

                      button(_onSearchButtonPress,Icons.search),
                      SizedBox(height: 16.0),

                      button(_onDirectionButtonPress,Icons.directions),
                      SizedBox(height: 16.0)
                    ],
                  ),
                ),
              )
            
            
          ],
        ),
      ),
    );
  }
  

      
    Future<void> _handleManageFriends(BuildContext context) async{
        try{
          Dialogs.showLoadingDialog(context,_keyLoader);
          await Future.delayed(Duration(seconds: 3,));
          Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();

         // Navigator.push(context,MaterialPageRoute(builder: (context) => Managefriends()));
        }
        catch(error){
          print(error);
        }
      }

      Future<void> _handleSetProfile(BuildContext context) async{
        try{
          Dialogs.showLoadingDialog(context,_keyLoader);
          await Future.delayed(Duration(seconds: 3,));
          Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();

          Navigator.push(context,MaterialPageRoute(builder: (context) => ProfilePage()));
        }
        catch(error){
          print(error);
        }
      }
    
     Future<void> _handleSubmitwelcome(BuildContext context) async{
    try{
      Dialogs.showLoadingDialog(context,_keyLoader);
      await Future.delayed(Duration(seconds: 3,));
      Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();

      //Navigator.push(context,MaterialPageRoute(builder: (context) => WelcomePage()));
    }
    catch(error){
      print(error);
    }
  }


  Future<void> _loadingshireLocation(BuildContext context,List<dynamic> firends) async{
    try{
      Dialogs.showLoadingDialog(context,_keyLoader);
      await Future.delayed(Duration(seconds: 3,));
      Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();

      Navigator.push(context,MaterialPageRoute(builder: (context) => Get2UserPath(firends)));
    }
    catch(error){
      print(error);
    }
  }




}

