import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsap_clone/models/usuario.dart';
import 'package:whatsap_clone/screens/home_screen.dart';

const CADASTRO_SCREEN = "/cadastro_screen";

class CadastroScreen extends StatefulWidget {
  CadastroScreen({Key key}) : super(key: key);

  @override
  _CadastroScreenState createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final _controllerNome = new TextEditingController();

  final _controllerEmail = new TextEditingController();

  final _controllerSenha = new TextEditingController();

  String _mensagemErro = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Criar Conta"),
      ),
      body: Container(
        decoration: const BoxDecoration(color: Color(0xff075354)),
        padding: EdgeInsets.all(20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  "assets/usuario.png",
                  width: 200,
                  height: 150,
                ),
                SizedBox(
                  height: 32,
                ),
                TextField(
                  controller: _controllerNome,
                  autofocus: true,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    hintText: "Nome",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                SizedBox(height: 10),
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
                  onPressed: () {
                    _validarCampos();
                  },
                  child: Text(
                    "Cadastrar",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  color: Colors.green,
                  padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                ),
                SizedBox(height: 7),
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

  void _validarCampos() {
    //recuperar dados dos campos
    String nome = _controllerNome.text;
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;

    if (nome.isNotEmpty) {
      if (email.isNotEmpty && email.contains("@")) {
        if (senha.trim().length > 5) {
          setState(() {
            _mensagemErro = "";
          });
          // executar metodo

          Usuario usuario = Usuario();

          usuario.nome = nome;
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
    } else {
      setState(() {
        _mensagemErro = "Preencha no nome";
      });
    }
  }

  _cadastrarUsuario(Usuario usuairo) {
    FirebaseAuth auth = FirebaseAuth.instance;

    auth
        .createUserWithEmailAndPassword(
      email: usuairo.email,
      password: usuairo.senha,
    )
        .then((firebaseUser) {
      Navigator.pushReplacementNamed(context, HOME_SCREEN);
    }).catchError((onError) {
      setState(() {
        _mensagemErro =
            "Erro ao cadastrar usuario verifique s campos e tente novamente";
      });
    });
  }
}
