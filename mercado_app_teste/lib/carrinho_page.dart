import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './cart_model.dart';
import './pagamento.dart';

class TelaCarrinho extends StatelessWidget {
  const TelaCarrinho({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (context, index) {
                final item = cart.items.keys.elementAt(index);
                final quantity = cart.items[item]!;
                final price = cart.precos[item] ?? 0.0; // Verificação adicional para garantir que preço não é nulo
                final totalPrice = quantity * price;

                return ListTile(
                  title: Text(item),
                  subtitle: Text(
                    'Quantidade: $quantity - Preço unitário: R\$ ${price.toStringAsFixed(2)} - Total: R\$ ${totalPrice.toStringAsFixed(2)}'
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      cart.removeItem(item);
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Pagamento()),
                );
              },
              child: Text(
                'Finalizar Compra - Total: R\$ ${cart.getTotalPrice().toStringAsFixed(2)}',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
