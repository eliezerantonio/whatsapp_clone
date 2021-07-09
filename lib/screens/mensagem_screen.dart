import 'package:flutter/material.dart';
import 'package:whatsap_clone/models/usuario.dart';

const MENSAGEM_SCREEN = "/mensagem_screen";

class MensagemScreen extends StatefulWidget {
  MensagemScreen({Key key, this.contato}) : super(key: key);
  Usuario contato;

  @override
  _MensagemScreenState createState() => _MensagemScreenState();
}

class _MensagemScreenState extends State<MensagemScreen> {
  final _controllerMensagem = TextEditingController();
  List<String> listaMensagens = [
    "Eliezer",
    "Tudo bem",
    "Nas calmas e tu?",
    "Domingos",
    "Fluter is good",
    "Learning React Js"
  ];
  @override
  Widget build(BuildContext context) {
    var caixaMensagem = Container(
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                right: 8,
              ),
              child: TextField(
                style: TextStyle(fontSize: 20),
                autofocus: true,
                controller: _controllerMensagem,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                  hintText: "Digite uma mensagem...",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  prefixIcon: IconButton(
                    icon: Icon(Icons.camera_alt),
                    onPressed: _enviarFoto,
                  ),
                ),
              ),
            ),
          ),
          FloatingActionButton(
            onPressed: () {},
            mini: true,
            child: Icon(Icons.send, color: Colors.white),
            backgroundColor: Theme.of(context).primaryColor,
          )
        ],
      ),
    );

    var listView = Expanded(
      child: ListView.builder(
        itemCount: listaMensagens.length,
        itemBuilder: (_, index) {
          double larguraContainer = MediaQuery.of(context).size.width*0.8;
          Alignment alinhamento = Alignment.centerRight;
          Color cor = Color(0xffd2ffa5);
          if (index % 2 == 0) {
            cor = Colors.white;
            alinhamento = Alignment.centerLeft;
          }
          return Align(
            alignment: alinhamento,
            child: Padding(
              padding: EdgeInsets.all(6),
              child: Container(
                width: larguraContainer,
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: cor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  listaMensagens[index],
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          );
        },
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.contato.urlImagem),
            ),
            SizedBox(
              width: 10,
            ),
            Text(widget.contato.nome),
          ],
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/bg.png"), fit: BoxFit.cover),
        ),
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                listView,
                caixaMensagem,
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _enviarFoto() {}
}
