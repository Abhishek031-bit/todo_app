import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_app/models/enums.dart';
import 'package:todo_app/models/filter_state.dart';

part 'filter_notifier.g.dart';

@riverpod
class FilterNotifier extends _$FilterNotifier {
  @override
  FilterState build() => const FilterState();

  void toggleCategory(Category category) {
    final categories = {...state.categories};

    if (categories.contains(category)) {
      categories.remove(category);
    } else {
      categories.add(category);
    }

    state = state.copyWith(categories: categories);
  }

  void togglePriority(Priority priority) {
    final priorities = {...state.priorities};

    if (priorities.contains(priority)) {
      priorities.remove(priority);
    } else {
      priorities.add(priority);
    }

    state = state.copyWith(priorities: priorities);
  }

  void clearFilters() {
    state = const FilterState();
  }
}
