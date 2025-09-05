import 'package:flutter/material.dart';
import 'package:cooking_app/models/meal.dart';
import 'package:cooking_app/widgets/meal_item.dart';
import 'package:cooking_app/screens/meal_details.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.title,
    required this.Meals,
    required this.ontoggleFavourite,
  });
  final String? title;
  final List<Meal> Meals;
  final void Function(Meal meal) ontoggleFavourite;
  void SelectedMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) =>
            MealDetailScreen(meal: meal, ontoggleFavourite: ontoggleFavourite),
      ),
    );
  }

  @override
  Widget build(context) {
    Widget content() {
      if (Meals.isEmpty) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Uh oh... nothing here",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              SizedBox(height: 16),
              Text(
                "View a Different Category",
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ],
          ),
        );
      } else {
        return ListView.builder(
          itemCount: Meals.length,
          itemBuilder: (ctx, index) => MealItem(
            meal: Meals[index],
            selected: (meal) {
              SelectedMeal(context, meal);
            },
          ),
        );
      }
    }

    if (title == null) {
      return content();
    }
    return Scaffold(
      appBar: AppBar(title: Text(title!)),
      body: content(),
    );
  }
}
