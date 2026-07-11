import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:todo_app/providers/database_provider.dart';
import 'package:todo_app/providers/shared_preference_provider.dart';
import 'package:todo_app/providers/theme_notifier.dart';
import 'package:todo_app/screens/home_screen.dart';
import 'package:todo_app/theme/dark_theme.dart';
import 'package:todo_app/theme/light_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  if (Platform.isWindows) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
  final db = await openDatabase(
    await _databasePath(),
    version: 1,
    onCreate: (db, version) async {
      await db.execute('''CREATE TABLE IF NOT EXISTS todos  (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    description TEXT NOT NULL,
    is_done INTEGER NOT NULL DEFAULT 0 CHECK (is_done IN (0, 1)),
    category INTEGER NOT NULL,
    priority INTEGER NOT NULL,
    due_date INTEGER NOT NULL,
    reminder_date INTEGER
);''');
    },
  );

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
        databaseProvider.overrideWithValue(db),
      ],
      child: const MyApp(),
    ),
  );
}

Future<String> _databasePath() async {
  if (Platform.isAndroid || Platform.isIOS) {
    return join(await getDatabasesPath(), 'todos.db');
  }

  final dir = await getApplicationSupportDirectory();
  return join(dir.path, 'todos.db');
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    return MaterialApp(
      title: 'Todo App',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: theme,
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
