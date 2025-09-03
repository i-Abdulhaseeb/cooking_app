import 'package:flutter/material.dart';
import 'package:cooking_app/models/meal.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key, required this.title, required this.Meals});
  final String title;
  final List<Meal> Meals;
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
          itemBuilder: (ctx, index) => Text(
            Meals[index].title,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: content(),
    );
  }
}
