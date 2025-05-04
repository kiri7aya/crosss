import 'package:flutter/material.dart';

class MyOrdersPage extends StatelessWidget {
  final List<Map<String, dynamic>> addedItems;

  const MyOrdersPage({
    Key? key,
    required this.addedItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Orders')),
      body: addedItems.isEmpty
          ? const Center(child: Text('Your cart is empty'))
          : ListView.builder(
        itemCount: addedItems.length,
        itemBuilder: (context, index) {
          final item = addedItems[index];
          final double price = item['price'].toDouble();  // Ensure no issues with int/double type
          final int quantity = item['quantity'] ?? 1;  // Default to 1 if null
          final double totalCost = price * quantity;

          return ListTile(
            title: Text(item['name'] ?? 'No name'),
            subtitle: Text('₸$price x $quantity'),
            trailing: Text('₸$totalCost'),
          );
        },
      ),
    );
  }
}
