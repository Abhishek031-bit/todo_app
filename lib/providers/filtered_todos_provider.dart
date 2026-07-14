import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/database/app_database.dart';
import 'package:todo_app/providers/providers.dart';

final filteredTodosProvider = StreamProvider<List<Todo>>((ref) {
  final filter = ref.watch(filterProvider);

  return ref.watch(todoDaoProvider).watchAllTodos().map((todos) {
    return todos.where((todo) {
      final categoryMatch = filter.categories.isEmpty || filter.categories.contains(todo.category);

      final priorityMatch = filter.priorities.isEmpty || filter.priorities.contains(todo.priority);

      return categoryMatch && priorityMatch;
    }).toList();
  });
});
