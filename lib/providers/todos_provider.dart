import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/database/app_database.dart';
import 'package:todo_app/providers/todo_dao_provider.dart';

final todosProvider = StreamProvider<List<Todo>>((ref) {
  return ref.watch(todoDaoProvider).watchAllTodos();
});
