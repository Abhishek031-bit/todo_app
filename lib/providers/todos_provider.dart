import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/providers/filter_notifier.dart';
import 'package:todo_app/providers/todo_notifier.dart';

part 'todos_provider.g.dart';

@riverpod
List<TodoModel> todos(Ref ref) {
  final todos = ref.watch(todoProvider);
  final filterState = ref.watch(filterProvider);
  if (filterState.categories.isEmpty && filterState.priorities.isEmpty) {
    return todos;
  } else if (filterState.categories.isNotEmpty && filterState.priorities.isEmpty) {
    return todos.where((todo) => filterState.categories.contains(todo.category)).toList();
  } else if (filterState.categories.isEmpty && filterState.priorities.isNotEmpty) {
    return todos.where((todo) => filterState.priorities.contains(todo.priority)).toList();
  } else {
    return todos
        .where(
          (todo) =>
              filterState.categories.contains(todo.category) ||
              filterState.priorities.contains(todo.priority),
        )
        .toList();
  }
}
