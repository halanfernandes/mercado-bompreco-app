import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  final Map<String, int> _items = {}; // Mapeia itens para suas quantidades
  final Map<String, double> _precos = {
    'Arroz 5kg': 15.00,
    'Feijão 1kg': 7.00,
    'Macarrão 500g': 4.00,
    'Açúcar 1kg': 3.50,
    'Café 500g': 8.00,
    'Óleo 900ml': 6.00,
    'Farinha de Trigo 1kg': 5.00,
    'Refrigerante 2L': 7.00,
    'Suco de Laranja 1L': 5.00,
    'Água Mineral 1,5L': 2.00,
    'Cerveja Lata 350ml': 4.00,
    'Energético 250ml': 6.00,
    'Chá Gelado 500ml': 3.00,
    'Vinho Tinto 750ml': 30.00,
    'Sabonete Líquido 250ml': 5.00,
    'Shampoo 350ml': 8.00,
    'Condicionador 350ml': 8.00,
    'Creme Dental 90g': 4.00,
    'Desodorante Roll-On 50ml': 6.00,
    'Creme Hidratante 200ml': 10.00,
    'Lâmina de Barbear (Pacote com 5 unidades)': 12.00,
    'Detergente Líquido': 2.50,
    'Sabão em Pó': 8.00,
    'Desinfetante': 5.00,
    'Água Sanitária': 3.00,
    'Esponja de Aço': 1.50,
    'Limpador Multiuso': 4.00,
    'Pano de Chão': 2.00,
    'Pão Francês': 0.50,
    'Pão de Forma': 5.00,
    'Croissant': 3.50,
    'Pão Integral': 6.00,
    'Baguete': 4.00,
    'Bolo de Chocolate': 15.00,
    'Pão de Queijo': 1.00,
    'Vassoura': 15.00,
    'Rodo': 12.00,
    'Balde': 10.00,
    'Esponja de Cozinha (Pacote com 3 unidades)': 5.00,
    'Panela de Pressão 4L': 70.00,
    'Tábua de Corte': 20.00,
    'Panos de Limpeza (Pacote com 5 unidades)': 8.00,
  }; // Map de preços dos itens

  Map<String, int> get items => _items;
  Map<String, double> get precos => _precos;

  void addItem(String item, int quantity) {
    if (_items.containsKey(item)) {
      _items[item] = (_items[item]! + quantity);
    } else {
      _items[item] = quantity;
    }
    notifyListeners();
  }

  void removeItem(String item) {
    _items.remove(item);
    notifyListeners();
  }

  void updateQuantity(String item, int quantity) {
    if (quantity <= 0) {
      removeItem(item);
    } else {
      _items[item] = quantity;
    }
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  double getTotalPrice() {
    double total = 0.0;
    _items.forEach((item, quantity) {
      if (_precos.containsKey(item)) {
        total += _precos[item]! * quantity;
      }
    });
    return total;
  }
}
