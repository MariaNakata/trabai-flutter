class Usuario {
  final int id;
  final String nome;
  final String email;
  final String senha;

  Usuario({
    required this.nome,
    required this.email,
    required this.senha,
  }) : id = _proximoId++;

  static int _proximoId = 1;
}
