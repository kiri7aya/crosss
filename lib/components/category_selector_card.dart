import 'package:flutter/material.dart';

class CategorySelectorCard extends StatelessWidget {
  final List<String> categories;
  final int selectedIndex;
  final Function(int) onTap;

  const CategorySelectorCard({
    super.key,
    required this.categories,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemBuilder: (context, index) {
          final isSelected = index == selectedIndex;
          return GestureDetector(
            onTap: () => onTap(index),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? Colors.pink[100] : Colors.grey[200],
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: isSelected ? Colors.pink : Colors.grey,
                  width: 1,
                ),
              ),
              child: Center(
                child: Text(
                  categories[index],
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: isSelected ? Colors.pink[800] : Colors.black87,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
