import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';

class DateController extends HookWidget {
  const DateController({super.key, required this.controller, this.labelText = 'Due Date'});

  final TextEditingController controller;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    final value = useValueListenable(controller);
    return TextFormField(
      readOnly: true,
      controller: controller,
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          firstDate: .now(),
          lastDate: .now().add(const Duration(days: 90)),
        );
        if (date == null) return;
        controller.text = DateFormat.yMMMd().format(date);
      },
      decoration: InputDecoration(
        border: const OutlineInputBorder(borderRadius: .all(.circular(10))),
        errorBorder: const OutlineInputBorder(
          borderRadius: .all(.circular(10)),
          borderSide: BorderSide(color: Colors.red),
        ),
        errorStyle: const TextStyle(color: Colors.red),
        prefixIcon: const Icon(Icons.calendar_month),
        suffixIcon: value.text.isEmpty
            ? null
            : IconButton(icon: const Icon(Icons.close), onPressed: controller.clear),
        labelText: labelText,
      ),
    );
  }
}
