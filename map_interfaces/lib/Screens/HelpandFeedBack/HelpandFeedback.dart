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
  TextEditingController name = TextEditingController();
  TextEditingController mess = TextEditingController();

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
        body: SingleChildScrollView(
          child: buildBody(),
        ),
      ),
    );
  }
  Widget buildName()
  {
    return SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height / 12,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.6),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
              color: colorwhite,
              border: Border.all(color: colorborder),
            ),
            child: SingleChildScrollView(
            child: TextField(
              controller: name,
              maxLines: 1,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(3),
                border: InputBorder.none,
                hintText: "Name",
                hintStyle: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 22,
                ),   
              ),
            ),
          ),
          ),
    );
  }
  Widget _buildMessage()
  {
    return SingleChildScrollView(        
      child: Container(
        height: MediaQuery.of(context).size.height * 0.35,
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
          boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.6),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
          ],
            color: colorwhite,
            border: Border.all(color: colorborder),
        ),
          child: SingleChildScrollView(
            child: TextField(
              controller: mess,
              maxLines: 10,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(3),
                border: InputBorder.none,
                hintText: "Please briefly describe the issue",
                hintStyle: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 22,
                ),   
              ),
            ),
          ),
      ),
    );
  }
  Widget buildSendButton()
  {
    return SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.height / 30)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.6),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            height: (MediaQuery.of(context).size.height / 12),
            width: 5 * (MediaQuery.of(context).size.width /10),
            child: RaisedButton(
              elevation: 5.0,
              color: firstColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height / 30),
              ),
              onPressed: () => { },
              child: SingleChildScrollView(
                child: Text(
                  "Send",
                  style: TextStyle(
                    color: mainColor,
                    letterSpacing: 1.5,
                    fontSize: MediaQuery.of(context).size.width / 20,
                  ),
                ),
              ),
            ),
          ),
    );
  }
  Widget buildBody()
  {
    return SingleChildScrollView(
        child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    SizedBox(height: MediaQuery.of(context).size.height / 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.height / 30)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.6),
                                spreadRadius: 2,
                                blurRadius: 3,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: SingleChildScrollView(
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(MediaQuery.of(context).size.height / 30),
                              ),
                              child: Container(
                                height: MediaQuery.of(context).size.height * 0.17,
                                width: MediaQuery.of(context).size.width * 0.96,
                                decoration: BoxDecoration(
                                  color: mainColor,
                                ),
                                  child: Container(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        buildName(),
                                      ],
                                    ),
                                  ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height / 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.height / 30)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.6),
                                spreadRadius: 2,
                                blurRadius: 3,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: SingleChildScrollView(
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(
                              Radius.circular(MediaQuery.of(context).size.height / 30),
                            ),
                            child: Container(
                            height: MediaQuery.of(context).size.height * 0.40,
                            width: MediaQuery.of(context).size.width * 0.96,
                            decoration: BoxDecoration(
                              color: mainColor,
                            ),
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    _buildMessage(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height / 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.height / 30)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.6),
                                spreadRadius: 2,
                                blurRadius: 3,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: SingleChildScrollView(
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(MediaQuery.of(context).size.height / 30),
                              ),
                              child: Container(
                                height: MediaQuery.of(context).size.height * 0.17,
                                width: MediaQuery.of(context).size.width * 0.96,
                                decoration: BoxDecoration(
                                  color: mainColor,
                                ),
                                  child: Container(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        buildSendButton(),
                                      ],
                                    ),
                                  ),
                              ),
                            ),
                          ),
                        ),
                      ],
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