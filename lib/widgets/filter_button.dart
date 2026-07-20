import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/models/enums.dart';
import 'package:todo_app/providers/providers.dart';

class FilterButton extends ConsumerWidget {
  const FilterButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton.icon(
      onPressed: () {
        showModalBottomSheet<void>(
          context: context,
          builder: (context) {
            return Padding(
              padding: const .all(20),
              child: Column(
                mainAxisSize: .min,
                crossAxisAlignment: .start,
                children: [
                  const Text('Category'),
                  SizedBox(
                    height: MediaQuery.heightOf(context) * 0.2,
                    child: Consumer(
                      builder: (context, ref, child) {
                        final filter = ref.watch(filterProvider);

                        return Wrap(
                          children: [
                            for (final category in Category.values)
                              Padding(
                                padding: const .all(12),
                                child: FilterChip(
                                  label: Text(
                                    '${category.name[0].toUpperCase()}${category.name.substring(1)}',
                                  ),
                                  selected: filter.categories.contains(category),
                                  onSelected: (_) {
                                    ref.read(filterProvider.notifier).toggleCategory(category);
                                  },
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                  const Divider(),
                  const Text('Priority'),
                  SizedBox(
                    height: MediaQuery.heightOf(context) * 0.2,
                    child: Consumer(
                      builder: (context, ref, child) {
                        final filter = ref.watch(filterProvider);

                        return Wrap(
                          children: [
                            for (final priority in Priority.values)
                              Padding(
                                padding: const .all(12),
                                child: FilterChip(
                                  label: Text(
                                    '${priority.name[0].toUpperCase()}${priority.name.substring(1)}',
                                  ),
                                  selected: filter.priorities.contains(priority),
                                  onSelected: (_) {
                                    ref.read(filterProvider.notifier).togglePriority(priority);
                                  },
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
      icon: const Icon(Icons.filter_alt_outlined),
      label: const Text('Filter'),
    );
  }
}
