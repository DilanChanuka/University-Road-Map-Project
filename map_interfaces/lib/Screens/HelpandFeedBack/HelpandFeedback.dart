import 'package:flutter/material.dart';
import 'package:map_interfaces/Screens/Map/main_map.dart';
import '../../constanents.dart';
import '../../page_tran.dart';

class HelpandFeedBack extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: colorwhite,
        backgroundColor: firstColor,
      ),
      home: Body(),
    );
  }
}
class Body extends StatefulWidget{
  @override
  _Bodycreate createState() => _Bodycreate();
}
class _Bodycreate extends State<Body>{

  final GlobalKey<State> _keyLoader = GlobalKey<State>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: firstColor, 
          title: Text("Help and Feedback",
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width / 20,
            ),
          ), 
          leading: IconButton(icon: Icon(
            Icons.arrow_back,
            size: MediaQuery.of(context).size.width / 15,
            color: mainColor,
            ),
             onPressed: () {_handleMainPage(context);},
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.height / 200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //checkItems(),
              buildFeeedBackFrom(),
              SizedBox(
                height: MediaQuery.of(context).size.height / 100,
              ),
              //email(),
              Spacer(),
              SingleChildScrollView(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: FlatButton(
                        onPressed: (){},
                        color: firstColor, 
                        child: Text("SUBMIT",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: mainColor,
                            fontSize: MediaQuery.of(context).size.width / 20,
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
      ),
    );
  }
  /*Widget checkItems(){
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(MediaQuery.of(context).size.height / 60),
        width: MediaQuery.of(context).size.width * 0.9,
        padding: EdgeInsets.all(MediaQuery.of(context).size.height / 200),
        decoration: BoxDecoration(
          border: Border.all(color: colorborder,),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("Please select the type of feedback",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width / 20,
              ),
            ),
            buildCheckItem("Login trouble"),
            buildCheckItem("Personal profile"),
            buildCheckItem("Other issues"),
            buildCheckItem("Suggestions"),
          ],
        ),
      ),
    );
  }

  Widget buildCheckItem(title){
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(2),
        child: Row(
          children: <Widget>[
            Icon(Icons.check_circle, color: firstColor,),
            SizedBox(width: MediaQuery.of(context).size.width / 40,),
            Text(title,
              style: TextStyle(
                color: firstColor,
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.width / 22,
              ),
            ),
          ],
        ),
      ),
    );
  }*/
  Widget buildFeeedBackFrom(){
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height / 3,
        child: Stack(
          children: <Widget>[
            TextField(
              maxLines: 10,
              decoration: InputDecoration(
                hintText: "Please briefly describe the issue",
                hintStyle: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 25,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: colorborder,),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        width: 1.0,
                        color: colorborder,
                      ),
                    ),
                  ),
                  padding: EdgeInsets.all(MediaQuery.of(context).size.height / 120),
                  child: Row(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: colorborder,
                          borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height / 50),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(MediaQuery.of(context).size.height / 100,),
                          child: Icon(
                            Icons.add,
                            color: firstColor,
                            size: MediaQuery.of(context).size.width / 20,
                          ),
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width / 100,),
                      Text("Upload screenshot (optional)",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 25,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleMainPage(BuildContext context) async{
    try{
      Dialogs.showLoadingDialog(context,_keyLoader);
      await Future.delayed(Duration(seconds: 2,));
      Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();

      Navigator.push(context,MaterialPageRoute(builder: (context) => MainMap()));
    }
    catch(error){
      print(error);
    }
  }
}