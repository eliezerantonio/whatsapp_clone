import 'package:flutter/material.dart';

const HOME_SCREEN = "/home_screen";

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WhatsapClone"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
      ),
    );
  }
}
