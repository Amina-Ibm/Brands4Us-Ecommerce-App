import 'package:flutter/material.dart';
class pastOrderDetailView extends StatelessWidget {
  final Map<String, dynamic> cart;

  pastOrderDetailView({required this.cart});

  @override
  Widget build(BuildContext context) {
    final List products = cart['products'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Past Order Details (ID: ${cart['id']})'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),),
              title: Text('Product ID: ${product['productId']}',
          style: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary
          ),),
              subtitle: Text('Quantity: ${product['quantity']}',
          style: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary
          ),),
              tileColor: Theme.of(context).colorScheme.primary,
            ),

          );
        },
      ),
    );
  }
}
