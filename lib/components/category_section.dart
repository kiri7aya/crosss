import 'package:flutter/material.dart';
import 'category_selector_card.dart';

class CategorySection extends StatelessWidget {
  final List<String> categories;
  final Function(int) onTap;
  final int selectedIndex;

  const CategorySection({
    super.key,
    required this.categories,
    required this.onTap,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 16.0, bottom: 8.0),
          child: Text(
            'Category',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        CategorySelectorCard(
          categories: categories,
          selectedIndex: selectedIndex,
          onTap: onTap,
        ),
      ],
    );
  }
}
