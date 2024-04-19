import 'package:flutter/material.dart';
import 'package:listadecompras/class/ListaDeCompras.dart';
import 'package:listadecompras/pages/detail_list.dart';
import 'package:listadecompras/pages/form_add_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<ListaDeCompras> listaDeCompras = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 238, 238, 238),
      appBar: AppBar(
        title: const Text('Minhas Compras'),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: listaDeCompras.isEmpty
            ? Center(
                child: Text(
                  'Nenhuma lista criada',
                  style: TextStyle(fontSize: 18.0),
                ),
              )
            : ListView.builder(
                itemCount: listaDeCompras.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () =>
                        _navigateToDetailList(context, listaDeCompras[index]),
                    child: _buildListTile(listaDeCompras[index]),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddItemPage()),
          ).then((novaLista) {
            if (novaLista != null) {
              setState(() {
                listaDeCompras.add(novaLista);
              });
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildListTile(ListaDeCompras lista) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: const EdgeInsets.all(15.0),
      margin: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                lista.nome,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5.0),
              Text(
                'Itens: ${lista.itens.length}',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  _editListTitle(lista);
                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  _confirmDeleteList(context, lista);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _navigateToDetailList(BuildContext context, ListaDeCompras lista) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => DetailList(listaDeCompras: lista)),
    );
  }

  void _editListTitle(ListaDeCompras lista) {
    TextEditingController _titleController =
        TextEditingController(text: lista.nome);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Editar Título da Lista'),
        content: TextField(
          controller: _titleController,
          decoration: InputDecoration(
            labelText: 'Novo Título',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                lista.nome = _titleController.text;
              });
              Navigator.pop(context);
            },
            child: Text('Salvar'),
          ),
        ],
      ),
    );
  }

  void _confirmDeleteList(BuildContext context, ListaDeCompras lista) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirmar Exclusão'),
        content: Text('Tem certeza de que deseja excluir esta lista?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                listaDeCompras.remove(lista);
              });
              Navigator.pop(context);
            },
            child: Text('Excluir'),
          ),
        ],
      ),
    );
  }
}
