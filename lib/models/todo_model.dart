import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_app/models/enums.dart';

part 'todo_model.freezed.dart';
part 'todo_model.g.dart';

@freezed
sealed class TodoModel with _$TodoModel {
  const factory TodoModel({
    required int id,
    required String title,
    required String description,
    @Default(false) @JsonKey(name: 'is_done') bool isDone,
    required Category category,
    required Priority priority,
    @JsonKey(name: 'due_date') required DateTime dueDate,
    @JsonKey(name: 'reminder_date') DateTime? reminderDate,
  }) = _TodoModel;

  factory TodoModel.fromJson(Map<String, dynamic> json) => _$TodoModelFromJson(json);
}
