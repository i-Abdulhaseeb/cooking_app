import 'package:cooking_app/data/dummy_data.dart';
import 'package:cooking_app/models/meal.dart';
import 'package:cooking_app/screens/categories.dart';
import 'package:cooking_app/screens/filters.dart';
import 'package:cooking_app/screens/meals.dart';
import 'package:cooking_app/widgets/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:cooking_app/screens/filters.dart';

const kInitialFilter = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});
  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  Map<Filter, bool> _selectedFilters = kInitialFilter;
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

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(currentFilters: _selectedFilters),
        ),
      );
      setState(() {
        _selectedFilters = result ?? kInitialFilter;
      });
    }
  }

  @override
  Widget build(context) {
    final availableMeals = dummyMeals.where((meal) {
      if (_selectedFilters[Filter.glutenFree]! == true &&
          meal.isGlutenFree == false) {
        return false;
      }
      if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilters[Filter.vegetarian]! == true &&
          meal.isVegetarian == false) {
        return false;
      }
      if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();
    String activePageTitle = "Pick your Category";
    Widget activePage = CategoriesScreen(
      ontoggleFavourite: toggleMealFavouriteStatus,
      availableMeals: availableMeals,
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
