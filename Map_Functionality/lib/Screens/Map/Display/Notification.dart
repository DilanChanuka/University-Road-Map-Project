

import 'package:flutter/material.dart';  
import 'package:fluttertoast/fluttertoast.dart';
import 'package:map_interfaces/Screens/Common/data.dart';


void showMessage(int placeid)
{
    String floorName=getFloorName(placeid);
    if(floorName.length>0)
    {
        Fluttertoast.showToast(
          msg:" Your destination floor is \n "+floorName ,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP_LEFT,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.amber,
          textColor: Colors.black );
    }

}

void showGetPlaceMessage(int floorid)
{

    String floorname=floorName(floorid);
    if(floorname.length>0)
    {
        Fluttertoast.showToast(
          msg:" Your destination floor is \n "+floorname ,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP_LEFT,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.amber,
          textColor: Colors.black );
    }

}

void  message(String message)
{
   
   
        Fluttertoast.showToast(
          msg:" Your destination is \n "+message ,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP_LEFT,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.amber,
          textColor: Colors.black );
    

}

Future<void> alertBox(BuildContext context) async
{

      
}

String getFloorName(int placeid)
{
    String name="";
    if(firstFloor.contains(placeid))
        name="First Floor";
    else if(secondFloor.contains(placeid))
        name="Second Floor";
    else
        name="Ground Floor";

    return name;
}

String floorName(int floorid) //get floor name using floor id (0 /1 /2)
{
    String name="";
    if(floorid==1)
        name="First Floor";
    else if(floorid==2)
        name="Second Floor";
    else
        name="Ground Floor";

    return name;
}