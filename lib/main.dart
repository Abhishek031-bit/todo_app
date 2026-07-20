import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/providers/providers.dart';
import 'package:todo_app/screens/home_screen.dart';
import 'package:todo_app/theme/theme.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();

  await windowManager.ensureInitialized();

  const options = WindowOptions(minimumSize: Size(600, 480), center: true);

  await windowManager.waitUntilReadyToShow(options, () async {
    await windowManager.show();
    await windowManager.maximize();
    await windowManager.focus();
  });
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
