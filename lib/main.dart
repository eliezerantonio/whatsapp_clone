import 'dart:io';

import 'package:flutter/material.dart';

import 'package:whatsap_clone/screens/login_screen.dart';
import 'package:whatsap_clone/utils/route_generator.dart';

final ThemeData temaPadrao = ThemeData(
  primaryColor: Color(0xff075e53),
  accentColor: Color(
    0xff25d366,
  ),
);
final ThemeData temaIOS = ThemeData(
  primaryColor: Colors.grey[200],
  accentColor: Color(
    0xff25d366,
  ),
);
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Platform.isIOS ? temaIOS : temaPadrao,
      initialRoute: "/",
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
