import 'package:flutter/material.dart';

class OrderDetailsPage extends StatelessWidget {
  final List<Map<String, dynamic>> addedItems;  // Pass the added items to OrderDetailsPage

  const OrderDetailsPage({Key? key, required this.addedItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order Details')),
      body: ListView(
        children: [
          if (addedItems.isEmpty)
            const ListTile(
              title: Text('No items in the cart'),
            ),
          for (var item in addedItems)
            ListTile(
              title: Text(item['name']),
              subtitle: Text('₸${item['price']} x 1'),  // Display 1 quantity, you can add more logic for quantity if needed
              trailing: Text('₸${item['price']}'),
            ),
          const Divider(),
          ListTile(
            title: Text('Total: ₸${_calculateTotal()}'),
          ),
          ListTile(
            title: ElevatedButton(
              onPressed: () {
                // Submit the order
              },
              child: const Text('Submit Order'),
            ),
          ),
        ],
      ),
    );
  }

  double _calculateTotal() {
    double total = 0;
    for (var item in addedItems) {
      total += item['price'];  // Just sum up the prices of added items
    }
    return total;
  }
}
