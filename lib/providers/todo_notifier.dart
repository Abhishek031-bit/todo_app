import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_app/models/enums.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/providers/database_provider.dart';
import 'package:todo_app/services/todo_service.dart';

part 'todo_notifier.g.dart';

@riverpod
class TodoNotifier extends _$TodoNotifier {
  late TodoService _service;

  @override
  List<TodoModel> build() {
    _service = TodoService(ref.watch(databaseProvider));
    _listTodos();
    return [];
  }

  Future<void> _listTodos() async {
    final result = await _service.getAllTodos();
    state = result.map((e) => TodoModel.fromMap(e)).toList();
  }

  Future<void> addTodo({
    required String title,
    required String description,
    bool isDone = false,
    required Category category,
    required Priority priority,
    required DateTime dueDate,
    DateTime? reminderDate,
  }) async {
    final todo = TodoModel(
      id: DateTime.now().millisecondsSinceEpoch,
      title: title,
      description: description,
      isDone: isDone,
      category: category,
      priority: priority,
      dueDate: dueDate,
      reminderDate: reminderDate,
    );
    await _service.addTodo(todo);
    await _listTodos();
  }

  Future<void> updateTodo(TodoModel todo) async {
    await _service.updateTodo(todo);
    await _listTodos();
  }

  Future<void> deleteTodo(int id) async {
    await _service.deleteTodo(id);
    await _listTodos();
  }
}
