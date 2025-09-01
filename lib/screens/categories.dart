import 'package:flutter/material.dart';
import 'package:cooking_app/data/dummy_data.dart';
import 'package:cooking_app/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});
  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pick your category")),
      body: GridView(
        padding: EdgeInsets.all(24),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          childAspectRatio: 3 / 2,
        ),
        children: [
          for (final category in availableCategories)
            CategoryGridItem(category: category),
        ],
      ),
    );
  }
}
