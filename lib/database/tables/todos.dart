import 'package:drift/drift.dart';
import 'package:todo_app/models/enums.dart';

class Todos extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text()();

  TextColumn get description => text().nullable()();

  BoolColumn get isDone => boolean().named('is_done').withDefault(const Constant(false))();

  IntColumn get category => intEnum<Category>()();

  IntColumn get priority => intEnum<Priority>()();

  DateTimeColumn get dueDate => dateTime().named('due_date').nullable()();

  DateTimeColumn get reminderDate => dateTime().named('reminder_date').nullable()();
}
