import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_interfaces/Screens/Common/data.dart';
import 'package:map_interfaces/Screens/Search/search_page.dart';
import 'dart:async';
import 'package:map_interfaces/constanents.dart';
import 'package:map_interfaces/Screens/Map/Logic/getplace.dart';
import 'package:map_interfaces/Screens/Map/Display/Notification.dart';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:map_interfaces/Screens/Map/Display/Display_SideBar.dart';




const String KEY=GOOGL_KEY;
const double CAMERA_ZOOM = ZOOM;
const double CAMERA_TILT = 0;
const double CAMERA_BEARING = 30;

List<dynamic> geolocationPlace;
//0=> polyline
//1=.marker
List<dynamic> alldata1;
    //0=>floor location
    //1=> required place
    //2=>relevent places
    //3=>relevent floor
List<dynamic> googlepolyline=new List<dynamic>();
    //0=>curret location
    //1=>google map polyline
int floorID=0;
int destinationFID;
int mapchoice;  // 0 or 1
int selectedfloorID;
BitmapDescriptor destLocation;
BitmapDescriptor userLocation;

class DrawPlace extends StatefulWidget
{

  DrawPlace(List<dynamic> data,List<dynamic> allresponse)
  {
      alldata1=data;
      destinationFID=allresponse[1];
      if(allresponse[0]!=0)
          googlepolyline=allresponse[2];
      mapchoice=allresponse[3];
      selectedfloorID=allresponse[0];
      //in here selected floorID can be empty.then will have to select destination floorID
       //geolocation=getplace(data,destFloorID);
      if(selectedfloorID==0)
      {
          floorID=destinationFID;
          geolocationPlace=getplace(data,destinationFID,destinationFID,googlepolyline,mapchoice);
      }      
      else
      {
          floorID=selectedfloorID;
          geolocationPlace=getplace(data,selectedfloorID,destinationFID,googlepolyline,mapchoice);

      }  

      if(selectedfloorID!=destinationFID)
                showGetPlaceMessage(destinationFID);
         
      
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
class _DrawState extends State<DrawPlace>
{

  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  List<Floor> _floor = Floor.getFloor();
  List<DropdownMenuItem<Floor>> _dropdownMenuitem;
  Floor _selectedFloor; 

  GoogleMapController mapcontroller;
  Completer<GoogleMapController> _controller=Completer();
  


    void _onMapCreated(GoogleMapController controller)
    {
        _controller.complete(controller);  
    }

@override
void initState()
{
  _dropdownMenuitem = buildDropdownMenuItems(_floor).cast<DropdownMenuItem<Floor>>();
  _selectedFloor = _dropdownMenuitem[floorID].value;


  getBytesFromAsset('assets/destination_PIn.png', 64).then((onValue){
      destLocation=BitmapDescriptor.fromBytes(onValue);
  });
  getBytesFromAsset('assets/userPin.png', 64).then((onValue){
      userLocation=BitmapDescriptor.fromBytes(onValue);
  });

  //customMapPing();
  super.initState();
}

 static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
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
    geolocationPlace.clear();
    geolocationPlace=getplace(alldata1,_selectedFloor.id,destinationFID,googlepolyline,mapchoice);

     if(_selectedFloor.id!=destinationFID)
                showGetPlaceMessage(destinationFID);
         
  });
}

  static LatLng _center =LatLng(alldata1[4][1],alldata1[4][2]);
  final Set<Marker> _markers = {};
  LatLng _lastMapPosition = _center;
  MapType _currentMapType = MapType.normal;

static CameraPosition initialLocation = CameraPosition(
    bearing: CAMERA_BEARING,
    target:LatLng(alldata1[4][1],alldata1[4][2]),
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
      Navigator.push(
        context,
        MaterialPageRoute(builder:(context)=>SearchPage()));
  }

  _onDirectionButtonPress() async
  {
        geolocationPlace.clear();
        alldata1.clear();
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
        
        drawer: getSideBar(context, _keyLoader),
        /*Drawer(
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

          */
        body: Stack(  
                 
          children: <Widget>[ 
           
            GoogleMap(
                
                onMapCreated: _onMapCreated,
                initialCameraPosition:initialLocation,
                polylines: geolocationPlace[0],
                markers:geolocationPlace[1],             
                mapType: MapType.normal,
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
                      child: Text(alldata1[5][1].toString()+"min("+alldata1[5][0].toString()+"m)"),
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