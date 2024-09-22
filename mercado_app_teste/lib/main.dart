import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './carrinho_page.dart';
import 'classes_produtos/limpeza.dart';
import 'classes_produtos/alimentos.dart';
import 'classes_produtos/padaria.dart';
import 'classes_produtos/bebidas.dart';
import 'classes_produtos/higiene_pessoal.dart';
import 'classes_produtos/utilidades.dart';
import './pagamento.dart';
import './cart_model.dart';

void main() => runApp(const AppMercado());

class AppMercado extends StatelessWidget {
  const AppMercado({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartModel(),
      child: MaterialApp(
        title: 'Mercado Bom Preço',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const TelaInicial(),
      ),
    );
  }
}

class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key});

  @override
  TelaInicialState createState() => TelaInicialState();
}

class TelaInicialState extends State<TelaInicial>
    with SingleTickerProviderStateMixin {
  late AnimationController _controlador;
  late Animation<Offset> _animacao;

  @override
  void initState() {
    super.initState();
    _controlador = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _animacao = Tween<Offset>(
      begin: const Offset(0, -1), // Começa fora da tela, embaixo
      end: Offset.zero, // Termina no centro
    ).animate(CurvedAnimation(
      parent: _controlador,
      curve: Curves.easeInOut,
    ));

    _controlador.forward();
  }

  @override
  void dispose() {
    _controlador.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Positioned(
            top: 300, // Ajuste conforme necessário
            left: 0,
            right: 0,
            child: Center(
              child: Icon(
                Icons.shopping_cart, // Ícone de loja como exemplo
                size: 100, // Tamanho do ícone
                color: Colors.blue, // Cor do ícone
              ),
            ),
          ),
          SlideTransition(
            position: _animacao,
            child: const Center(
              child: Text(
                'Bem-vindo ao Mercado Bom Preço!\nAqui você encontra as melhores opções',
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Positioned(
            bottom: 320,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => const TelaAbasProdutos(),
                    ),
                  );
                },
                child: const Text('Entrar no Mercado Bom Preço'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TelaAbasProdutos extends StatelessWidget {
  const TelaAbasProdutos({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Escolha uma categoria'),
          actions: [
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TelaCarrinho()),
                );
              },
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Limpeza'),
              Tab(text: 'Alimentos'),
              Tab(text: 'Padaria'),
              Tab(text: 'Bebidas'),
              Tab(text: 'Higiene Pessoal'),
              Tab(text: 'Utilidades Domésticas'),
            ],
            isScrollable: true,
          ),
        ),
        body: const TabBarView(
          children: [
            LimpezaProdutos(),
            AlimentosProdutos(),
            PadariaProdutos(),
            BebidasProdutos(),
            HigienePessoalProdutos(),
            UtilidadesProdutos(),
          ],
        ),
      ),
    );
  }
}
