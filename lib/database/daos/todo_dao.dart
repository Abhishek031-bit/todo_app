// database/daos/todo_dao.dart

import 'package:drift/drift.dart';
import 'package:todo_app/database/app_database.dart';
import 'package:todo_app/database/tables/todos.dart';

part 'todo_dao.g.dart';

@DriftAccessor(tables: [Todos])
class TodoDao extends DatabaseAccessor<AppDatabase> with _$TodoDaoMixin {
  TodoDao(super.db);

  Future<void> addTodo(TodosCompanion todo) async {
    await into(todos).insert(todo);
  }

  Future<List<Todo>> getAllTodos() {
    return select(todos).get();
  }

  Stream<List<Todo>> watchAllTodos() {
    return select(todos).watch();
  }

  Future<void> updateTodo(Todo todo) async {
    await update(todos).replace(todo);
  }

  Future<void> deleteTodo(int id) async {
    await (delete(todos)..where((t) => t.id.equals(id))).go();
  }
}
