import 'package:cloud_firestore/cloud_firestore.dart';

class Conversa {
  String _nome;
  String _mensagem;
  String _caminhoFoto;
  String _idRemetente;
  String _idDestinatario;
  String _tipoMensagem;

  Conversa([this._nome, this._mensagem, this._caminhoFoto]);

  salvar() async {
    Firestore db = Firestore.instance;
    await db
        .collection("conversas")
        .document(this.idRemetente)
        .collection("ultima_conversa")
        .document(this.idDestinatario)
        .setData(this.toMap());
  }

  Map<String, dynamic> toMap() {
    return {
      "idRemetente": this.idRemetente,
      "idDestinatario": this.idDestinatario,
      "nome": this.nome,
      "caminhoFoto": this.caminhoFoto,
      "tipoMensagem": this.tipoMensagem,
      "mensagem": this.mensagem
    };
  }

  String get nome => this._nome;

  set nome(String value) => this._nome = value;

  get mensagem => this._mensagem;

  set mensagem(value) => this._mensagem = value;

  get caminhoFoto => this._caminhoFoto;

  set caminhoFoto(value) => this._caminhoFoto = value;

  get idDestinatario => this._idDestinatario;

  set idDestinatario(value) => this._idDestinatario = value;

  get idRemetente => this._idRemetente;

  set idRemetente(value) => this._idRemetente = value;

  get tipoMensagem => this._tipoMensagem;

  set tipoMensagem(value) => this._tipoMensagem = value; //texto ou imagem
}
