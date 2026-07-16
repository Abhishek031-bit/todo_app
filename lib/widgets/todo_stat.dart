import 'package:flutter/material.dart';

class TodoStat extends StatelessWidget {
  const TodoStat({
    super.key,
    required this.icon,
    required this.count,
    required this.title,
    required this.color,
  });
  final IconData icon;
  final int count;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5,
      children: [
        Icon(icon, color: color),
        Text('$count', style: TextStyle(color: color)),
        Text(title),
      ],
    );
  }
}
