import 'package:flutter/material.dart';
import '../models/flower_shop.dart';  // Import FlowerShop
import '../pages/flower_shop_detail_page.dart';  // Import FlowerShopDetailPage
import '../components/shop_card.dart';  // Import ShopCard

class RecommendedShopsSection extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;  // Accept the cart items
  final Function(Map<String, dynamic>) onAddToCart;  // Function to add items to the cart
  final Set<String> favoriteShops;  // To track favorite shops
  final Function(String) onFavoriteShopToggle;  // To toggle shop favorites

  const RecommendedShopsSection({
    super.key,
    required this.cartItems,
    required this.onAddToCart,  // Initialize onAddToCart function
    required this.favoriteShops,
    required this.onFavoriteShopToggle,  // Initialize onFavoriteShopToggle function
  });

  @override
  State<RecommendedShopsSection> createState() => _RecommendedShopsSectionState();
}

class _RecommendedShopsSectionState extends State<RecommendedShopsSection> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 16, top: 24, bottom: 8),
          child: Text(
            'Recommended',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: flowerShops.length,  // flowerShops should be a list of your flower shop data
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemBuilder: (context, index) {
              final shop = flowerShops[index];  // Get the shop data
              final isFavorited = widget.favoriteShops.contains(shop.id);  // Check if shop is favorited

              return GestureDetector(
                onTap: () {
                  // When shop card is tapped, navigate to the detailed shop page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FlowerShopDetailPage(
                        imageUrl: shop.imageUrl,
                        logoUrl: shop.logoUrl,
                        shopName: shop.name,
                        description: shop.description,
                        rating: shop.rating,
                        deliveryPrice: shop.deliveryPrice,
                        address: shop.address,
                        items: shop.items.map((e) => {
                          'name': e.name,
                          'price': e.price,
                          'imageUrl': e.imageUrl,  // Using local image URL from assets
                        }).toList(),
                        cartItems: widget.cartItems,
                        onAddToCart: widget.onAddToCart,  // Pass the function to add to cart
                      ),
                    ),
                  );
                },
                child: ShopCard(
                  imageUrl: shop.imageUrl,  // Local image from assets
                  name: shop.name,
                  rating: shop.rating,
                  reviewsCount: 1234,  // Placeholder, should be the real reviews count
                  priceLevel: 2,  // Example value for price level
                  isFavorited: isFavorited,  // Set this based on whether the shop is favorited
                  onFavoriteToggle: () {
                    // Toggle favorite logic
                    widget.onFavoriteShopToggle(shop.id);  // Pass shop ID to toggle favorite
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
