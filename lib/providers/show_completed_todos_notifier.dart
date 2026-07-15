import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'providers.dart';

part 'show_completed_todos_notifier.g.dart';

@riverpod
class ShowCompletedTodosNotifier extends _$ShowCompletedTodosNotifier {
  late final SharedPreferences _sharedPreferences;
  static const _key = 'show_completed_todos';
  @override
  bool build() {
    _sharedPreferences = ref.watch(sharedPreferencesProvider);
    return _sharedPreferences.getBool(_key) ?? true;
  }

  void toggle() {
    state = !state;
    _sharedPreferences.setBool(_key, state);
  }
}
