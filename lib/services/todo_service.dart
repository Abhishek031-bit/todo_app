import 'package:sqflite/sqflite.dart';
import 'package:todo_app/models/todo_model.dart';

class TodoService {
  final Database db;
  const TodoService(this.db);

  Future<void> addTodo(TodoModel todo) async {
    await db.insert('todos', todo.toMap());
  }

  Future<List<Map<String, Object?>>> getAllTodos() async {
    return await db.query('todos');
  }

  Future<void> updateTodo(TodoModel todo) async {
    await db.update('todos', todo.toMap(), where: 'id = ?', whereArgs: [todo.id]);
  }

  Future<void> deleteTodo(int id) async {
    await db.delete('todos', where: 'id = ?', whereArgs: [id]);
  }
}
