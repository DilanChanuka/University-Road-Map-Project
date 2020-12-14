import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:map_interfaces/Screens/Map/main_map.dart';
import '../../constanents.dart';
import '../../page_tran.dart';

class ProfilePage extends StatelessWidget{
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

  PickedFile imagefile;
  final ImagePicker picker = ImagePicker();
  final GlobalKey<State> _keyLoader = GlobalKey<State>();

  String _name = "University of Ruhuna";
  String _email = "UOR@gmail.com";
  String _type = "Staff Member";
  String _faculty = "Faculty of Science";
  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: firstColor, 
          title: Text("Choose Profile",
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
          padding: EdgeInsets.symmetric(),
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height / 30,
              ),
              profile(),
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
              ),
              name(),
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
              ),
              email(),
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
              ),
              type(),
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
              ),
              faculty(),
            ],
          ),
        ),
      ),
    );
  }
  Widget profile(){
    return SingleChildScrollView(
      child: Center(
        child: Stack(
          children: <Widget>[
            CircleAvatar(
              radius: MediaQuery.of(context).size.width / 5,
              backgroundImage: imagefile == null 
              ? AssetImage("assets/images/dp.png") 
              : FileImage(File(imagefile.path)),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / 6.5,
              right: MediaQuery.of(context).size.width / 22,
              child: InkWell(
                onTap: (){
                  showModalBottomSheet(
                    backgroundColor: firstColor,
                    context: context, 
                    builder: ((builder) => bottomSheet()),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    border: Border.all(color: Colors.teal),
                    borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.height / 30)),
                  ),
                  child: Icon(
                    Icons.camera_alt,
                    color: colorwhite,
                    size: MediaQuery.of(context).size.width / 10,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget bottomSheet(){
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(),
        height: MediaQuery.of(context).size.height / 5,
        width: MediaQuery.of(context).size.width ,
        child: Column(
          children: <Widget>[
            Text(
              "Choose Profile Photo",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: mainColor,
                fontSize: MediaQuery.of(context).size.width / 20,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton.icon(
                  onPressed: (){
                    takephoto(ImageSource.camera);
                  }, 
                  icon: Icon(
                    Icons.camera,
                    color: mainColor,
                    size: MediaQuery.of(context).size.width / 10,
                  ),
                  label: Text("Camera",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width / 20,
                    ),
                  ),
                ),
                FlatButton.icon(
                  onPressed: (){
                    takephoto(ImageSource.gallery);
                  }, 
                  icon: Icon(
                    Icons.image,
                    color: mainColor,
                    size: MediaQuery.of(context).size.width / 10,
                  ),
                  label: Text("Gallery",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width / 20,
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
  void takephoto(ImageSource source) async {
    final pickedFile = await picker.getImage(
      source : source,
    );
    setState(() {
      imagefile = pickedFile;
    });
  }
  Widget name(){
    return SingleChildScrollView(
      child: Center(
        child: Container(
          height: MediaQuery.of(context).size.height / 12,
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
            border: Border.all(color: colorborder),
            color: colorwhite,
          ),
          child: SingleChildScrollView(
            child: TextFormField(
              readOnly: true,
              autocorrect: true,
              onSaved: (input) => setState((){
                _name = input;
              }),
              initialValue: '$_name',
              decoration: InputDecoration(
                labelText: 'Name :',
                icon: Icon(
                  Icons.perm_identity,
                  size: MediaQuery.of(context).size.height / 20 ,
                ),
                contentPadding: EdgeInsets.all(5),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget email(){
    return SingleChildScrollView(
      child: Center(
        child: Container(
          height: MediaQuery.of(context).size.height / 12,
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
            border: Border.all(color: colorborder),
            color: colorwhite,
          ),
          child: SingleChildScrollView(
            child: TextFormField(
              readOnly: true,
              autocorrect: true,
              onSaved: (input) => setState((){
                _email = input;
              }),
              initialValue: '$_email',
              decoration: InputDecoration(
                labelText: 'Email :',
                icon: Icon(
                  Icons.email,
                  size: MediaQuery.of(context).size.height / 20 ,
                ),
                contentPadding: EdgeInsets.all(5),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget type(){
    return SingleChildScrollView(
      child: Center(
        child: Container(
          height: MediaQuery.of(context).size.height / 12,
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
            border: Border.all(color: colorborder),
            color: colorwhite,
          ),
          child: SingleChildScrollView(
            child: TextFormField(
              readOnly: true,
              autocorrect: true,
              onSaved: (input) => setState((){
                _type = input;
              }),
              initialValue: '$_type',
              decoration: InputDecoration(
                labelText: 'Type :',
                icon: Icon(
                  Icons.perm_identity,
                  size: MediaQuery.of(context).size.height / 20 ,
                ),
                contentPadding: EdgeInsets.all(5),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget faculty(){
    return SingleChildScrollView(
      child: Center(
        child: Container(
          height: MediaQuery.of(context).size.height / 12,
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
            border: Border.all(color: colorborder),
            color: colorwhite,
          ),
          child: SingleChildScrollView(
            child: TextFormField(
              readOnly: true,
              autocorrect: true,
              onSaved: (input) => setState((){
                _faculty = input;
              }),
              initialValue: '$_faculty',
              decoration: InputDecoration(
                labelText: 'Faculty :',
                icon: Icon(
                  Icons.school,
                  size: MediaQuery.of(context).size.height / 20 ,
                ),
                contentPadding: EdgeInsets.all(5),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleMainPage(BuildContext context) async{
    try{
      Dialogs.showLoadingDialog(context,_keyLoader);
      await Future.delayed(Duration(seconds: 3,));
      Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();

      Navigator.push(context,MaterialPageRoute(builder: (context) => MainMap()));
    }
    catch(error){
      print(error);
    }
  }
}