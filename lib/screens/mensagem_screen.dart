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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.contato.nome),
      ),
      body: Container(),
    );
  }
}
