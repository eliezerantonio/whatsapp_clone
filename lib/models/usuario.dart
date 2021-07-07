class Usuario {
  String _nome;
  String _email;
  String _senha;

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

  get email => this._email;

  set email(String email) {
    this._email = email;
  }

  get senha => this._senha;

  set senha(String senha) {
    this._senha = senha;
  }
}
