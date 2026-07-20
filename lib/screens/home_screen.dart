import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:todo_app/screens/settings_screen.dart';
import 'package:todo_app/screens/todo_screen.dart';
import 'package:todo_app/widgets/widgets.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  static const _pages = [TodoScreen(), SettingsScreen()];

  @override
  Widget build(BuildContext context) {
    final index = useState(0);
    return Scaffold(
      body: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 300),
        child: _pages[index.value],
      ),
      floatingActionButton: index.value == 0
          ? Tooltip(
              message: 'Create a new Todo',
              child: FloatingActionButton(
                shape: const CircleBorder(),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CreateTodo()),
                  );
                },
                child: const Icon(Icons.add),
              ),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) => index.value = value,
        currentIndex: index.value,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.fact_check_outlined), label: 'Todos'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}
