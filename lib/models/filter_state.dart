import 'package:todo_app/models/enums.dart';

class FilterState {
  final Set<Category> categories;
  final Set<Priority> priorities;

  const FilterState({this.categories = const {}, this.priorities = const {}});

  FilterState copyWith({Set<Category>? categories, Set<Priority>? priorities}) {
    return FilterState(
      categories: categories ?? this.categories,
      priorities: priorities ?? this.priorities,
    );
  }
}
