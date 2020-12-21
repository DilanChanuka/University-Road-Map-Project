import 'package:flutter/material.dart';
import '../../../constanents.dart';
import '../DummyData.dart';

class FriendsRequests extends StatefulWidget {
  @override
  _FriendsRequestsState createState() => _FriendsRequestsState();
}

class _FriendsRequestsState extends State<FriendsRequests> {
  @override
  Widget build(BuildContext context) {
    return Container( 
      child: ListView.builder(
        itemCount: dummyFriendsreq.length,
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
                    child: Text(dummyFriendsreq[i].name,
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
                          setState(() {
                            dummyFriendsreq.removeAt(i);
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
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SingleChildScrollView(
                    physics: ClampingScrollPhysics(),
                    child: Text(dummyFriendsreq[i].faculty,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 25,
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    physics: ClampingScrollPhysics(),
                    child: Text(dummyFriendsreq[i].type,
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