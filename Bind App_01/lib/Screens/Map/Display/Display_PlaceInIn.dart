import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_interfaces/Screens/Common/data.dart';
import 'package:map_interfaces/Screens/Search/search_page.dart';
import 'dart:async';
import 'package:map_interfaces/constanents.dart';
import 'package:map_interfaces/Screens/Map/Logic/placeInIn.dart';
import 'package:map_interfaces/Screens/Map/Display/Notification.dart';
import 'package:map_interfaces/Screens/Map/Display/Display_SideBar.dart';
import 'package:map_interfaces/Screens/Map/Display/Display_2User_Path.dart';
import 'package:map_interfaces/Screens/Request/JsonBody.dart';
import 'package:map_interfaces/page_tran.dart';
import 'package:map_interfaces/Screens/Request/ConvertData.dart';
import 'package:map_interfaces/Screens/Map/Function/RealTimeULoc.dart';
import 'package:map_interfaces/Screens/Request/Location_shearing.dart';


const String KEY=GOOGL_KEY;
const double CAMERA_ZOOM = ZOOM;
const double CAMERA_TILT = 0;
const double CAMERA_BEARING = 30;

List<dynamic> geolocation;
//0=> polyline
//1=.marker
List<dynamic> alldata;
int floorID=0;
int destinationID;
int start;
String startFloorName;

BitmapDescriptor pinLocation;
BitmapDescriptor userLocation;

class DrawPlaceInIn extends StatefulWidget
{

  DrawPlaceInIn(List<dynamic> data,int destID,int startfloor,int selectedFloorID,int destfloorID,String startFName)
  {
      if(selectedFloorID==0)//if user not select floorID  ,then get destination floorID
      {
          floorID=destfloorID;
          startFloorName=startFName;
          geolocation=placeInIn(data, destID,startfloor,destfloorID,startFName);
      }     
      else
      {
        floorID=selectedFloorID;
        startFloorName=startFName;
        geolocation=placeInIn(data, destID,startfloor,selectedFloorID,startFName);
      }   

      if(selectedFloorID!=destfloorID)
              showMessage(destID);
       
      alldata=data;
      destinationID=destID;
      start=startfloor;
      
  }

 // DisplayPage() : super();

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
class _DrawState extends State<DrawPlaceInIn>
{
  List<Floor> _floor = Floor.getFloor();
  List<DropdownMenuItem<Floor>> _dropdownMenuitem;
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  Floor _selectedFloor; 

  GoogleMapController mapcontroller;
  Completer<GoogleMapController> _controller=Completer();
  
    

    void _onMapCreated(GoogleMapController controller)
    {
        _controller.complete(controller);  
    }

    void customMapPing() async{
      pinLocation =await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/destination_PIn.png');

      userLocation=await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5,size: Size(0.5, 0.5)),
        'assets/userPin.png');
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
        
      ),
    );
  }

  return items;
}

onChangeDropdwonItem(Floor selectedFloor){
  setState(() 
  {
    _selectedFloor = selectedFloor;
    geolocation.clear();
    geolocation=placeInIn(alldata,destinationID, start,_selectedFloor.id,startFloorName);

    if(destinationID!=_selectedFloor.id)
          showMessage(destinationID);
  });
}

  static LatLng _center =LatLng(alldata[1][0],alldata[1][1]);
  final Set<Marker> _markers = {};
  LatLng _lastMapPosition = _center;
  MapType _currentMapType = MapType.normal;

static CameraPosition initialLocation = CameraPosition(
    bearing: CAMERA_BEARING,
    target:LatLng(alldata[1][0],alldata[1][1]),
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


  _onLocationShereInIn()
  {

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
      geolocation.clear();
      alldata.clear();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context)=>SearchPage()));
  }

  _onDirectionButtonPress()
  {
      geolocation.clear();
      alldata.clear();
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
		              dropdownColor: Colors.transparent,
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

            GoogleMap(
                
                onMapCreated: _onMapCreated,
                initialCameraPosition:initialLocation,
                polylines: geolocation[0],
                markers:geolocation[1],             
                mapType: MapType.normal,
                onCameraMove: _onCamMove,
                myLocationButtonEnabled: true,

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
                          Text(alldata[3][1].toString()+"min("+alldata[3][0].toString()+"m)",
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
                      button(_onLocationShereInIn,Icons.person_pin),
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