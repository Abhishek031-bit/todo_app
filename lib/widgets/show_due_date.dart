import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ShowDueDate extends StatelessWidget {
  const ShowDueDate({super.key, required this.dueDate});
  final DateTime dueDate;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.date_range_rounded),
        const SizedBox(width: 10),
        Text(DateFormat.yMMMd().format(dueDate)),
      ],
    );
  }
}
