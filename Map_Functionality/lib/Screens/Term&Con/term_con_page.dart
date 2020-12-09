import 'package:map_interfaces/page_tran.dart';
import 'package:flutter/material.dart';
import 'package:map_interfaces/Screens/Signup/signup_page.dart';
import 'package:map_interfaces/constanents.dart';

class TCPage extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: blackcolor,
        primaryColor: Colors.white,
      ), 
      home: TCBody(),
    );
  }
}
class TCBody extends StatefulWidget
{
  @override
  _TermConPageState createState() => _TermConPageState();
}
class _TermConPageState extends State<TCBody>
{
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            backgroundColor: firstColor,
            title: Text("Terms and Conditions",
            style: TextStyle(
              fontSize: 20.0
              ),
            ),
            leading: IconButton(icon: Icon(
              Icons.arrow_back,
              size: 30.0,
              color: mainColor,
            ),
             onPressed: () =>
               _handleSubmitsign(context),
             ),
          ),
          body: Container(
            child: SingleChildScrollView(
            //margin: EdgeInsets.all(10.0),
            //width: 370,
              child: Text("Texting!!!!!!!!!!!!!!!!!!!!!!!!",
              overflow: TextOverflow.ellipsis,
              maxLines: 200,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height / 40,
                ),
              ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleSubmitsign(BuildContext context) async{
    try{
      Dialogs.showLoadingDialog(context,_keyLoader);
      await Future.delayed(Duration(seconds: 3,));
      Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();

      Navigator.push(context,MaterialPageRoute(builder: (context) => SignUp()));
    }
    catch(error){
      print(error);
    }
  }
}