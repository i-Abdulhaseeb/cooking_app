import 'package:cooking_app/screens/categories.dart';
import 'package:cooking_app/screens/filters.dart';
import 'package:cooking_app/screens/meals.dart';
import 'package:cooking_app/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cooking_app/providers/favorites_provider.dart';
import 'package:cooking_app/providers/filters_provider.dart';

const kInitialFilter = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});
  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;
  void _SelectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(builder: (ctx) => const FiltersScreen()),
      );
    }
  }

  @override
  Widget build(context) {
    final availableMeals = ref.watch(filteredMealsProvider);
    String activePageTitle = "Pick your Category";
    Widget activePage = CategoriesScreen(availableMeals: availableMeals);
    if (_selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activePage = MealsScreen(Meals: favoriteMeals);
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
