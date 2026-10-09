import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  static const String cartKey = 'cart';

  final List<String> products = [
    'Produto A',
    'Produto B',
    'Produto C',
  ];

  List<String> cart = [];

  @override
  void initState() {
    super.initState();
    loadCart();
  }

  Future<void> loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final savedCart = prefs.getStringList(cartKey) ?? [];

    if (!mounted) return;

    setState(() {
      cart = savedCart;
    });
  }

  Future<void> addToCart(String product) async {
    final updatedCart = [...cart, product];

    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(cartKey, updatedCart);

    if (!mounted) return;

    setState(() {
      cart = updatedCart;
    });
  }

  Future<void> removeFromCart(int index) async {
    final updatedCart = [...cart];
    updatedCart.removeAt(index);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(cartKey, updatedCart);

    if (!mounted) return;

    setState(() {
      cart = updatedCart;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho de Compras'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Produtos disponíveis',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            ...products.map(
              (product) => Card(
                child: ListTile(
                  title: Text(product),
                  trailing: ElevatedButton(
                    onPressed: () => addToCart(product),
                    child: const Text('Adicionar ao carrinho'),
                  ),
                ),
              ),
            ),

            const Divider(height: 30),

            Text(
              'Meu carrinho (${cart.length} itens)',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Expanded(
              child: cart.isEmpty
                  ? const Center(
                      child: Text('Carrinho vazio'),
                    )
                  : ListView.builder(
                      itemCount: cart.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(cart[index]),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () => removeFromCart(index),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}