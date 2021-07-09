import 'package:flutter/material.dart';
import 'package:whatsap_clone/models/conversa.dart';

class AbaConversa extends StatefulWidget {
  const AbaConversa({Key key}) : super(key: key);

  @override
  _AbaConversaState createState() => _AbaConversaState();
}

class _AbaConversaState extends State<AbaConversa> {
  List<Conversa> listaConversas = List();
  @override
  void initState() {
    super.initState();

    Conversa conversa = Conversa();

    conversa.nome = "Ana Clara";
    conversa.mensagem = "Ola tudo bem ";
    conversa.caminhoFoto =
        "https://firebasestorage.googleapis.com/v0/b/whatsapp-f57f1.appspot.com/o/perfil%2Fperfil6.jpeg?alt=media&token=2ff42684-f4bf-4547-8d15-0a45ff384cc0";

    listaConversas.add(conversa);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listaConversas.length,
      itemBuilder: (context, index) {
        Conversa conversa = listaConversas[index];

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
          subtitle: Text(
            conversa.mensagem,
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        );
      },
    );
  }
}
