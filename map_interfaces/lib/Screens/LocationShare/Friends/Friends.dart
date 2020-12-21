import 'package:flutter/material.dart';
import 'package:map_interfaces/Screens/LocationShare/DummyData.dart';
import '../../../constanents.dart';

class Friends extends StatefulWidget {
  @override
  _FriendsState createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: dummyFriends.length,
        itemBuilder: (BuildContext contxt,int i) => Column(
          children: <Widget>[
            Divider(
              height: 20.0,
              color: colorborder,
              thickness: 1.0,
            ), 
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SingleChildScrollView(
                    physics: ClampingScrollPhysics(),
                    child: Text(dummyFriends[i].name,
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
                        border: Border.all(color: colorgreen),
                      ),
                      child: RaisedButton(
                        elevation: 5.0,
                        color: tridColor,
                        /*shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height / 30),
                        ),*/
                        onPressed: (){
                          setState(() {
                            dummyFriends.removeAt(i);
                          });
                        },
                        child: Text("Remove",
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
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SingleChildScrollView(
                    physics: ClampingScrollPhysics(),
                    child: Text(dummyFriends[i].faculty,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 25,
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    physics: ClampingScrollPhysics(),
                    child: Text(dummyFriends[i].type,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 25,
                        color: blackcolor,
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