import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/models/enums.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/providers/providers.dart';

class CreateTodo extends HookConsumerWidget {
  const CreateTodo({super.key, this.saveAction = .add, this.todo});
  final SaveAction saveAction;
  final TodoModel? todo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleController = useTextEditingController(text: todo?.title ?? '');
    final descriptionController = useTextEditingController(text: todo?.description ?? '');
    var category = todo?.category ?? .general;
    var priority = todo?.priority ?? .low;
    final dueDateController = useTextEditingController(
      text: todo?.dueDate == null ? '' : DateFormat('yMMMd').format(todo!.dueDate),
    );
    final reminderDateController = useTextEditingController(
      text: todo?.reminderDate == null ? '' : DateFormat('yMMMd').format(todo!.reminderDate!),
    );
    final key = useMemoized(() => GlobalKey<FormState>());
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
        padding: const EdgeInsets.all(12.0),
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
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  errorStyle: TextStyle(color: Colors.red),
                ),
              ),
              TextFormField(
                maxLines: 3,
                controller: descriptionController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Description is required';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  errorStyle: TextStyle(color: Colors.red),
                ),
              ),
              DropdownButtonFormField<Category>(
                initialValue: .general,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  labelText: 'Category',
                ),
                items: [
                  const DropdownMenuItem(
                    value: .general,
                    child: Row(spacing: 10, children: [Icon(Icons.category), Text('General')]),
                  ),
                  const DropdownMenuItem(
                    value: .work,
                    child: Row(spacing: 10, children: [Icon(Icons.work), Text('Work')]),
                  ),
                  const DropdownMenuItem(
                    value: .personal,
                    child: Row(spacing: 10, children: [Icon(Icons.person), Text('Personal')]),
                  ),
                  const DropdownMenuItem(
                    value: .finances,
                    child: Row(
                      spacing: 10,
                      children: [Icon(Icons.monetization_on_outlined), Text('Finances')],
                    ),
                  ),
                  const DropdownMenuItem(
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
                initialValue: .low,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  labelText: 'Priority',
                ),
                items: [
                  const DropdownMenuItem(
                    value: .low,
                    child: Row(
                      spacing: 10,
                      children: [Icon(Icons.arrow_downward_rounded), Text('Low')],
                    ),
                  ),
                  const DropdownMenuItem(
                    value: .medium,
                    child: Row(spacing: 10, children: [Icon(Icons.remove), Text('Medium')]),
                  ),
                  const DropdownMenuItem(
                    value: .high,
                    child: Row(
                      spacing: 10,
                      children: [Icon(Icons.arrow_upward_rounded), Text('High')],
                    ),
                  ),

                  const DropdownMenuItem(
                    value: .urgent,
                    child: Row(spacing: 10, children: [Icon(Icons.priority_high), Text('Urgent')]),
                  ),
                ],
                onChanged: (v) {
                  priority = v!;
                },
              ),
              TextFormField(
                readOnly: true,
                controller: dueDateController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Due Date is required';
                  }
                  return null;
                },
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    firstDate: .now(),
                    lastDate: .now().add(const Duration(days: 90)),
                  );
                  if (date == null) return;
                  dueDateController.text = DateFormat.yMMMd().format(date);
                },
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  errorBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  errorStyle: const TextStyle(color: Colors.red),
                  prefixIcon: const Icon(Icons.calendar_month),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: dueDateController.clear,
                  ),
                  labelText: 'Due Date',
                ),
              ),
              TextFormField(
                readOnly: true,
                controller: reminderDateController,
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    firstDate: .now(),
                    lastDate: .now().add(const Duration(days: 90)),
                  );
                  if (date == null) return;
                  reminderDateController.text = DateFormat.yMMMd().format(date);
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  errorStyle: TextStyle(color: Colors.red),
                  prefixIcon: Icon(Icons.alarm),
                  labelText: 'Reminder Date',
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (key.currentState!.validate()) {
                    switch (saveAction) {
                      case .add:
                        ref
                            .read(todoProvider.notifier)
                            .addTodo(
                              title: titleController.text,
                              description: descriptionController.text,
                              category: category,
                              priority: priority,
                              dueDate: DateFormat('yMMMd').parse(dueDateController.text),
                            );
                        final snackBar = SnackBar(
                          elevation: 0,
                          behavior: .floating,
                          backgroundColor: Colors.transparent,
                          content: AwesomeSnackbarContent(
                            title: 'Success',
                            message: 'Todo Added Successfully!',
                            contentType: .success,
                          ),
                        );
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(snackBar);
                      case .update:
                        ref
                            .read(todoProvider.notifier)
                            .updateTodo(
                              todo!.copyWith(
                                title: titleController.text,
                                description: descriptionController.text,
                                category: category,
                                priority: priority,
                                dueDate: DateFormat('yMMMd').parse(dueDateController.text),
                                reminderDate: reminderDateController.text.isEmpty
                                    ? null
                                    : DateFormat('yMMMd').parse(reminderDateController.text),
                              ),
                            );
                        final snackBar = SnackBar(
                          elevation: 0,
                          behavior: .floating,
                          backgroundColor: Colors.transparent,
                          content: AwesomeSnackbarContent(
                            title: 'Update',
                            message: 'Todo Updated Successfully!',
                            contentType: .success,
                          ),
                        );
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(snackBar);
                    }
                    Navigator.pop(context);
                  }
                },
                child: Container(
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Colors.brown,
                    borderRadius: .all(.circular(10)),
                  ),
                  child: const Row(
                    mainAxisAlignment: .center,
                    spacing: 15,
                    children: [
                      Icon(Icons.save, color: Colors.white),
                      Text('Save', style: TextStyle(color: Colors.white, fontSize: 20)),
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
