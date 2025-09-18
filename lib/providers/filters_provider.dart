import 'package:cooking_app/providers/meals_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

enum Filter { glutenFree, lactoseFree, vegetarian, vegan }

class filtersNotifier extends StateNotifier<Map<Filter, bool>> {
  filtersNotifier()
    : super({
        Filter.glutenFree: false,
        Filter.lactoseFree: false,
        Filter.vegetarian: false,
        Filter.vegan: false,
      });
  void setFilters(Map<Filter, bool> chosenFilters) {
    state = chosenFilters;
  }

  void setFilter(Filter filter, bool isActive) {
    state = {...state, filter: isActive};
  }
}

final filtersProvider =
    StateNotifierProvider<filtersNotifier, Map<Filter, bool>>(
      (ref) => filtersNotifier(),
    );

final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filtersProvider);
  return meals.where((meal) {
    if (activeFilters[Filter.glutenFree]! == true &&
        meal.isGlutenFree == false) {
      return false;
    }
    if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (activeFilters[Filter.vegetarian]! == true &&
        meal.isVegetarian == false) {
      return false;
    }
    if (activeFilters[Filter.vegan]! && !meal.isVegan) {
      return false;
    }
    return true;
  }).toList();
});
