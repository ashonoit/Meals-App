import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/provider/favourites_provider.dart';
import 'package:meals_app/provider/filters_provider.dart';
import 'package:meals_app/screen/about.dart';
import 'package:meals_app/screen/categories.dart';
import 'package:meals_app/screen/filters.dart';
import 'package:meals_app/screen/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';
import 'package:meals_app/provider/meals_provider.dart';

const kInitialFilters = {
  Filter.glutenfree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
  Filter.lactosefree: false
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
  Map<Filter, bool> _selectedFilters = kInitialFilters;

  void _selectPage(index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String indentifier) async {
    Navigator.of(context).pop();
    if (indentifier == 'filters') {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(
            currentFilters: _selectedFilters,
          ),
        ),
      );
      setState(() {
        _selectedFilters = result ?? kInitialFilters;
      });
    } else if (indentifier == 'about') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => const AboutScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealsProvider);
    final availableMeals = meals.where((meal) {
      if (_selectedFilters[Filter.glutenfree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilters[Filter.lactosefree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      if (_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      return true;
    }).toList();
    var activePageTitle = 'Categories';
    Widget activePage = CategoriesScreen(
      availableMeals: availableMeals,
    );
    if (_selectedPageIndex == 1) {
      final favouriteMeals = ref.watch(favouritesMealsProvider);
      activePage = MealsScreen(
        meals: favouriteMeals,
      );
      activePageTitle = 'Your Favourites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.food_bank_outlined), label: 'Categories'),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_border),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
