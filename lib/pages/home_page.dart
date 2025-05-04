
import 'package:flutter/material.dart';
import '../components/category_section.dart';  // Import CategorySection
import '../components/recommended_shops_section.dart';  // Import RecommendedShopsSection
import '../pages/product_page.dart';  // Import ProductPage
import '../models/flower_shop.dart';  // Import FlowerShop model

class HomePage extends StatefulWidget {
  final List<Map<String, dynamic>> addedItems;  // Accept addedItems
  final Function(Map<String, dynamic>) onAddToCart;  // Function to add item to cart
  final Set<String> favoriteProducts;  // To track favorite products
  final Set<String> favoriteShops;  // To track favorite shops
  final Function(String) onFavoriteProductToggle;  // To toggle product favorites
  final Function(String) onFavoriteShopToggle;  // To toggle shop favorites

  const HomePage({
    super.key,
    required this.addedItems,
    required this.onAddToCart,  // Pass onAddToCart function
    required this.favoriteProducts,
    required this.favoriteShops,
    required this.onFavoriteProductToggle,
    required this.onFavoriteShopToggle,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> categories = [
    'All', 'Flowers', 'Decor', 'Gift Sets',
  ];

  int selectedCategory = 0;

  // Example of products for display on the HomePage
  final List<Map<String, dynamic>> allProducts = [
    {
      'name': 'Red Roses',
      'price': 4500,
      'category': 'Flowers',
      'imageUrl': 'assets/flowers/1flo.jpg',
    },
    {
      'name': 'Peony Blush',
      'price': 4900,
      'category': 'Flowers',
      'imageUrl':  'assets/flowers/3flo.jpg',
    },
    {
      'name': 'Lily Love',
      'price': 4300,
      'category': 'Flowers',
      'imageUrl':  'assets/flowers/4flo.jpg',
    },
    {
      'name': 'Spring Basket',
      'price': 5700,
      'category': 'Decor',
      'imageUrl':  'assets/flowers/decor.jpg',
    },
    {
      'name': 'Gift Box',
      'price': 7000,
      'category': 'Gift Sets',
      'imageUrl': 'assets/flowers/gift.jpg',
    },
  ];

  // Example of flower shops data
  final List<FlowerShop> allShops = flowerShops;

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredProducts = selectedCategory == 0
        ? allProducts
        : allProducts.where((product) => product['category'] == categories[selectedCategory]).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: ListView(
        children: [
          CategorySection(
            categories: categories,
            selectedIndex: selectedCategory,
            onTap: (index) => setState(() => selectedCategory = index),
          ),
          RecommendedShopsSection(
            cartItems: widget.addedItems,
            onAddToCart: widget.onAddToCart,  // Pass the function
            favoriteShops: widget.favoriteShops,  // Pass favoriteShops
            onFavoriteShopToggle: widget.onFavoriteShopToggle,  // Pass the favorite toggle function
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Featured Products',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          // Display products in a grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,  // 2 columns for product grid
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.75,
            ),
            itemCount: filteredProducts.length,
            itemBuilder: (context, index) {
              final product = filteredProducts[index];
              final bool isFavorited = widget.favoriteProducts.contains(product['name']);  // Check if the product is in favorites

              return GestureDetector(
                onTap: () {
                  // Navigate to product page when clicked
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductPage(
                        product: product,
                        onAddToCart: widget.onAddToCart,  // Handle add to cart
                      ),
                    ),
                  );
                },
                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        product['imageUrl'],
                        fit: BoxFit.cover,
                        height: 150,
                        width: double.infinity,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          product['name'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text('₸${product['price']}'),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Favorite heart icon
                          IconButton(
                            icon: Icon(
                              isFavorited ? Icons.favorite : Icons.favorite_border,
                              color: isFavorited ? Colors.red : Colors.grey,
                            ),
                            onPressed: () {
                              widget.onFavoriteProductToggle(product['name']);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
