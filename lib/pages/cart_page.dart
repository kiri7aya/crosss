import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  final List<Map<String, dynamic>> items;  // Now we receive items as a list

  const CartPage({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              // Logic for clearing the cart can be added here if needed
            },
          ),
        ],
      ),
      body: items.isEmpty
          ? const Center(child: Text('Your cart is empty.'))
          : ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return ListTile(
            // Using Image.asset to load the image from the assets folder
            leading: Image.asset(
              item['imageUrl'],  // Assuming the 'imageUrl' field has the asset path
              width: 50, // Set a fixed width to control image size
              height: 50, // Set a fixed height to control image size
              fit: BoxFit.cover,
            ),
            title: Text(item['name']),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('₸${item['price'].toStringAsFixed(0)}'),
                Text('Total: ₸${(item['price'] * item['quantity']).toStringAsFixed(0)}'),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.remove_circle),
              onPressed: () {
                // Remove the item from the list (you could pass a callback for this)
              },
            ),
          );
        },
      ),
    );
  }
}
