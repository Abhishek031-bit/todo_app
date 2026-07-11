import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/models/enums.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/providers/providers.dart';
import 'package:todo_app/widgets/create_todo.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoCard extends HookConsumerWidget {
  const TodoCard({super.key, required this.todo});
  final TodoModel todo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final show = ref.watch(showCompletedTodosProvider);
    if (!show && todo.isDone) return const SizedBox.shrink();
    final completed = useState(todo.isDone);
    final TextDecoration decoration = completed.value ? .lineThrough : .none;
    final category = categoryRow(todo.category);
    final priority = priorityRow(todo.priority);
    final key = useMemoized(() => ValueKey(todo.id));
    return Slidable(
      key: key,
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            flex: 2,
            onPressed: (context) {
              ref.read(todoProvider.notifier).deleteTodo(todo.id);
              final snackBar = SnackBar(
                elevation: 0,
                behavior: .floating,
                backgroundColor: Colors.transparent,
                content: AwesomeSnackbarContent(
                  title: 'Delete',
                  message: 'Todo Deleted Successfully!',
                  contentType: .failure,
                ),
              );
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(snackBar);
            },
            backgroundColor: Colors.redAccent,
            foregroundColor: Colors.white,
            borderRadius: .circular(20),
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: Card(
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                completed.value = !completed.value;
                ref.read(todoProvider.notifier).updateTodo(todo.copyWith(isDone: completed.value));
              },
              icon: Icon(completed.value ? Icons.circle : Icons.circle_outlined),
            ),
            Padding(
              padding: const .all(12.0),
              child: Column(
                spacing: 5,
                crossAxisAlignment: .start,
                children: [
                  Text(
                    todo.title,
                    style: TextStyle(fontSize: 18, fontWeight: .w700, decoration: decoration),
                  ),
                  Text(
                    todo.description,
                    style: TextStyle(fontSize: 16, fontWeight: .w500, decoration: decoration),
                  ),
                  Row(
                    spacing: 3,
                    children: [
                      category,
                      const SizedBox(width: 7),
                      priority,
                      const SizedBox(width: 7),
                      const Icon(Icons.date_range_rounded),
                      Text(DateFormat.yMMMd().format(todo.dueDate)),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateTodo(saveAction: .update, todo: todo),
                  ),
                );
              },
              icon: const Icon(Icons.update_rounded),
            ),
          ],
        ),
      ),
    );
  }

  Widget categoryRow(Category category) {
    switch (category) {
      case .general:
        return const Row(
          spacing: 3,
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

  Widget priorityRow(Priority priority) {
    switch (priority) {
      case .high:
        return const Row(
          spacing: 3,
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
