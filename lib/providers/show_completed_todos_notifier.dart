import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/providers/shared_preference_provider.dart';

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

  Future<void> toggle() async {
    state = !state;
    await _sharedPreferences.setBool(_key, state);
  }
}
