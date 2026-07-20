import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/providers/providers.dart';
import 'package:todo_app/widgets/widgets.dart';

class TodoList extends HookConsumerWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.heightOf(context) * .2,
          child: const Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Text('Todos', style: TextStyle(fontSize: 30, fontWeight: .bold)),
              FilterButton(),
            ],
          ),
        ),
        Expanded(
          child: Consumer(
            builder: (context, ref, child) {
              final todosAsync = ref.watch(filteredTodosProvider);
              return todosAsync.when(
                data: (todos) {
                  if (todos.isEmpty) {
                    return const Center(child: Text('No todos. Add some'));
                  }
                  return ListView.builder(
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      final todo = todos[index];
                      return TodoCard(todo: todo);
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => Center(child: Text('Error: $err')),
              );
            },
          ),
        ),
      ],
    );
  }
}
