import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  final Map<String, dynamic> product;
  final Function(Map<String, dynamic>) onAddToCart;  // Function to add item to cart

  const ProductPage({
    super.key,
    required this.product,
    required this.onAddToCart,  // Pass onAddToCart function
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product['name'])),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              product['imageUrl'],  // Load image from assets
              height: 250,  // Set height for the image
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            Text(
              product['name'],
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            const SizedBox(height: 8),
            Text(
              '₸${product['price']}',
              style: const TextStyle(color: Colors.pink, fontSize: 20),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                onAddToCart(product);  // Add to cart when clicked
                Navigator.pop(context);  // Return to previous screen
              },
              child: const Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}
