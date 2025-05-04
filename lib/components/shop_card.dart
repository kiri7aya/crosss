import 'package:flutter/material.dart';

class ShopCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final double rating;
  final int reviewsCount;
  final int priceLevel;
  final bool isFavorited;
  final VoidCallback onFavoriteToggle;

  const ShopCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.rating,
    required this.reviewsCount,
    required this.priceLevel,
    required this.isFavorited,
    required this.onFavoriteToggle,
  });

  // Helper method to determine star color based on rating
  Color _getStarColor(double rating) {
    if (rating > 4.7) return Colors.green;
    if (rating >= 4.0) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image for the shop
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.asset(
                imageUrl,  // Changed from Image.network to Image.asset
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(
                name,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                overflow: TextOverflow.ellipsis,  // Ensures text doesn't overflow
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  // Star rating icon
                  Icon(Icons.star, color: _getStarColor(rating), size: 18),
                  const SizedBox(width: 4),
                  // Rating and review count
                  Text(
                    '${rating.toStringAsFixed(1)} ($reviewsCount)',
                    style: const TextStyle(fontSize: 13),
                  ),
                  const Spacer(),
                  // Price level representation with "₸"
                  Text(
                    '₸' * priceLevel,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(width: 4),
                  // Favorite heart icon
                  IconButton(
                    icon: Icon(
                      isFavorited ? Icons.favorite : Icons.favorite_border,
                      color: isFavorited ? Colors.red : Colors.grey,
                      size: 20,
                    ),
                    onPressed: onFavoriteToggle,  // Toggle favorite status
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
