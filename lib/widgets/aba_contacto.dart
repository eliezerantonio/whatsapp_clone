import 'package:flutter/material.dart';
import 'package:whatsap_clone/models/conversa.dart';

class AbaContacto extends StatelessWidget {
  const AbaContacto({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Conversa> listaContactos = [
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
    return ListView.builder(
      itemCount: listaContactos.length,
      itemBuilder: (context, index) {
        Conversa conversa = listaContactos[index];

        return ListTile(
          contentPadding: EdgeInsets.fromLTRB(15, 8, 16, 8),
          leading: CircleAvatar(
            maxRadius: 30,
            backgroundColor: Colors.grey,
            backgroundImage: NetworkImage(conversa.caminhoFoto),
          ),
          title: Text(
            conversa.nome,
            style: TextStyle(fontSize: 16),
          ),
        );
      },
    );
  }
}
