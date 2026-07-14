import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/database/database.dart';
import 'package:todo_app/providers/providers.dart';

final todosProvider = StreamProvider<List<Todo>>((ref) {
  return ref.watch(todoDaoProvider).watchAllTodos();
});
