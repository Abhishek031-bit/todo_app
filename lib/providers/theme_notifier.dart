import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/providers/providers.dart';

part 'theme_notifier.g.dart';

@riverpod
class ThemeNotifier extends _$ThemeNotifier {
  late SharedPreferences _sharedPreferences;
  static const _key = 'theme';
  @override
  ThemeMode build() {
    _sharedPreferences = ref.watch(sharedPreferencesProvider);
    final theme = _sharedPreferences.getString(_key);
    if (theme == 'dark') {
      return .dark;
    } else {
      return .light;
    }
  }

  Future<void> setTheme(ThemeMode theme) async {
    await _sharedPreferences.setString(_key, theme.name);
    state = theme;
  }
}
