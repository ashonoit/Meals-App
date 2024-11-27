import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Filter {
  glutenfree,
  lactosefree,
  vegan,
  vegetarian,
}

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
      : super({
          Filter.glutenfree: false,
          Filter.lactosefree: false,
          Filter.vegan: false,
          Filter.vegetarian: false,
        });
  void setFilter(filter, bool isActive) {
    state = {
      ...state,
      filter: isActive,
    };
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
  (ref) => FiltersNotifier(),
);
