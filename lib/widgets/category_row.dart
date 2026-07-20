import 'package:flutter/material.dart';
import 'package:todo_app/models/enums.dart';

class CategoryRow extends StatelessWidget {
  const CategoryRow({super.key, required this.category});

  final Category category;

  @override
  Widget build(BuildContext context) {
    switch (category) {
      case .general:
        return const Row(
          spacing: 5,
          children: [
            Icon(Icons.category, color: Colors.brown),
            Text('General', style: TextStyle(color: Colors.brown)),
          ],
        );
      case .work:
        return const Row(
          spacing: 3,
          children: [
            Icon(Icons.work, color: Colors.teal),
            Text('Work', style: TextStyle(color: Colors.teal)),
          ],
        );
      case .personal:
        return const Row(
          spacing: 3,
          children: [
            Icon(Icons.person, color: Colors.blue),
            Text('Personal', style: TextStyle(color: Colors.blue)),
          ],
        );
      case .finances:
        return const Row(
          spacing: 3,
          children: [
            Icon(Icons.monetization_on_outlined, color: Colors.green),
            Text('Finances', style: TextStyle(color: Colors.green)),
          ],
        );
      case .health:
        return const Row(
          spacing: 3,
          children: [
            Icon(Icons.health_and_safety, color: Colors.red),
            Text('Health', style: TextStyle(color: Colors.red)),
          ],
        );
    }
  }
}
