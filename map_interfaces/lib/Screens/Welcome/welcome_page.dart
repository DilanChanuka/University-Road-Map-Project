import 'package:map_interfaces/Screens/Map/log_guest_map.dart';
import 'package:map_interfaces/Screens/Signup/signup_page.dart';
import 'package:map_interfaces/page_tran.dart';
import 'package:flutter/material.dart';
import 'package:map_interfaces/Screens/Login/login_page.dart';
import 'package:map_interfaces/constanents.dart';

class WelcomePage extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackcolor,
      resizeToAvoidBottomPadding: false,
      body: WBody(),
    );
  }
}
class WBody extends StatefulWidget
{
  @override
  _WelcomePageState createState() => _WelcomePageState();
}
class _WelcomePageState extends State<WBody>
{
  final GlobalKey<ScaffoldState> _scafflodKey = GlobalKey<ScaffoldState>();

   Widget _buildLogo(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SingleChildScrollView(
          child: Text(
            "WELCOME",
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height/20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
  @override
  Widget build(BuildContext context)
  {
    return SafeArea( 
      child: Scaffold(
        key: _scafflodKey,
        resizeToAvoidBottomPadding: false,
        backgroundColor: mainColor,
        body: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height*0.7,
              width: MediaQuery.of(context).size.width,
              child: Container(
                decoration: BoxDecoration(
                  color: firstColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: const Radius.circular(70),
                    bottomRight: const Radius.circular(70),
                  ),
                ),
              ),  
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildLogo(),
                  _buildContainer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
   Widget _buildContainer()
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SingleChildScrollView(
          child: ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(MediaQuery.of(context).size.height / 30),
            ),
            child: Container(
              height: MediaQuery.of(context).size.height*0.8,
              width: MediaQuery.of(context).size.width*0.8,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.all(MediaQuery.of(context).size.height / 30),
                      padding: EdgeInsets.all(MediaQuery.of(context).size.height / 30),
                      decoration: BoxDecoration(
                        /*boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.6),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],*/
                        //color: mainColor,
                        border: Border.all(),
                      ),
                      child: Column(
                        children: <Widget>[ 

                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SingleChildScrollView(
                                child: Text(
                                  "UOR",
                                  style: TextStyle(
                                    //backgroundColor: Colors.lightBlue,
                                    fontSize: MediaQuery.of(context).size.height / 20,
                                    color: tridColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SingleChildScrollView(
                                child: Text(
                                  "NAVIGATION",
                                  style: TextStyle(
                                    //backgroundColor: Colors.lightBlue,
                                    fontSize: MediaQuery.of(context).size.height / 20,
                                    color: tridColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SingleChildScrollView(
                                child: Text(
                                  "SYSTEM",
                                  style: TextStyle(
                                    //backgroundColor: Colors.lightBlue,
                                    fontSize: MediaQuery.of(context).size.height / 20,
                                    color: tridColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                  buildLoginButton(),
                  buildSignUpButton(),
                  buildGuestButton(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
  Widget buildLoginButton()
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SingleChildScrollView(
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
            height: 1.4 * (MediaQuery.of(context).size.height / 20),
            width: 5 * (MediaQuery.of(context).size.width /10),
            margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 30),
            child: RaisedButton(
              elevation: 5.0,
              color: firstColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height / 30),
              ),
              onPressed: () =>
                  _handleSubmitlogin(context),
              child: SingleChildScrollView(
                child: Text(
                  "LOGIN",
                    style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 1.5,
                      fontSize: MediaQuery.of(context).size.height / 40,
                    ),
                  ),
              ),
          ),
          ),
        ),
      ],
    );
  }
  Widget buildSignUpButton()
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SingleChildScrollView(
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
            height: 1.4 * (MediaQuery.of(context).size.height / 20),
            width: 5 * (MediaQuery.of(context).size.width /10),
            margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 30),
            child: RaisedButton(
              elevation: 5.0,
              color: firstColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height / 30),
              ),
            onPressed: () => 
                  _handleSubmitsignup(context),
              child: SingleChildScrollView(
                child: Text(
                  "SIGNUP",
                    style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 1.5,
                      fontSize: MediaQuery.of(context).size.height / 40,
                    ),
                  ),
              ),
          ),
          ),
        ),
      ],
    );
  }

  Widget buildGuestButton()
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height / 15,
            padding: EdgeInsets.zero,
            margin: EdgeInsets.all(MediaQuery.of(context).size.height / 30),
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
              color: mainColor,
              border: Border.all(),
            ),
            child:  FlatButton(
              onPressed: ()=> _handleSubmitguest(context),
              child: SingleChildScrollView(
                child: Text("Log in as a guest",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    //decoration: TextDecoration.underline,
                    fontSize: MediaQuery.of(context).size.height / 40,
                    color: blackcolor,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  
  Future<void> _handleSubmitsignup(BuildContext context) async{
    try{
      Dialogs.showLoadingDialog(context,_keyLoader);
      //await serivce.login(user.uid);
      //Future.delayed(Duration(seconds: 3,));
      await Future.delayed(Duration(seconds: 3,));
      Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();

      Navigator.push(context,MaterialPageRoute(builder: (context) => SignUp()));
    }
    catch(error){
      print(error);
    }
  }

   Future<void> _handleSubmitlogin(BuildContext context) async{
    try{
      Dialogs.showLoadingDialog(context,_keyLoader);
      await Future.delayed(Duration(seconds: 3,));
      Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();

      Navigator.push(context,MaterialPageRoute(builder: (context) => Login()));
    }
    catch(error){
      print(error);
    }
  }

  Future<void> _handleSubmitguest(BuildContext context) async{
    try{
      Dialogs.showLoadingDialog(context,_keyLoader);
      await Future.delayed(Duration(seconds: 3,));
      Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();

      Navigator.push(context,MaterialPageRoute(builder: (context) => LogGuest()));
    }
    catch(error){
      print(error);
    }
  }
}

