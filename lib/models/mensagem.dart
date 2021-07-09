class Mensagem {
  String _idUsuario;
  String _mensagem;
  String _urlImagem;

  //define o tipo da mensagem que pode ser texto ou imagem

  Map<String, dynamic> toMap() {
    return {
      "idUsuario": this.idUsuario,
      "mensagem": this.mensagem,
      "urlImagem": this.urlImagem,
      "tipo": this.tipo
    };
  }

  String _tipo;

  String get idUsuario => this._idUsuario;

  set idUsuario(String value) => this._idUsuario = value;

  get mensagem => this._mensagem;

  set mensagem(value) => this._mensagem = value;

  get urlImagem => this._urlImagem;

  set urlImagem(value) => this._urlImagem = value;

  get tipo => this._tipo;

  set tipo(value) => this._tipo = value;
}
