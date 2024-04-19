import 'package:listadecompras/class/Usuario.dart';

class GerenciadorUsuariosSingleton {
  static final GerenciadorUsuariosSingleton _instance =
      GerenciadorUsuariosSingleton._internal();

  GerenciadorUsuariosSingleton._internal();

  static GerenciadorUsuariosSingleton get instance => _instance;

  List<Usuario> _usuarios = [];

  void adicionarUsuario(Usuario usuario) {
    _usuarios.add(usuario);
  }

  void imprimirTodosUsuarios() {
    print('Lista de Usuários:');
    for (var usuario in _usuarios) {
      print(
          'Nome: ${usuario.nome}, Email: ${usuario.email}, Senha: ${usuario.senha}');
    }
  }

  bool verificarCredenciais(String email, String senha) {
    for (var usuario in _usuarios) {
      if (usuario.email == email && usuario.senha == senha) {
        return true;
      }
    }
    return false;
  }
}
