import 'package:flutter/material.dart';
import 'package:whatsap_clone/screens/cadastro_screen.dart';
import 'package:whatsap_clone/screens/configuracoes_screen.dart';
import 'package:whatsap_clone/screens/home_screen.dart';
import 'package:whatsap_clone/screens/login_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );

        break;
      case LOGIN_SCREEN:
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );

        break;

      case CADASTRO_SCREEN:
        return MaterialPageRoute(
          builder: (_) => CadastroScreen(),
        );

        break;
      case HOME_SCREEN:
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
        );

        break;
      case CONFIGURACOES_SCREEN:
        return MaterialPageRoute(
          builder: (_) => ConfiguracoesScreen(),
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
