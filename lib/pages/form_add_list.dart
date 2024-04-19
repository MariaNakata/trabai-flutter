import 'package:flutter/material.dart';
import 'package:listadecompras/class/ListaDeCompras.dart';

void main() {
  runApp(AddItemPage());
}

class AddItemPage extends StatefulWidget {
  @override
  _AddItemPageState createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _listNameController = TextEditingController();
  List<Map<String, dynamic>> _items = [];
  List<TextEditingController> _itemNameControllers = [];
  List<TextEditingController> _quantityControllers = [];

  @override
  void initState() {
    super.initState();
    _addItemField();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 238, 238, 238),
      appBar: AppBar(
        title: Text('Adicionar Item'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  controller: _listNameController,
                  decoration: InputDecoration(labelText: 'Nome da Lista'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, insira o nome da lista';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ..._items.asMap().entries.map((entry) {
                  return Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _itemNameControllers[entry.key],
                          decoration:
                              InputDecoration(labelText: 'Nome do Item'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor, insira o nome do item';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            _items[entry.key]['nome'] = value;
                          },
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: TextFormField(
                          controller: _quantityControllers[entry.key],
                          decoration: InputDecoration(labelText: 'Quantidade'),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor, insira a quantidade';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            _items[entry.key]['quantidade'] =
                                int.tryParse(value) ?? 0;
                          },
                        ),
                      ),
                    ],
                  );
                }).toList(),
                SizedBox(height: 20),
                Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0), 
                  ),
                  child: ElevatedButton(
                    onPressed: _addItemField,
                    child: Text(
                      'Adicinar mais item +',
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
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            String listaNome = _listNameController.text;
            List<ItemLista> itemList = _items.map((item) {
              return ItemLista(item['nome'], item['quantidade']);
            }).toList();
            ListaDeCompras listaDeCompras = ListaDeCompras(listaNome, itemList);
            listaDeCompras.imprimirLista();
            Navigator.of(context).pop(listaDeCompras);
          }
        },
        label: Text('Finalizar'),
      ),
    );
  }

  void _addItemField() {
    setState(() {
      _items.add({'nome': '', 'quantidade': 0});
      _itemNameControllers.add(TextEditingController());
      _quantityControllers.add(TextEditingController());
    });
  }

  @override
  void dispose() {
    for (var controller in _itemNameControllers) {
      controller.dispose();
    }
    for (var controller in _quantityControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
