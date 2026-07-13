// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TodoModel _$TodoModelFromJson(Map<String, dynamic> json) => _TodoModel(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  description: json['description'] as String,
  isDone: json['is_done'] as bool? ?? false,
  category: $enumDecode(_$CategoryEnumMap, json['category']),
  priority: $enumDecode(_$PriorityEnumMap, json['priority']),
  dueDate: DateTime.parse(json['due_date'] as String),
  reminderDate: json['reminder_date'] == null
      ? null
      : DateTime.parse(json['reminder_date'] as String),
);

Map<String, dynamic> _$TodoModelToJson(_TodoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'is_done': instance.isDone,
      'category': _$CategoryEnumMap[instance.category]!,
      'priority': _$PriorityEnumMap[instance.priority]!,
      'due_date': instance.dueDate.toIso8601String(),
      'reminder_date': instance.reminderDate?.toIso8601String(),
    };

const _$CategoryEnumMap = {
  Category.general: 'general',
  Category.work: 'work',
  Category.personal: 'personal',
  Category.finances: 'finances',
  Category.health: 'health',
};

const _$PriorityEnumMap = {
  Priority.high: 'high',
  Priority.medium: 'medium',
  Priority.low: 'low',
  Priority.urgent: 'urgent',
};
