import 'package:cooking_app/models/meal.dart';
import 'package:cooking_app/screens/categories.dart';
import 'package:cooking_app/screens/filters.dart';
import 'package:cooking_app/screens/meals.dart';
import 'package:cooking_app/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});
  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favouriteMeals = [];
  void _SelectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  void toggleMealFavouriteStatus(Meal meal) {
    final isExisting = _favouriteMeals.contains(meal);
    if (isExisting) {
      setState(() {
        _showInfoMessage(meal.title + " is no longer favourite");
        _favouriteMeals.remove(meal);
      });
    } else {
      setState(() {
        _showInfoMessage(meal.title + " is added to favourite");
        _favouriteMeals.add(meal);
      });
    }
  }

  void _setScreen(String identifier) {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (ctx) => FiltersScreen()));
    }
  }

  @override
  Widget build(context) {
    String activePageTitle = "Pick your Category";
    Widget activePage = CategoriesScreen(
      ontoggleFavourite: toggleMealFavouriteStatus,
    );
    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        Meals: _favouriteMeals,
        ontoggleFavourite: toggleMealFavouriteStatus,
      );
      activePageTitle = "Favorite";
    }
    return Scaffold(
      appBar: AppBar(title: Text(activePageTitle)),
      drawer: MainDrawer(onSelectScreen: _setScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          _SelectPage(index);
        },
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: "Categories",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favorites"),
        ],
      ),
    );
  }
}
