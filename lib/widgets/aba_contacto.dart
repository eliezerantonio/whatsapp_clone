import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:whatsap_clone/models/usuario.dart';
import 'package:whatsap_clone/screens/mensagem_screen.dart';

class AbaContacto extends StatefulWidget {
  const AbaContacto({Key key}) : super(key: key);

  @override
  _AbaContactoState createState() => _AbaContactoState();
}

class _AbaContactoState extends State<AbaContacto> {
  String _idUsuarioLogado;
  String _emailUsuarioLogado;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Usuario>>(
      future: _recuperarContactos(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text("Sem informacao disponivel");
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
            break;
          case ConnectionState.active:
          case ConnectionState.none:
            break;
          case ConnectionState.done:
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (_, index) {
                List<Usuario> listaItens = snapshot.data;

                Usuario usuario = listaItens[index];
                return ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, MENSAGEM_SCREEN,
                        arguments: usuario);
                  },
                  contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                  leading: CircleAvatar(
                      maxRadius: 30,
                      backgroundColor: Colors.grey,
                      backgroundImage: NetworkImage(usuario.urlImagem != null
                          ? usuario.urlImagem
                          : "https://firebasestorage.googleapis.com/v0/b/whatsapp-f57f1.appspot.com/o/perfil%2Fperfil6.jpeg?alt=media&token=2ff42684-f4bf-4547-8d15-0a45ff384cc0")),
                  title: Text(usuario.nome),
                );
              },
            );
            break;
        }
      },
    );
  }

  Future<List<Usuario>> _recuperarContactos() async {
    Firestore db = Firestore.instance;

    QuerySnapshot querySnapshot =
        await db.collection("usuarios").getDocuments();

    List<Usuario> listaUsuarios = List();

    for (DocumentSnapshot item in querySnapshot.documents) {
      var dados = item.data;

      if (dados["email"] == _emailUsuarioLogado) continue;

      Usuario usuario = Usuario();

      usuario.email = dados["email"];
      usuario.idUsuario = item.documentID;
      usuario.nome = dados["nome"];
      usuario.urlImagem = dados["urlImagem"];
      listaUsuarios.add(usuario);
    }

    return listaUsuarios;
  }

  _recuperarDadosUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    FirebaseUser usuarioLogado = await auth.currentUser();

    _idUsuarioLogado = usuarioLogado.uid;
    _emailUsuarioLogado = usuarioLogado.email;
  }

  @override
  void initState() {
    super.initState();
    _recuperarDadosUsuario();
  }
}
