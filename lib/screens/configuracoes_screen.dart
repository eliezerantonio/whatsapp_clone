import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

const CONFIGURACOES_SCREEN = "/configuracoes_screen";

class ConfiguracoesScreen extends StatefulWidget {
  ConfiguracoesScreen({Key key}) : super(key: key);

  @override
  _ConfiguracoesScreenState createState() => _ConfiguracoesScreenState();
}

class _ConfiguracoesScreenState extends State<ConfiguracoesScreen> {
  final _controllerNome = TextEditingController();
  File _imagem;
  bool _subindoImagem = false;
  String _urlImageRecuperada;

  String _idUsuarioLogado;
  Future _recuperarImagem(String origemImage) async {
    PickedFile imagemSelecionada;
    switch (origemImage) {
      case "camera":
        imagemSelecionada =
            await ImagePicker().getImage(source: ImageSource.camera);
        break;
      case "galeria":
        imagemSelecionada =
            await ImagePicker().getImage(source: ImageSource.gallery);
        break;
    }

    setState(() {
      _imagem = File(imagemSelecionada.path);
      if (_imagem != null) {
        _subindoImagem = true;
        _uploadImagem();
      }
    });
  }

  Future _uploadImagem() async {
    FirebaseStorage storage = FirebaseStorage.instance;

    StorageReference pastaRaiz = storage.ref();

    StorageReference arquivo =
        pastaRaiz.child("perfil").child("$_idUsuarioLogado.jpg");
    StorageUploadTask task = arquivo.putFile(_imagem);

    task.events.listen((event) {
      if (event.type == StorageTaskEventType.progress) {
        setState(() {
          _subindoImagem = true;
        });
      } else if (event.type == StorageTaskEventType.success) {
        setState(() {
          _subindoImagem = false;
        });
      }
    });

    //recuperar URl da Imagem

    task.onComplete.then((snaphot) {
      _recuperarUrlImagem(snaphot);
    });
  }

  Future _recuperarUrlImagem(StorageTaskSnapshot snapshot) async {
    String url = await snapshot.ref.getDownloadURL();

    setState(() {
      _urlImageRecuperada = url;
    });
  }

  _recuperarDadosUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    FirebaseUser usuarioLogado = await auth.currentUser();

    _idUsuarioLogado = usuarioLogado.uid;
  }

  @override
  void initState() {
    super.initState();
    _recuperarDadosUsuario();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar Perfil"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _subindoImagem ? Text("Carregando") : Container(),
                CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.grey,
                  backgroundImage: NetworkImage(_urlImageRecuperada == null
                      ? "https://firebasestorage.googleapis.com/v0/b/whatsapp-f57f1.appspot.com/o/perfil%2Fperfil6.jpeg?alt=media&token=2ff42684-f4bf-4547-8d15-0a45ff384cc0"
                      : _urlImageRecuperada),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlatButton(
                      onPressed: () {
                        _recuperarImagem("camera");
                      },
                      child: Text("Camera"),
                    ),
                    FlatButton(
                      onPressed: () {
                        _recuperarImagem("galeria");
                      },
                      child: Text("Galeria"),
                    ),
                  ],
                ),
                SizedBox(height: 15),
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
                SizedBox(height: 20),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  onPressed: () {},
                  child: Text(
                    "Salvar",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  color: Colors.green,
                  padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
