import 'package:flutter/material.dart';

class memberPage extends StatelessWidget {
  memberPage({this.username});
  final String username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Welcome member !!!!"),),
    );
  }
}