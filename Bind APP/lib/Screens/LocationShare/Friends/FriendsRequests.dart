import 'package:flutter/material.dart';
import 'package:map_interfaces/Screens/Map/Display/Notification.dart';
import '../../../constanents.dart';
import 'package:map_interfaces/Screens/Common/data.dart';
import 'package:map_interfaces/Screens/Request/Location_shearing.dart';
import 'package:map_interfaces/Screens/Request/Send_Request.dart';

List<dynamic> frendRequestList=new List<dynamic>();

class FriendsRequests extends StatefulWidget {

  FriendsRequests(List<dynamic> frends)
  {
     frendRequestList=frends;
     if(frends==null)
        frendRequestList=[];
  }

  @override
  _FriendsRequestsState createState() => _FriendsRequestsState();
}

class _FriendsRequestsState extends State<FriendsRequests> {
  @override
  Widget build(BuildContext context) {
    return Container( 
      child: ListView.builder(
        itemCount: frendRequestList.length,
        itemBuilder: (BuildContext contxt,int i) => Column(
          children: <Widget>[
            Divider(
              height: 10.0,
              color: colorborder,
              thickness: 1.0,
            ), 
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SingleChildScrollView(
                    physics: ClampingScrollPhysics(),
                    child: Text(frendRequestList[i],
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    physics: ClampingScrollPhysics(),
                    child: Container(
                      height: (MediaQuery.of(context).size.height / 20),
                      width: (MediaQuery.of(context).size.width * 0.3),
                      decoration: BoxDecoration(
                        //borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.height / 30)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.6),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                        border: Border.all(color: clrblue)
                      ),
                      child: RaisedButton(
                        elevation: 5.0,
                        color: firstColor,
                        /*shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height / 30),
                        ),*/
                        onPressed: (){

                          List<String> parm=[user,frendRequestList[i]];
                          String url=getConfiremFiredrequest(parm);
                          Future<bool> myfuture=sendRequest(url);

                          setState(() {
                            myfuture.then((value) => {
                              if(value){
                                  frendRequestList.removeAt(i),
                                  setMessage("Your Request Succesfull \n Updated.....!"),
                              }else
                                  setMessage("Unable To Aprove Your Request. \nPlease try Again..!"),                              
                            });
                          });
                        },
                        child: Text("Confirm",
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 1.5,
                            fontSize: MediaQuery.of(context).size.width / 22,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ), 
    );
  }
}