import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_app/models/enums.dart';
import 'package:todo_app/models/filter_state.dart';

part 'filter_notifier.g.dart';

@riverpod
class FilterNotifier extends _$FilterNotifier {
  @override
  FilterState build() => const FilterState();

  void setCategoryFilter(Category category) {
    state = state.copyWith(categories: {...(state.categories), category});
  }

  void removeCategoryFilter(Category category) {
    state = state.copyWith(categories: state.categories.where((cat) => cat != category).toSet());
  }

  void setPriorityFilter(Priority priority) {
    state = state.copyWith(priorities: {...(state.priorities), priority});
  }

  void removePriorityFilter(Priority priority) {
    state = state.copyWith(
      priorities: state.priorities.where((prior) => prior != priority).toSet(),
    );
  }

  void clearFilters() {
    state = const FilterState();
  }
}
