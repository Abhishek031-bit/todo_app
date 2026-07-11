// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:todo_app/models/enums.dart';

class TodoModel {
  final int id;
  final String title;
  final String description;
  final bool isDone;
  final Category category;
  final Priority priority;
  final DateTime dueDate;
  final DateTime? reminderDate;

  TodoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.isDone,
    required this.category,
    required this.priority,
    required this.dueDate,
    required this.reminderDate,
  });

  TodoModel copyWith({
    int? id,
    String? title,
    String? description,
    bool? isDone,
    Category? category,
    Priority? priority,
    DateTime? dueDate,
    DateTime? reminderDate,
  }) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
      category: category ?? this.category,
      priority: priority ?? this.priority,
      dueDate: dueDate ?? this.dueDate,
      reminderDate: reminderDate ?? this.reminderDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'is_done': isDone ? 1 : 0,
      'category': category.name,
      'priority': priority.name,
      'due_date': dueDate.millisecondsSinceEpoch,
      'reminder_date': reminderDate?.millisecondsSinceEpoch,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      isDone: map['is_done'] as int == 1,
      category: Category.fromString(map['category'] as String),
      priority: Priority.fromString(map['priority'] as String),
      dueDate: DateTime.fromMillisecondsSinceEpoch(map['due_date'] as int),
      reminderDate: map['reminder_date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['reminder_date'] as int)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TodoModel.fromJson(String source) =>
      TodoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TodoModel(id: $id, title: $title, description: $description, isDone: $isDone, category: $category, priority: $priority, dueDate: $dueDate, reminderDate: $reminderDate)';
  }

  @override
  bool operator ==(covariant TodoModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description &&
        other.isDone == isDone &&
        other.category == category &&
        other.priority == priority &&
        other.dueDate == dueDate &&
        other.reminderDate == reminderDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        isDone.hashCode ^
        category.hashCode ^
        priority.hashCode ^
        dueDate.hashCode ^
        reminderDate.hashCode;
  }
}
