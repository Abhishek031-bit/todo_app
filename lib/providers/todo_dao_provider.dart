import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_app/database/database.dart';
import 'package:todo_app/providers/providers.dart';

part 'todo_dao_provider.g.dart';

@riverpod
TodoDao todoDao(Ref ref) {
  return ref.watch(databaseProvider).todoDao;
}
