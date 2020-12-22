import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_interfaces/Screens/Common/data.dart';
import 'dart:async';
import 'package:map_interfaces/constanents.dart';
import 'package:map_interfaces/Screens/Map/Logic/getOuterRoutes.dart';
import 'package:map_interfaces/Screens/Map/Display/Notification.dart';
import 'package:map_interfaces/Screens/Search/search_page.dart';
import 'package:map_interfaces/page_tran.dart';
import 'package:map_interfaces/Screens/Profile/PrifilePage.dart';
import 'package:map_interfaces/Screens/Map/Display/Display_SideBar.dart';


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
    location=getOuterRoutes(data1,_selectedFloor.id,sAend);
    if(_selectedFloor.id!=0)
          message("Outer..");

  });
}

  static LatLng _center =LatLng(camaraLocation[0],camaraLocation[1]);
  final Set<Marker> _markers = {};
  LatLng _lastMapPosition = _center;
  MapType _currentMapType = MapType.normal;

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
               child: Align(
                 alignment: Alignment.topLeft,
                 child: Column(
                   children: [
                     RaisedButton(
                      
                      onPressed:(){},
                      child: Text(data1[1][1].toString()+"min("+data1[1][0].toString()+"m)"),
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




}

