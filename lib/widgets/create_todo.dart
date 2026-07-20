import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/core/core.dart';
import 'package:todo_app/database/database.dart';
import 'package:todo_app/models/enums.dart';
import 'package:todo_app/providers/providers.dart';
import 'package:todo_app/widgets/date_controller.dart';

class CreateTodo extends HookConsumerWidget {
  const CreateTodo({super.key, this.todo});
  final Todo? todo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleController = useTextEditingController(text: todo?.title);
    final descriptionController = useTextEditingController(text: todo?.description);
    var category = todo?.category ?? .general;
    var priority = todo?.priority ?? .low;
    final dueDateController = useTextEditingController(
      text: todo?.dueDate == null ? '' : DateFormat('yMMMd').format(todo!.dueDate!),
    );
    final reminderDateController = useTextEditingController(
      text: todo?.reminderDate == null ? '' : DateFormat('yMMMd').format(todo!.reminderDate!),
    );
    final key = useMemoized(GlobalKey<FormState>.new);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Todo'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.cancel_sharp),
        ),
      ),
      body: Padding(
        padding: const .all(12.0),
        child: Form(
          key: key,
          child: Column(
            spacing: 15,
            children: [
              const SizedBox(height: 5),
              TextFormField(
                controller: titleController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Title is required';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(borderRadius: .all(.circular(10))),
                  errorBorder: OutlineInputBorder(
                    borderRadius: .all(.circular(10)),
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  errorStyle: TextStyle(color: Colors.red),
                ),
              ),
              TextFormField(
                maxLines: 3,
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(borderRadius: .all(.circular(10))),
                  errorBorder: OutlineInputBorder(
                    borderRadius: .all(.circular(10)),
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  errorStyle: TextStyle(color: Colors.red),
                ),
              ),
              DropdownButtonFormField<Category>(
                initialValue: category,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(borderRadius: .all(.circular(10))),
                  labelText: 'Category',
                ),
                items: const [
                  DropdownMenuItem(
                    value: .general,
                    child: Row(spacing: 10, children: [Icon(Icons.category), Text('General')]),
                  ),
                  DropdownMenuItem(
                    value: .work,
                    child: Row(spacing: 10, children: [Icon(Icons.work), Text('Work')]),
                  ),
                  DropdownMenuItem(
                    value: .personal,
                    child: Row(spacing: 10, children: [Icon(Icons.person), Text('Personal')]),
                  ),
                  DropdownMenuItem(
                    value: .finances,
                    child: Row(
                      spacing: 10,
                      children: [Icon(Icons.monetization_on_outlined), Text('Finances')],
                    ),
                  ),
                  DropdownMenuItem(
                    value: .health,
                    child: Row(
                      spacing: 10,
                      children: [Icon(Icons.health_and_safety), Text('Health')],
                    ),
                  ),
                ],
                onChanged: (v) {
                  category = v!;
                },
              ),
              DropdownButtonFormField<Priority>(
                initialValue: priority,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(borderRadius: .all(.circular(10))),
                  labelText: 'Priority',
                ),
                items: const [
                  DropdownMenuItem(
                    value: .low,
                    child: Row(
                      spacing: 10,
                      children: [Icon(Icons.arrow_downward_rounded), Text('Low')],
                    ),
                  ),
                  DropdownMenuItem(
                    value: .medium,
                    child: Row(spacing: 10, children: [Icon(Icons.remove), Text('Medium')]),
                  ),
                  DropdownMenuItem(
                    value: .high,
                    child: Row(
                      spacing: 10,
                      children: [Icon(Icons.arrow_upward_rounded), Text('High')],
                    ),
                  ),
                  DropdownMenuItem(
                    value: .urgent,
                    child: Row(spacing: 10, children: [Icon(Icons.priority_high), Text('Urgent')]),
                  ),
                ],
                onChanged: (v) {
                  priority = v!;
                },
              ),
              DateController(controller: dueDateController),
              DateController(controller: reminderDateController, labelText: 'Reminder Date'),
              GestureDetector(
                onTap: () async {
                  if (key.currentState!.validate()) {
                    if (todo == null) {
                      await ref
                          .read(todoActionsProvider)
                          .addTodo(
                            title: titleController.text,
                            description: descriptionController.text.isEmpty
                                ? null
                                : descriptionController.text,
                            category: category,
                            priority: priority,
                            dueDate: dueDateController.text.isEmpty
                                ? null
                                : DateFormat('yMMMd').parse(dueDateController.text),
                            reminderDate: reminderDateController.text.isEmpty
                                ? null
                                : DateFormat('yMMMd').parse(reminderDateController.text),
                          );
                      if (!context.mounted) return;
                      showSnackBar(
                        context: context,
                        contentType: .success,
                        title: 'Add',
                        message: 'Todo Added Successfully!',
                      );
                      Navigator.pop(context);
                    } else {
                      await ref
                          .read(todoActionsProvider)
                          .updateTodo(
                            todo!.copyWith(
                              title: titleController.text,
                              description: Value(
                                descriptionController.text.isEmpty
                                    ? null
                                    : descriptionController.text,
                              ),
                              category: category,
                              priority: priority,
                              dueDate: Value(
                                dueDateController.text.isEmpty
                                    ? null
                                    : DateFormat('yMMMd').parse(dueDateController.text),
                              ),
                              reminderDate: Value(
                                reminderDateController.text.isEmpty
                                    ? null
                                    : DateFormat('yMMMd').parse(reminderDateController.text),
                              ),
                            ),
                          );
                      if (!context.mounted) return;
                      showSnackBar(
                        context: context,
                        contentType: .success,
                        title: 'Update',
                        message: 'Todo updated successfully',
                      );
                      Navigator.pop(context);
                    }
                  }
                },
                child: Container(
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Colors.brown,
                    borderRadius: .all(.circular(10)),
                  ),
                  child: Row(
                    mainAxisAlignment: .center,
                    spacing: 15,
                    children: [
                      const Icon(Icons.save, color: Colors.white),
                      Text(
                        todo == null ? 'Save' : 'Update',
                        style: const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
