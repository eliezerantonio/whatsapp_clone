import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsap_clone/models/usuario.dart';
import 'package:whatsap_clone/screens/home_screen.dart';

import 'cadastro_screen.dart';

const LOGIN_SCREEN = "/login_screen";

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

final _controllerEmail = new TextEditingController();

final _controllerSenha = new TextEditingController();

String _mensagemErro = "";

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Color(0xff075354)),
        padding: const EdgeInsets.all(20),
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  "assets/logo.png",
                  width: 200,
                  height: 150,
                ),
                SizedBox(
                  height: 32,
                ),
                TextField(
                  controller: _controllerEmail,
                  autofocus: true,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    hintText: "E-mail",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _controllerSenha,
                  obscureText: true,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    hintText: "Password",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  onPressed: _logarUsuario,
                  child: Text(
                    "Entrar",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  color: Colors.green,
                  padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.pushNamed(context, CADASTRO_SCREEN);
                  },
                  child: Text(
                    "Nao tem conta? Cadastre-se",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Center(
                  child: Text(_mensagemErro,
                      style: TextStyle(color: Colors.red, fontSize: 20)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _logarUsuario() {
    //recuperar dados dos campos

    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;

    if (email.isNotEmpty && email.contains("@")) {
      if (senha.trim().length > 5) {
        setState(() {
          _mensagemErro = "";
        });
        // executar metodo

        Usuario usuario = Usuario();

        usuario.senha = senha;
        usuario.email = email;

        _cadastrarUsuario(usuario);
      } else {
        setState(() {
          _mensagemErro = "Preecnha a senha";
        });
      }
    } else {
      setState(() {
        _mensagemErro = "Preencha o email correto";
      });
    }
  }

  _cadastrarUsuario(Usuario usuairo) {
    FirebaseAuth auth = FirebaseAuth.instance;

    auth
        .signInWithEmailAndPassword(
      email: usuairo.email,
      password: usuairo.senha,
    )
        .then((firebaseUser) {
      Navigator.pushReplacementNamed(context, HOME_SCREEN);
    }).catchError((onError) {
      setState(() {
        _mensagemErro = "Erro ao fazer logineli";
      });
    });
  }

  Future _verificaUsuarioLogado() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser usuarioLogado = await auth.currentUser();

    if (usuarioLogado != null) {
      Navigator.pushReplacementNamed(context, HOME_SCREEN);
    }
  }

  @override
  void initState() {
    _verificaUsuarioLogado();
    super.initState();
  }
}
