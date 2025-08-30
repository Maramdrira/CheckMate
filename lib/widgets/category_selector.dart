import 'package:flutter/material.dart';

class CategorySelector extends StatelessWidget {
  final List<Map<String, dynamic>> categories;
  final Map<String, dynamic> selectedCategory;
  final Function(Map<String, dynamic>) onCategorySelected;

  const CategorySelector({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Category',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: categories.map((category) {
            return ChoiceChip(
              label: Text('${category['emoji']} ${category['name']}'),
              selected: selectedCategory['name'] == category['name'],
              onSelected: (selected) {
                if (selected) {
                  onCategorySelected(category);
                }
              },
              backgroundColor: category['color'].withOpacity(0.2),
              selectedColor: category['color'],
              labelStyle: TextStyle(
                color: selectedCategory['name'] == category['name']
                    ? Colors.white
                    : Colors.black,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}