import 'package:flutter/material.dart';
import 'package:listadecompras/class/GerenciadorUsuarios.dart';
import 'package:listadecompras/class/Usuario.dart';
import 'package:listadecompras/main.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CadastroPage(),
    );
  }
}

class CadastroPage extends StatefulWidget {
  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _confirmarSenhaController =
      TextEditingController();

  bool verificaSenhas(String senha, String confirmarSenha) {
    return senha == confirmarSenha;
  }

  bool verificaEmail(String email) {
    return email.contains('@');
  }

  bool camposNaoVazios(
      String nome, String email, String senha, String confirmarSenha) {
    return nome.isNotEmpty &&
        email.isNotEmpty &&
        senha.isNotEmpty &&
        confirmarSenha.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD6D6D6),
      appBar: AppBar(
        title: Text('Cadastro'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _nomeController,
                decoration: InputDecoration(
                  hintText: 'Nome',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _senhaController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Senha',
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _confirmarSenhaController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Confirmar Senha',
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              SizedBox(height: 30),
              Container(
                width: 200,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    final nome = _nomeController.text;
                    final email = _emailController.text;
                    final senha = _senhaController.text;
                    final confirmarSenha = _confirmarSenhaController.text;

                    if (camposNaoVazios(nome, email, senha, confirmarSenha)) {
                      if (verificaSenhas(senha, confirmarSenha)) {
                        if (verificaEmail(email)) {
                          adicionaNovoUsuario(nome, email, senha);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Usuario criado com sucesso!'),
                            ),
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Dados incorretos'),
                            ),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('As senhas não coincidem'),
                          ),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Por favor, preencha todos os campos'),
                        ),
                      );
                    }
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Sobre o desenvolvedor',
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void adicionaNovoUsuario(String nome, String email, String senha) {
    Usuario novoUsuario = Usuario(
      nome: nome,
      email: email,
      senha: senha,
    );

    GerenciadorUsuariosSingleton.instance.adicionarUsuario(novoUsuario);

    GerenciadorUsuariosSingleton.instance.imprimirTodosUsuarios();
  }
}
