class Usuario {
  String _idUsuario;

  String _nome;
  String _email;
  String _senha;
  String _urlImagem;

  Usuario();

  Map<String, dynamic> toMap() {
    return {
    
      "nome": this.nome,
      "email": this.email,
    };
  }

  get nome => this._nome;

  set nome(String nome) {
    this._nome = nome;
  }

  get urlImagem => this._urlImagem;

  set urlImagem(String value) => this._urlImagem = value;

  get email => this._email;

  set email(String email) {
    this._email = email;
  }

  String get idUsuario => this._idUsuario;

  set idUsuario(String value) => this._idUsuario = value;
  get senha => this._senha;

  set senha(String senha) {
    this._senha = senha;
  }
}
