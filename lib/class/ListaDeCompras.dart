class ListaDeCompras {
  String nome;
  List<ItemLista> itens;

  ListaDeCompras(this.nome, this.itens);

  void adicionarItem(String nomeItem, int quantidade) {
    itens.add(ItemLista(nomeItem, quantidade));
  }

  void imprimirLista() {
    print('Nome da Lista: $nome');
    print('Itens da Lista:');
    for (var item in itens) {
      print('Nome: ${item.nome}, Quantidade: ${item.quantidade}');
    }
  }
}

class ItemLista {
  String nome;
  int quantidade;

  ItemLista(this.nome, this.quantidade);
}
