import 'package:flutter/material.dart';
import 'package:whatsap_clone/screens/cadastro_screen.dart';
import 'package:whatsap_clone/screens/home_screen.dart';
import 'package:whatsap_clone/screens/login_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );

        break;
      case LOGIN_SCREEN:
        MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );

        break;

      case CADASTRO_SCREEN:
        MaterialPageRoute(
          builder: (_) => CadastroScreen(),
        );

        break;
      case HOME_SCREEN:
        MaterialPageRoute(
          builder: (_) => HomeScreen(),
        );

        break;

      default:
        _erroRota();
    }
  }

  static Route<dynamic> _erroRota() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text("Tela nao encotrada"),
        ),
        body: Center(
          child: Text("Tela nao encotrada"),
        ),
      ),
    );
  }
}
