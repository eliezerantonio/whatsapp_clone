import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsap_clone/models/mensagem.dart';
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
  String _idUsuarioDestinatario;
  var _idUsuarioLogado;
  Firestore db = Firestore.instance;
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
            onPressed: enviarMensagem,
            mini: true,
            child: Icon(Icons.send, color: Colors.white),
            backgroundColor: Theme.of(context).primaryColor,
          )
        ],
      ),
    );

    var stream = StreamBuilder(
      stream: db
          .collection("mensagens")
          .document(_idUsuarioLogado)
          .collection(_idUsuarioDestinatario)
          .snapshots(),
      builder: (_, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:

          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
            break;

          case ConnectionState.active:

          case ConnectionState.done:
            QuerySnapshot querySnapshot = snapshot.data;
            if (snapshot.hasError) {
              return Expanded(
                child: Text("Erro ao carregar dados"),
              );
            } else {
              return Expanded(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: querySnapshot.documents.length,
                  itemBuilder: (_, index) {
                    //recupera mensagem
                    List<DocumentSnapshot> mensagens =
                        querySnapshot.documents.toList();

                    DocumentSnapshot item = mensagens[index];
                    print(item);
                    double larguraContainer =
                        MediaQuery.of(context).size.width * 0.8;
                    Alignment alinhamento = Alignment.centerRight;
                    Color cor = Color(0xffd2ffa5);
                    if (_idUsuarioLogado != item["idUsuario"]) {
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
                            item["mensagem"],
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
            break;
        }
      },
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
                stream,
                caixaMensagem,
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _enviarFoto() {}
  _recuperarDadosUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    FirebaseUser usuarioLogado = await auth.currentUser();

    _idUsuarioLogado = usuarioLogado.uid;
    _idUsuarioDestinatario = widget.contato.idUsuario;
  }

  @override
  void initState() {
    super.initState();
    _recuperarDadosUsuario();
  }

  void enviarMensagem() {
    String textoMensagem = _controllerMensagem.text;
    if (textoMensagem.isNotEmpty) {
      Mensagem mensagem = Mensagem();
      mensagem.idUsuario = _idUsuarioLogado;
      mensagem.mensagem = textoMensagem;
      mensagem.urlImagem = "";
      mensagem.tipo = "texto";

      _salvarMensagem(_idUsuarioLogado, _idUsuarioDestinatario, mensagem);
    }
  }

  void _salvarMensagem(
      String idRemetente, String _idDestinatario, Mensagem mensagem) async {
    Firestore db = Firestore.instance;
    await db
        .collection("mensagens")
        .document(idRemetente)
        .collection(_idDestinatario)
        .add(mensagem.toMap());

    //limpar compo
    _controllerMensagem.clear();
    /**
     * 
     * 
     * "Mensagens"
     * + eliezer Antonio 
     *  +professor
     *    + identificadorFirebase
     *        <Mensagem>
     * 
     */
  }
}
