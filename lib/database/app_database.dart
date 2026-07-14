import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:todo_app/database/daos/todo_dao.dart';
import 'package:todo_app/models/enums.dart';

import 'tables/todos.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Todos], daos: [TodoDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationSupportDirectory();
    await dir.create(recursive: true);
    final file = File(path.join(dir.path, 'todo.db'));
    return NativeDatabase(file);
  });
}
