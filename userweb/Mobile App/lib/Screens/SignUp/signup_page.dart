import 'package:flutter/material.dart';
import 'package:uor_road_map/Screens/Login/login_page.dart';
import 'package:uor_road_map/constanents.dart';

class SignUp  extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SBody(),
    );
  }
}
class SBody extends StatefulWidget
{
    @override
  _SignUpPageState createState() => _SignUpPageState();
}
class _SignUpPageState extends State<SBody> 
{
  String username,password,email,id;
  bool checkB = false;
  Widget _buildLogo(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "UOR NAVIGATION MAP",
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height/25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
      ],
    );
  }
  Widget _buildUsernameRow() // user name 
  {
    return Padding(
      padding: EdgeInsets.all(8),
        child: TextFormField(
          keyboardType: TextInputType.name,
          onChanged: (value){
            setState(() {
              username = value;
            });
          },
          decoration: InputDecoration(
            prefixIcon: Icon(
                Icons.perm_identity,
                color: firstColor,
              ),
              labelText: "Username"
          ),
        ),
      );
  }
  Widget _buidemailRow() // user email
  {
    return Padding(
      padding: EdgeInsets.all(8),
        child: TextFormField(
          keyboardType: TextInputType.name,
          onChanged: (value){
            setState(() {
              email = value;
            });
          },
          decoration: InputDecoration(
            prefixIcon: Icon(
                Icons.email,
                color: firstColor,
              ),
              labelText: "Email"
          ),
        ),
      );
  }
  Widget _buildPasswordRow() // user password 
  {
    return Padding(
      padding: EdgeInsets.all(8),
        child: TextFormField(
          keyboardType: TextInputType.text,
          obscureText: true,
          onChanged: (value){
            setState(() {
              password = value;
            });
          },
          decoration: InputDecoration(
            prefixIcon: Icon(
                Icons.lock,
                color: firstColor,
              ),
              labelText: "Password"
          ),
        ),
      );
  }

  Widget buildAgreeButton() // Terms and Conditions

  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(width: 10,),
        Checkbox(
          checkColor: Colors.red,
          activeColor: Colors.white,
          value:this.checkB, 
          onChanged:(bool value){
            setState(() {
              this.checkB = value;
            });
          }
          ),
        Text(
          "Agree with Terms & Conditions"
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
            onPressed: () => {},
            child: Text(
              "Sign Up",
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
  Widget buildLoginButton()
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 40),
          child: FlatButton(
            onPressed: () => {MaterialPageRoute(builder: (context) => Login()),},
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "I'm already a member",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: MediaQuery.of(context).size.height / 40,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            ),
          ),
      ],
    );
  }
  Widget _buildContainer()
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height / 30,
                      ),
                    ),
                  ],
                ),
                _buildUsernameRow(),
                _buidemailRow(),
                _buildPasswordRow(),
                buildForgetPasswordButton(),
                buildSignUpButton(),
                buildLoginButton(),
              ],
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
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildLogo(),
                  _buildContainer(),
                ],
            )
          ],
        ),
      ),
    );
  }
}
