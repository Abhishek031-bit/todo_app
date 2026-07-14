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
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return BottomSheet(
              elevation: 10,
              onClosing: () {
                Navigator.pop(context);
              },
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Category'),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.2,
                        child: Consumer(
                          builder: (context, ref, child) {
                            final filter = ref.watch(filterProvider);
                            return Wrap(
                              children: [
                                for (final category in Category.values)
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: FilterChip(
                                      label: Text(
                                        category.name[0].toUpperCase() +
                                            category.name.substring(1),
                                      ),
                                      selected: filter.categories.contains(category),
                                      onSelected: (v) {
                                        ref
                                            .read(filterProvider.notifier)
                                            .toggleCategory(category);
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
                        height: MediaQuery.sizeOf(context).height * 0.2,
                        child: Consumer(
                          builder: (context, ref, child) {
                            final filter = ref.watch(filterProvider);
                            return Wrap(
                              children: [
                                for (final priority in Priority.values)
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: FilterChip(
                                      label: Text(
                                        priority.name[0].toUpperCase() +
                                            priority.name.substring(1),
                                      ),
                                      selected: filter.priorities.contains(priority),
                                      onSelected: (v) {
                                        ref
                                            .read(filterProvider.notifier)
                                            .togglePriority(priority);
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
        );
      },
      label: const Text('Filter'),
      icon: const Icon(Icons.filter_alt_outlined),
    );
  }
}
