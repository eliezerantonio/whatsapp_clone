import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:whatsap_clone/screens/home_screen.dart';
import 'package:whatsap_clone/screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
      theme: ThemeData(
        primaryColor: Color(0xff075e53),
        accentColor: Color(
          0xff25d366,
        ),
      ),
    );
  }
}
