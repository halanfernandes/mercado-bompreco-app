import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../cart_model.dart'; // Atualize para o caminho correto do seu arquivo cart_model.dart

class BebidasProdutos extends StatelessWidget {
  const BebidasProdutos({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        Produto(nome: 'Refrigerante 2L', preco: 'R\$ 7,00'),
        Produto(nome: 'Suco de Laranja 1L', preco: 'R\$ 5,00'),
        Produto(nome: 'Água Mineral 1,5L', preco: 'R\$ 2,00'),
        Produto(nome: 'Cerveja Lata 350ml', preco: 'R\$ 4,00'),
        Produto(nome: 'Energético 250ml', preco: 'R\$ 6,00'),
        Produto(nome: 'Chá Gelado 500ml', preco: 'R\$ 3,00'),
        Produto(nome: 'Vinho Tinto 750ml', preco: 'R\$ 30,00'),
      ],
    );
  }
}

class Produto extends StatefulWidget {
  final String nome;
  final String preco;

  const Produto({required this.nome, required this.preco, super.key});

  @override
  _ProdutoState createState() => _ProdutoState();
}

class _ProdutoState extends State<Produto> {
  int _quantidade = 1;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = _quantidade.toString();
  }

  void _incrementQuantity() {
    setState(() {
      _quantidade++;
      _controller.text = _quantidade.toString();
    });
  }

  void _decrementQuantity() {
    if (_quantidade > 1) {
      setState(() {
        _quantidade--;
        _controller.text = _quantidade.toString();
      });
    }
  }

  void _updateQuantity(String value) {
    final newQuantity = int.tryParse(value);
    if (newQuantity != null && newQuantity > 0) {
      setState(() {
        _quantidade = newQuantity;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartModel>(context, listen: false);

    return ListTile(
      title: Text(widget.nome),
      subtitle: Text(widget.preco),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: _decrementQuantity,
          ),
          Container(
            width: 50,
            child: TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(vertical: 0),
              ),
              onChanged: _updateQuantity,
            ),
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _incrementQuantity,
          ),
          SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {
              cart.addItem(widget.nome, _quantidade);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${widget.nome} adicionado ao carrinho')),
              );
            },
            child: const Text('Adicionar'),
          ),
        ],
      ),
    );
  }
}
