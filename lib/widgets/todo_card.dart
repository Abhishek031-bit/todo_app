import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/database/database.dart';
import 'package:todo_app/providers/providers.dart';
import 'package:todo_app/widgets/widgets.dart';

class TodoCard extends HookConsumerWidget {
  const TodoCard({super.key, required this.todo});
  final Todo todo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final show = ref.watch(showCompletedTodosProvider);
    if (!show && todo.isDone) return const SizedBox.shrink();
    final completed = useState(todo.isDone);
    final TextDecoration decoration = completed.value ? .lineThrough : .none;
    final FontStyle fontStyle = completed.value ? .italic : .normal;
    final key = useMemoized(() => ValueKey(todo.id));
    return Slidable(
      key: key,
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            flex: 2,
            onPressed: (context) {
              ref.read(todoActionsProvider).deleteTodo(todo.id);
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
                ref.read(todoActionsProvider).updateTodo(todo.copyWith(isDone: completed.value));
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
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: .w700,
                      decoration: decoration,
                      fontStyle: fontStyle,
                    ),
                  ),
                  Text(
                    todo.description,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: .w500,
                      decoration: decoration,
                      fontStyle: fontStyle,
                    ),
                  ),
                  Row(
                    spacing: 3,
                    children: [
                      CategoryRow(category: todo.category),
                      const SizedBox(width: 7),
                      PriorityRow(priority: todo.priority),
                      const SizedBox(width: 7),
                      const Icon(Icons.date_range_rounded),
                      const SizedBox(width: 7),
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
              icon: const Tooltip(message: 'Update this todo', child: Icon(Icons.update_rounded)),
            ),
          ],
        ),
      ),
    );
  }
}
