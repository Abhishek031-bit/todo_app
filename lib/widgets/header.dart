import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/providers/providers.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    const verticalDivider = VerticalDivider(
      width: 30,
      thickness: 30,
      indent: 1,
      endIndent: 1,
      color: Colors.black,
    );
    return Padding(
      padding: const .all(10.0),
      child: Column(
        spacing: 15,
        children: [
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              FittedBox(
                alignment: .centerLeft,
                child: Consumer(
                  builder: (context, ref, child) {
                    final greeting = ref.watch(greetingProvider);
                    return greeting.when(
                      data: (data) => Text(
                        'Hello, $data 👋',
                        style: const TextStyle(fontSize: 35, fontWeight: .bold),
                      ),
                      error: (error, stackTrace) => const Text('Hello'),
                      loading: () => const Text('Hello'),
                    );
                  },
                ),
              ),
              Consumer(
                builder: (context, ref, child) {
                  final filter = ref.watch(filterProvider);
                  if (filter.categories.isNotEmpty || filter.priorities.isNotEmpty) {
                    return ElevatedButton.icon(
                      onPressed: ref.read(filterProvider.notifier).clearFilters,
                      label: const Text('Clear Filters'),
                      icon: const Icon(Icons.filter_alt_off_outlined),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(border: .all(width: 1.5), borderRadius: .circular(10)),
            child: Consumer(
              builder: (context, ref, child) {
                final todosAsync = ref.watch(todosProvider);
                return todosAsync.when(
                  data: (todos) {
                    final total = todos.length;
                    final completed = todos.where((todo) => todo.isDone).length;
                    final incomplete = total - completed;
                    final overdue = todos
                        .where((todo) => todo.dueDate.isBefore(DateTime.now()))
                        .length;
                    return Row(
                      mainAxisAlignment: .spaceEvenly,
                      children: [
                        TodoStat(
                          icon: Icons.account_box,
                          count: total,
                          title: 'Total',
                          color: Colors.brown,
                        ),
                        verticalDivider,
                        TodoStat(
                          icon: Icons.circle_outlined,
                          count: incomplete,
                          title: 'Incomplete',
                          color: Colors.red,
                        ),
                        verticalDivider,
                        TodoStat(
                          icon: Icons.check_circle,
                          count: completed,
                          title: 'Completed',
                          color: Colors.green,
                        ),
                        verticalDivider,
                        TodoStat(
                          icon: Icons.warning,
                          count: overdue,
                          title: 'Overdue',
                          color: Colors.grey,
                        ),
                      ],
                    );
                  },
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (error, stackTrace) => Center(child: Text('Error: $error')),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

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
