import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsap_clone/models/conversa.dart';

class AbaConversa extends StatefulWidget {
  const AbaConversa({Key key}) : super(key: key);

  @override
  _AbaConversaState createState() => _AbaConversaState();
}

class _AbaConversaState extends State<AbaConversa> {
  List<Conversa> listaConversas = List();
  Firestore db = Firestore.instance;
  String _idUsuarioLogado;

  final _controller = StreamController<QuerySnapshot>.broadcast();

  @override
  void initState() {
    super.initState();
    _recuperarDadosUsuario();
    Conversa conversa = Conversa();

    conversa.nome = "Ana Clara";
    conversa.mensagem = "Ola tudo bem ";
    conversa.caminhoFoto =
        "https://firebasestorage.googleapis.com/v0/b/whatsapp-f57f1.appspot.com/o/perfil%2Fperfil6.jpeg?alt=media&token=2ff42684-f4bf-4547-8d15-0a45ff384cc0";

    listaConversas.add(conversa);
  }

  Stream<QuerySnapshot> _adicionarListenerConversas() {
    final stream = db
        .collection("conversas")
        .document(_idUsuarioLogado)
        .collection("ultima_conversa")
        .snapshots();

    stream.listen((event) {
      _controller.add(event);
    });
  }

  _recuperarDadosUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser usuarioLogado = await auth.currentUser();
    setState(() {
      _idUsuarioLogado = usuarioLogado.uid;
    });
    _adicionarListenerConversas();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _controller.stream,
      builder: (_, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
            break;

          case ConnectionState.active:
          case ConnectionState.done:
            if (snapshot.hasError) {
              return Center(
                child: Text("Erro ao carrregar dados"),
              );
            } else {
              QuerySnapshot querySnapshot = snapshot.data;
              if (querySnapshot.documents.length == 0) {
                return Center(
                  child: Text("Voce nao tem nenhuma mensagem ainda :("),
                );
              }

              return ListView.builder(
                itemCount: listaConversas.length,
                itemBuilder: (context, index) {
                  List<DocumentSnapshot> conversas =
                      querySnapshot.documents.toList();
                  DocumentSnapshot item = conversas[index];

                  String ulrImagem = item["caminhoFoto"];
                  String tipo = item["tipoMensagem"];
                  String mensagem = item["mensagem"];
                  String nome = item["nome"];

                  return ListTile(
                    contentPadding: EdgeInsets.fromLTRB(15, 8, 16, 8),
                    leading: CircleAvatar(
                      maxRadius: 30,
                      backgroundColor: Colors.grey,
                      backgroundImage: NetworkImage(ulrImagem ?? ""),
                    ),
                    title: Text(
                      nome,
                      style: TextStyle(fontSize: 16),
                    ),
                    subtitle: Text(
                      tipo == "texto" ? mensagem : "imagem...",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  );
                },
              );
            }
        }
      },
    );
  }
}
