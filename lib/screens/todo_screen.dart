import 'package:flutter/material.dart';
import 'package:todo_app/widgets/widgets.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Header(),
          Expanded(child: TodoList()),
        ],
      ),
    );
  }
}
