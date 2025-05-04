import 'package:flutter/material.dart';
import '../models/flower_shop.dart';  // Import FlowerShop model

class FavoritesPage extends StatelessWidget {
  final Set<String> favoriteProducts;  // For favorite products
  final Set<String> favoriteShops;     // For favorite shops
  final List<Map<String, dynamic>> allProducts;  // List of all products
  final List<FlowerShop> allShops;     // List of all shops

  const FavoritesPage({
    super.key,
    required this.favoriteProducts,
    required this.favoriteShops,  // Accept favoriteShops parameter
    required this.allProducts,    // Pass allProducts parameter
    required this.allShops,       // Pass allShops parameter
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,  // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Favorites'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'My Picks'),
              Tab(text: 'Favorite Shops'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            MyPicksPage(favoriteProducts: favoriteProducts, allProducts: allProducts),  // Show favorite products
            FavoriteShopsPage(favoriteShops: favoriteShops, allShops: allShops),  // Show favorite shops
          ],
        ),
      ),
    );
  }
}

class MyPicksPage extends StatelessWidget {
  final Set<String> favoriteProducts;
  final List<Map<String, dynamic>> allProducts;

  const MyPicksPage({
    super.key,
    required this.favoriteProducts,
    required this.allProducts,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: favoriteProducts.map((productName) {
        // Find the product data from allProducts list
        final product = allProducts.firstWhere((prod) => prod['name'] == productName);

        return Card(
          margin: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              Image.asset(product['imageUrl'], width: double.infinity, height: 150, fit: BoxFit.cover),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  product['name'],  // Display product name
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text('₸${product['price']}'),  // Display product price
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Handle adding to cart
                  },
                  child: const Text('Add to Cart'),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class FavoriteShopsPage extends StatelessWidget {
  final Set<String> favoriteShops;  // Stores favorite shop IDs
  final List<FlowerShop> allShops;  // List of all shops

  const FavoriteShopsPage({
    super.key,
    required this.favoriteShops,
    required this.allShops,  // Pass the list of all shops
  });

  @override
  Widget build(BuildContext context) {
    // Filter favorite shops by IDs in favoriteShops
    List<FlowerShop> favoriteShopList = allShops.where((shop) => favoriteShops.contains(shop.id)).toList();

    return ListView(
      children: favoriteShopList.map((shop) {
        return Card(
          margin: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display the shop image
              Image.asset(shop.imageUrl, width: double.infinity, height: 150, fit: BoxFit.cover),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  shop.name,  // Display shop name
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text('Rating: ${shop.rating}\nDelivery Price: ₸${shop.deliveryPrice}'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(shop.description),  // Display shop description
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Handle visiting shop page or other action
                  },
                  child: const Text('Visit Shop'),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
