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
        Text(
          "WELCOME",
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height/20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
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
        //Image.asset('assets/images/0.png'),
        ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height*0.8,
            width: MediaQuery.of(context).size.width*0.8,
            decoration: BoxDecoration(
              //image: DecorationImage(image: AssetImage('assets/images/0.png'),fit: BoxFit.cover),
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(25.0),
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
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
                  child: Column(
                    children: <Widget>[  
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "UOR",
                            style: TextStyle(
                              //backgroundColor: Colors.lightBlue,
                              fontSize: MediaQuery.of(context).size.height / 20,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "NAVIGATION",
                            style: TextStyle(
                              //backgroundColor: Colors.lightBlue,
                              fontSize: MediaQuery.of(context).size.height / 20,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "SYSTEM",
                            style: TextStyle(
                              //backgroundColor: Colors.lightBlue,
                              fontSize: MediaQuery.of(context).size.height / 20,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                buildLoginButton(),
                buildSignUpButton(),
                buildGuestButton(),
                //SpinKitDualRing(color: Colors.green,size: 40.0,),
              ],
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
        Container(
          height: 1.4 * (MediaQuery.of(context).size.height / 20),
          width: 5 * (MediaQuery.of(context).size.width /10),
          margin: EdgeInsets.only(bottom: 20),
          child: RaisedButton(
            elevation: 5.0,
            color: firstColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            onPressed: () =>
                /*_scafflodKey.currentState.showSnackBar(
                  SnackBar(duration: Duration(seconds: 4),
                  backgroundColor: firstColor,
                  content: Row(
                    children: <Widget>[
                      CircularProgressIndicator(),
                      Text(" Sign-In...")
                    ],
                  ),
                  ));
                  Login().whenComplete(() => Navigator.of(context).pushNamed("/login_page"),);*/
                  /*final snackBar = SnackBar( 
                    duration: Duration(seconds: 4),
                  content: Row(
                    children: <Widget>[
                      CircularProgressIndicator(),
                      Text(" Sign-In...")
                    ],
                  ),
                  action: SnackBarAction(label: 'shh', onPressed: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context) => Login()));
                  }),
                );
                Scaffold.of(context).showSnackBar(snackBar);*/
                _handleSubmitlogin(context),
              
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
      ],
    );
  }
  Widget buildSignUpButton()
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 1.4 * (MediaQuery.of(context).size.height / 20),
          width: 5 * (MediaQuery.of(context).size.width /10),
          margin: EdgeInsets.only(bottom: 20),
          child: RaisedButton(
            elevation: 5.0,
            color: firstColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
           onPressed: () => 
              /*Navigator.push(context, 
                PageTransition(
                  type: PageTransitionType.topToBottom, 
                  child: SignUp(),
                  duration: Duration(microseconds: 400),
                 ),
                ),*/
                _handleSubmitsignup(context),
              
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
      ],
    );
  }

  Widget buildGuestButton()
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 44.0,
          padding: EdgeInsets.zero,
          margin: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
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
            child: Text("Log in as a guest",
              textAlign: TextAlign.center,
              style: TextStyle(
                //decoration: TextDecoration.underline,
                fontSize: 18.0,
                color: tridColor,
              ),
            ),
          ),
        )
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

