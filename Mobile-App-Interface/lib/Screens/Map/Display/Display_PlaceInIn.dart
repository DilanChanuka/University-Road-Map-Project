import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_interfaces/Screens/Common/data.dart';
import 'package:map_interfaces/Screens/Disition/disistionFunc.dart';
import 'dart:async';
import 'package:map_interfaces/constanents.dart';
import 'package:map_interfaces/Screens/Map/Logic/placeInIn.dart';
import 'package:map_interfaces/Screens/Map/Display/Notification.dart';

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
        child: Text(floor.name,style: TextStyle(fontSize: 25.0),),
        
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

  _onMapTypeButtonPressed()
  {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal 
      ? MapType.satellite 
      : MapType.normal;
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

  }

  _onDirectionButtonPress()
  {
      
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
                  iconSize: 25.0,
                  iconEnabledColor: mainColor,
                  value: _selectedFloor,
                  items: _dropdownMenuitem, 
                  onChanged: onChangeDropdwonItem,
                  ),
          ],
        ),
       
        drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: Text("User Name"), 
                  accountEmail: Text("User Email"),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: mainColor,
                    child: Text("A"),
                  ),
                  decoration: BoxDecoration(
                    color: firstColor,
                  ),
                ),

                ListTile(
                  title: Text("Sign Out",style: TextStyle(fontSize: 18.0),),
                  leading: Icon(Icons.exit_to_app,color: blackcolor,), 
                  onTap: (){},
                ),

                ListTile(
                  title: Text("Profile",style: TextStyle(fontSize: 18.0),),
                  leading: Icon(Icons.person,color: blackcolor,),
                  onTap: (){},
                ),

                ListTile(
                  title: Text("Contacts",style: TextStyle(fontSize: 18.0),),
                  leading: Icon(Icons.contacts,color: blackcolor,),
                  onTap: (){},
                ),

                ListTile(
                  title: Text("Settings",style: TextStyle(fontSize: 18.0),),
                  leading: Icon(Icons.settings,color: blackcolor,),
                  onTap: (){},
                ),

                ListTile(
                  
                  title: Text("Help and feedback",style: TextStyle(fontSize: 20.0),),
                  leading: Icon(Icons.help,color: blackcolor,),
                  onTap: (){},           
                ),
                

              ],
            ),
          ),


        body: Stack(
          children: <Widget>[

            GoogleMap(
                
                onMapCreated: _onMapCreated,
                initialCameraPosition:initialLocation,
                polylines: geolocation[0],
                markers:geolocation[1],             
                mapType: _currentMapType,
                onCameraMove: _onCamMove,
                myLocationButtonEnabled: true,

              ),

              
              Container(
               padding: EdgeInsets.all(10.0),
               child: Align(
                 alignment: Alignment.topLeft,
                 child: Column(
                   children: [
                     RaisedButton(
                      onPressed:(){},
                      child: Text(alldata[3][1].toString()+"min("+alldata[3][0]+"m)"),
                      color: Colors.blue,)
                   ],
                 ),
                 ),
              ),
              
              
              Container(
                padding:EdgeInsets.all(16.0),
                child:Align(
                  alignment: Alignment.topRight,
                  child: Column(
                    children: <Widget>[
                      button(_onMapTypeButtonPressed(), Icons.map),
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
  
}