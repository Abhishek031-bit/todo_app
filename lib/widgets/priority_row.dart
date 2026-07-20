import 'package:flutter/material.dart';
import 'package:todo_app/models/enums.dart';

class PriorityRow extends StatelessWidget {
  const PriorityRow({super.key, required this.priority});

  final Priority priority;

  @override
  Widget build(BuildContext context) {
    switch (priority) {
      case .high:
        return const Row(
          spacing: 5,
          children: [
            Icon(Icons.arrow_upward_rounded, color: Colors.yellow),
            Text('High', style: TextStyle(color: Colors.yellow)),
          ],
        );
      case .medium:
        return const Row(
          spacing: 3,
          children: [
            Icon(Icons.remove, color: Colors.blue),
            Text('Medium', style: TextStyle(color: Colors.blue)),
          ],
        );
      case .low:
        return const Row(
          spacing: 3,
          children: [
            Icon(Icons.arrow_downward_rounded, color: Colors.blueGrey),
            Text('Low', style: TextStyle(color: Colors.blueGrey)),
          ],
        );
      case .urgent:
        return const Row(
          spacing: 3,
          children: [
            Icon(Icons.priority_high, color: Colors.red),
            Text('Urgent', style: TextStyle(color: Colors.red)),
          ],
        );
    }
  }
}
