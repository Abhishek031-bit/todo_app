import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/providers/shared_preference_provider.dart';
import 'package:todo_app/providers/theme_notifier.dart';
import 'package:todo_app/screens/home_screen.dart';
import 'package:todo_app/theme/dark_theme.dart';
import 'package:todo_app/theme/light_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(sharedPreferences)],
      child: const MyApp(),
    ),
  );
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
