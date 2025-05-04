import 'package:flutter/material.dart';
import '../models/flower_shop.dart'; // Ensure FlowerShop is imported

class FlowerShopDetailPage extends StatefulWidget {
  final String imageUrl;
  final String logoUrl;
  final String shopName;
  final String description;
  final double rating;
  final double deliveryPrice;
  final String address;
  final List<Map<String, dynamic>> items;
  final List<Map<String, dynamic>> cartItems;  // Added cartItems
  final Function(Map<String, dynamic>) onAddToCart;  // Added onAddToCart function

  const FlowerShopDetailPage({
    super.key,
    required this.imageUrl,
    required this.logoUrl,
    required this.shopName,
    required this.description,
    required this.rating,
    required this.deliveryPrice,
    required this.address,
    required this.items,
    required this.cartItems,  // Initialize cartItems
    required this.onAddToCart,  // Initialize onAddToCart function
  });

  @override
  State<FlowerShopDetailPage> createState() => _FlowerShopDetailPageState();
}

class _FlowerShopDetailPageState extends State<FlowerShopDetailPage> {
  List<Map<String, dynamic>> addedItems = [];  // List to hold added items

  void _addToCart(Map<String, dynamic> item) {
    setState(() {
      addedItems.add(item);  // Add item to the list
    });
    widget.onAddToCart(item);  // Call the function to update cartItems in the parent
    _showCartSummary();
  }

  void _showCartSummary() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Cart Summary'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var item in addedItems)
                Text('${item['name']}'),
              const SizedBox(height: 16),
              Text('Total: ₸${_calculateTotal()}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  double _calculateTotal() {
    double total = 0;
    for (var item in addedItems) {
      total += item['price'];  // Just sum up the prices of added items
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Change to Image.asset for local assets
                  Image.asset(widget.imageUrl, fit: BoxFit.cover),
                  Positioned(
                    bottom: 16,
                    left: 16,
                    child: CircleAvatar(
                      radius: 32,
                      backgroundImage: NetworkImage(widget.logoUrl),
                      backgroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.shopName, style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 8),
                  Text(widget.description, style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(Icons.star, color: _getStarColor(widget.rating), size: 20),
                      const SizedBox(width: 4),
                      Text(widget.rating.toStringAsFixed(1)),
                      const SizedBox(width: 6),
                      const Text('Rating', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.local_shipping, size: 20),
                      const SizedBox(width: 4),
                      Text('₸${widget.deliveryPrice.toStringAsFixed(0)}'),
                      const SizedBox(width: 6),
                      const Text('Delivery', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 20),
                      const SizedBox(width: 4),
                      Text(widget.address),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Popular Items', style: Theme.of(context).textTheme.titleLarge),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  final item = widget.items[index];
                  return Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                            // Change to Image.asset for local assets
                            child: Image.asset(item['imageUrl'], fit: BoxFit.cover, width: double.infinity),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                              const SizedBox(height: 4),
                              Text('₸${item['price'].toStringAsFixed(0)}', style: const TextStyle(color: Colors.pink)),
                              const SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: () {
                                  _addToCart(item);  // Add item to the cart when clicked
                                },
                                child: const Text('Add to Cart'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                childCount: widget.items.length > 6 ? 6 : widget.items.length,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.75,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStarColor(double rating) {
    if (rating > 4.7) return Colors.green;
    if (rating >= 4.0) return Colors.orange;
    return Colors.red;
  }
}
