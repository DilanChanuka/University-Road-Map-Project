import 'package:flutter/material.dart';
import 'package:map_interfaces/Screens/LocationShare/DummyData.dart';
import 'package:map_interfaces/constanents.dart';

class AddFriends extends StatefulWidget {
  @override
  _AddFriendsState createState() => _AddFriendsState();
}

class _AddFriendsState extends State<AddFriends> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: dummyAddFriends.length,
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
                    child: Text(dummyAddFriends[i].name,
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
                      width: (MediaQuery.of(context).size.width * 0.2),
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
                        border: Border.all(color: clrblue),
                      ),
                      child: RaisedButton(
                        elevation: 5.0,
                        color: firstColor,//dummyAddFriends[i].pressed == false ? firstColor : tridColor,
                        /*shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height / 30),
                        ),*/
                        onPressed: (){
                          setState(() {
                            /*if(dummyAddFriends[i].pressed == false){
                              dummyAddFriends[i].pressed = true;
                            }
                            else{
                              dummyAddFriends[i].pressed = false;
                            }*/
                            dummyAddFriends.removeAt(i);
                          });
                        },
                        child: Text("Add",
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