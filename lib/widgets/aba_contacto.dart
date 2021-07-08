import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:whatsap_clone/models/conversa.dart';
import 'package:whatsap_clone/models/usuario.dart';

class AbaContacto extends StatelessWidget {
  const AbaContacto({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Conversa> listaConversas = [
      Conversa(
        "Eliezer Antonio",
        "Nas calmas",
        "https://firebasestorage.googleapis.com/v0/b/whatsapp-f57f1.appspot.com/o/perfil%2Fperfil6.jpeg?alt=media&token=2ff42684-f4bf-4547-8d15-0a45ff384cc0",
      ),
      Conversa(
        "Jamilton Damasceno",
        "Nas calmas e tu",
        "https://firebasestorage.googleapis.com/v0/b/whatsapp-f57f1.appspot.com/o/perfil%2Fperfil5.jpg?alt=media&token=01ad2319-d9cc-4d1c-9d51-d431db2f018a",
      ),
      Conversa(
        "Ana Clara",
        "E ai galera",
        "https://firebasestorage.googleapis.com/v0/b/whatsapp-f57f1.appspot.com/o/perfil%2Fperfil3.jpg?alt=media&token=3513206b-d36d-4515-8c7d-5192475bf021",
      ),
    ];

    Future<List<Usuario>> _recuperarContactos() async {
      Firestore db = Firestore.instance;

      QuerySnapshot querySnapshot =
          await db.collection("usuarios").getDocuments();

      List<Usuario> listaUsuarios = List();

      for (DocumentSnapshot item in querySnapshot.documents) {
        var dados = item.data;
        Usuario usuario = Usuario();

        usuario.email = dados["email"];
        usuario.nome = dados["nome"];
        usuario.urlImagem = dados["urlImagem"];
        listaUsuarios.add(usuario);
      }

      return listaUsuarios;
    }

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
            ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (_, index) {
                List<Usuario> listaItens = snapshot.data;

                Usuario usuario = listaItens[index];
                return ListTile(
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
}
