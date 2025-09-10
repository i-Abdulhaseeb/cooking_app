import 'package:cooking_app/models/meal.dart';
import 'package:cooking_app/screens/meals.dart';
import 'package:flutter/material.dart';
import 'package:cooking_app/data/dummy_data.dart';
import 'package:cooking_app/widgets/category_grid_item.dart';
import 'package:cooking_app/models/category.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    super.key,
    required this.ontoggleFavourite,
    required this.availableMeals,
  });
  final void Function(Meal meal) ontoggleFavourite;
  final List<Meal> availableMeals;
  void SelectedPage(BuildContext context, Category category) {
    final filteredMeals = availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          Meals: filteredMeals,
          ontoggleFavourite: ontoggleFavourite,
        ),
      ),
    );
  }

  @override
  Widget build(context) {
    return GridView(
      padding: EdgeInsets.all(24),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        childAspectRatio: 3 / 2,
      ),
      children: [
        for (final category in availableCategories)
          CategoryGridItem(
            category: category,
            onSelect: () {
              SelectedPage(context, category);
            },
          ),
      ],
    );
  }
}
