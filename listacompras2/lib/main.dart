// ===================================================================
// ATIVIDADE DE REVISÃO - SA02
// Lista de Compras
//
// Complete o código nos lugares marcados com TODO, usando os
// conceitos das aulas de Gasolina, Churrasco, Frases Motivacionais
// e Lista de Tarefas.
//
// Consulte o PDF "componentes_flutter_sa02.pdf" sempre que precisar
// relembrar a sintaxe de um widget.
// ===================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Compras',
      home: const TelaLista(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFE5E5E5),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2E7D32),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
    );
  }
}

// TODO 1: Crie aqui a classe/modelo Item.
// Ela deve ter:
//   - nome (String)
//   - quantidade (int)
//   - comprado (bool, começa como false)
class Item {
  String nome;
  int quantidade;
  bool comprado;

  Item({
    required this.nome,
    required this.quantidade,
    this.comprado = false,
  });
}

class TelaLista extends StatefulWidget {
  const TelaLista({super.key});

  @override
  State<TelaLista> createState() => _TelaListaState();
}

class _TelaListaState extends State<TelaLista> {
  // TODO 2: Crie a lista que vai guardar os itens (List<Item>)
  List<Item> itens = [];

  // TODO 3: Crie a função abrirTelaAdicionar().
  // Ela deve:
  //   a) Abrir a TelaAdicionarItem com Navigator.push, esperando um
  //      Item de volta
  //   b) Se vier um item, adicioná-lo na lista com setState
  //   c) Mostrar um SnackBar confirmando: "<nome> adicionado à lista"
  Future<void> abrirTelaAdicionar() async {
    final Item? novoItem = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const TelaAdicionarItem(),
      ),
    );

    if (novoItem != null) {
      setState(() {
        itens.add(novoItem);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${novoItem.nome} adicionado à lista'),
          backgroundColor: const Color(0xFF2E7D32),
        ),
      );
    }
  }

  // TODO 4: Crie a função removerItem(indice).
  // Ela deve:
  //   a) Remover o item da lista com setState
  //   b) Mostrar um SnackBar confirmando a remoção
  void removerItem(int indice) {
    final itemRemovido = itens[indice];

    setState(() {
      itens.removeAt(indice);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${itemRemovido.nome} removido da lista'),
        backgroundColor: Colors.black87,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final quantidadeComprados =
        itens.where((item) => item.comprado).length;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 78,
        titleSpacing: 20,
        title: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFF2E7D32),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.shopping_cart_outlined,
                color: Colors.white,
                size: 25,
              ),
            ),
            const SizedBox(width: 12),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Lista de',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white60,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  'Compras',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),

        // TODO 5: Mostre aqui quantos itens já foram comprados,
        // no formato "X de Y comprados"
        // (dica: use a propriedade bottom: do AppBar)
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(42),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 14),
            child: Row(
              children: [
                const Icon(
                  Icons.check_circle_outline,
                  color: Color(0xFF81C784),
                  size: 18,
                ),
                const SizedBox(width: 7),
                Text(
                  '$quantidadeComprados de ${itens.length} comprados',
                  style: const TextStyle(
                    color: Color(0xFFBDBDBD),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      // TODO 6: Use ListView.builder para exibir os itens da lista.
      // Cada item deve aparecer dentro de um Card, contendo:
      //   - um Checkbox para marcar como comprado
      //   - o nome do item (com efeito de texto riscado quando comprado)
      //   - a quantidade
      //   - um IconButton de lixeira que chama removerItem(indice)
      body: itens.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 15,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.shopping_basket_outlined,
                      size: 45,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Sua lista está vazia',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Adicione um item para começar',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 14, 12, 100),
              itemCount: itens.length,
              itemBuilder: (context, indice) {
                final item = itens[indice];

                return Card(
                  color: Colors.white,
                  elevation: 0,
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                    side: BorderSide(
                      color: Colors.black.withOpacity(0.05),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 7,
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 4,
                      ),
                      leading: Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          color: item.comprado
                              ? const Color(0xFFE8F5E9)
                              : const Color(0xFFF2F2F2),
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: Checkbox(
                          value: item.comprado,
                          activeColor: const Color(0xFF2E7D32),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          onChanged: (valor) {
                            setState(() {
                              item.comprado = valor!;
                            });
                          },
                        ),
                      ),
                      title: Text(
                        item.nome,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: item.comprado
                              ? Colors.black38
                              : Colors.black87,
                          decoration: item.comprado
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.inventory_2_outlined,
                              size: 15,
                              color: Colors.black45,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              'Quantidade: ${item.quantidade}',
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.delete_outline,
                          size: 23,
                          color: Colors.black45,
                        ),
                        onPressed: () {
                          removerItem(indice);
                        },
                      ),
                    ),
                  ),
                );
              },
            ),

      // TODO 7: Adicione um FloatingActionButton que chama
      // abrirTelaAdicionar()
      floatingActionButton: FloatingActionButton.extended(
        onPressed: abrirTelaAdicionar,
        backgroundColor: const Color(0xFF2E7D32),
        foregroundColor: Colors.white,
        elevation: 4,
        icon: const Icon(Icons.add),
        label: const Text(
          'Adicionar',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class TelaAdicionarItem extends StatefulWidget {
  const TelaAdicionarItem({super.key});

  @override
  State<TelaAdicionarItem> createState() => _TelaAdicionarItemState();
}

class _TelaAdicionarItemState extends State<TelaAdicionarItem> {
  // TODO 8: Crie os TextEditingController necessários
  // (um para o nome, outro para a quantidade)
  final nomeController = TextEditingController();
  final quantidadeController = TextEditingController();

  // TODO 9: Crie a função salvar().
  // Ela deve:
  //   a) Ler o texto dos controllers
  //   b) Se o nome estiver vazio, mostrar um SnackBar avisando e
  //      não continuar (use "return;")
  //   c) Fechar a tela com Navigator.pop, devolvendo um novo Item
  void salvar() {
    final nome = nomeController.text.trim();
    final quantidadeTexto = quantidadeController.text.trim();

    if (nome.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Digite o nome do item'),
          backgroundColor: Colors.black87,
        ),
      );
      return;
    }

    final quantidade = int.tryParse(quantidadeTexto) ?? 1;

    Navigator.pop(
      context,
      Item(
        nome: nome,
        quantidade: quantidade,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: const Row(
          children: [
            Icon(
              Icons.add_shopping_cart,
              color: Color(0xFF81C784),
              size: 24,
            ),
            SizedBox(width: 10),
            Text(
              'Novo Item',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            // TODO 10: Adicione um TextField para o nome do item
            TextField(
              controller: nomeController,
              decoration: InputDecoration(
                labelText: 'Nome do item',
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(
                  Icons.shopping_basket_outlined,
                  color: Color(0xFF2E7D32),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Colors.black.withOpacity(0.06),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: Color(0xFF2E7D32),
                    width: 2,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // TODO 11: Adicione um TextField para a quantidade
            // (dica: keyboardType: TextInputType.number)
            TextField(
              controller: quantidadeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Quantidade',
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(
                  Icons.numbers,
                  color: Color(0xFF2E7D32),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Colors.black.withOpacity(0.06),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: Color(0xFF2E7D32),
                    width: 2,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 22),

            // TODO 12: Adicione um ElevatedButton "Salvar" que
            // chama salvar()
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton.icon(
                onPressed: salvar,
                icon: const Icon(Icons.check),
                label: const Text(
                  'Salvar item',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E7D32),
                  foregroundColor: Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}