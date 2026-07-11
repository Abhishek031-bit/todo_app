import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/providers/providers.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings', style: TextStyle(fontSize: 30, fontWeight: .bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          spacing: 12,
          crossAxisAlignment: .start,
          children: [
            const Text('APPEARANCE'),
            ListTile(
              leading: const Icon(Icons.dark_mode_outlined),
              title: const Text('Dark Mode'),
              subtitle: const Text('Use dark theme throughout the app'),
              trailing: Consumer(
                builder: (context, ref, child) {
                  final theme = ref.watch(themeProvider);
                  final isDark = theme == .dark;
                  return Switch(
                    value: isDark,
                    onChanged: (_) =>
                        ref.read(themeProvider.notifier).setTheme(isDark ? .light : .dark),
                  );
                },
              ),
            ),
            const Divider(),
            const Text('TODO DISPLAY'),
            ListTile(
              leading: const Icon(Icons.check_circle_outlined),
              title: const Text('Show Completed Todos'),
              subtitle: const Text('When disabled, completed todos are hidden from the list'),
              trailing: Consumer(
                builder: (context, ref, child) {
                  final show = ref.watch(showCompletedTodosProvider);
                  return Switch(
                    value: show,
                    onChanged: (_) => ref.read(showCompletedTodosProvider.notifier).toggle(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
