class Usuario {
  String _nome;
  String _email;
  String _senha;

  Usuario();

  get nome => this._nome;

  set nome(String nome) {
    nome = nome;
  }

  get email => this._email;

  set email(String email) {
    this._email = email;
  }

  get senha => this._senha;

  set senha(String senha) {
    this._senha = senha;
  }
}
