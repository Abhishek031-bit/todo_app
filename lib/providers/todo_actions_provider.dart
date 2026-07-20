import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_app/database/database.dart';
import 'package:todo_app/models/enums.dart';
import 'package:todo_app/providers/todo_dao_provider.dart';

part 'todo_actions_provider.g.dart';

class TodoActions {
  const TodoActions(this._dao);

  final TodoDao _dao;

  Future<void> addTodo({
    required String title,
    String? description,
    required Category category,
    required Priority priority,
    DateTime? dueDate,
    DateTime? reminderDate,
  }) {
    return _dao.addTodo(
      TodosCompanion.insert(
        title: title,
        description: Value(description),
        category: category,
        priority: priority,
        dueDate: Value(dueDate),
        reminderDate: Value(reminderDate),
      ),
    );
  }

  Future<void> updateTodo(Todo todo) {
    return _dao.updateTodo(todo);
  }

  Future<void> deleteTodo(int id) {
    return _dao.deleteTodo(id);
  }
}

@riverpod
TodoActions todoActions(Ref ref) {
  return TodoActions(ref.watch(todoDaoProvider));
}
