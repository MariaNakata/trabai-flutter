import 'package:flutter/material.dart';
import 'package:listadecompras/class/ListaDeCompras.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Detalhes da Lista de Compras',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}

class DetailList extends StatefulWidget {
  final ListaDeCompras listaDeCompras;

  DetailList({required this.listaDeCompras});

  @override
  _DetailListState createState() => _DetailListState();
}

class _DetailListState extends State<DetailList> {
  TextEditingController _searchController = TextEditingController();
  List<ItemLista> _filteredItems = [];
  List<bool> isCheckedList = [];
  List<bool> isStrikedList = [];

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.listaDeCompras.itens;
    isCheckedList = List<bool>.filled(_filteredItems.length, false);
    isStrikedList = List<bool>.filled(_filteredItems.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 238, 238, 238),
      appBar: AppBar(
        title: Text('Detalhes da Lista de Compras'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar item',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: _filterItems,
            ),
            SizedBox(height: 30),
            Text(
              widget.listaDeCompras.nome,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Itens: ${_filteredItems.length}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredItems.length,
                itemBuilder: (context, index) {
                  final item = _filteredItems[index];
                  return _buildListItem(item, index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _filterItems(String value) {
    setState(() {
      _filteredItems = widget.listaDeCompras.itens
          .where(
              (item) => item.nome.toLowerCase().contains(value.toLowerCase()))
          .toList();
      isCheckedList = List<bool>.filled(_filteredItems.length, false);
      isStrikedList = List<bool>.filled(_filteredItems.length, false);
    });
  }

  Widget _buildListItem(ItemLista item, int index) {
    return Container(
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        item.nome,
                        style: TextStyle(
                          fontSize: 18,
                          decoration: isStrikedList[index]
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      Text(
                        'Quantidade: ${item.quantidade}',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      _editItem(item, index);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _confirmDelete(context, item, index);
                    },
                  ),
                ],
              ),
            ),
          ),
          Checkbox(
            value: isCheckedList[index],
            onChanged: (bool? value) {
              setState(() {
                isCheckedList[index] = value ?? false;
                isStrikedList[index] = isCheckedList[index];
              });
            },
          ),
        ],
      ),
    );
  }

  void _editItem(ItemLista item, int index) {
    TextEditingController nomeController =
        TextEditingController(text: item.nome);
    TextEditingController quantidadeController =
        TextEditingController(text: item.quantidade.toString());

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Editar Item'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nomeController,
              onChanged: (value) {
                setState(() {
                  item.nome = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Nome do Item',
              ),
            ),
            TextField(
              controller: quantidadeController,
              onChanged: (value) {
                setState(() {
                  item.quantidade = int.tryParse(value) ?? 0;
                });
              },
              decoration: InputDecoration(
                labelText: 'Quantidade',
              ),
              keyboardType: TextInputType.number,
            ),
          ],
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
              Navigator.pop(context);
            },
            child: Text('Salvar'),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context, ItemLista item, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirmar Exclusão'),
        content: Text('Tem certeza de que deseja excluir este item?'),
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
                widget.listaDeCompras.itens.removeAt(index);
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
