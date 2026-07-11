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
                  padding: const .all(20.0),
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      const Text('Category'),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.2,
                        child: Consumer(
                          builder: (context, ref, child) {
                            return Wrap(
                              children: [
                                for (final category in Category.values)
                                  Padding(
                                    padding: const .all(12.0),
                                    child: FilterChip(
                                      label: Text(
                                        category.name[0].toUpperCase() + category.name.substring(1),
                                      ),
                                      selected: ref
                                          .read(filterProvider)
                                          .categories
                                          .contains(category),
                                      onSelected: (v) {
                                        if (v) {
                                          ref
                                              .read(filterProvider.notifier)
                                              .setCategoryFilter(category);
                                        } else {
                                          ref
                                              .read(filterProvider.notifier)
                                              .removeCategoryFilter(category);
                                        }
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
                            ref.watch(filterProvider);
                            return Wrap(
                              children: [
                                for (final priority in Priority.values)
                                  Padding(
                                    padding: const .all(12.0),
                                    child: FilterChip(
                                      label: Text(
                                        priority.name[0].toUpperCase() + priority.name.substring(1),
                                      ),
                                      selected: ref
                                          .read(filterProvider)
                                          .priorities
                                          .contains(priority),
                                      onSelected: (v) {
                                        if (v) {
                                          ref
                                              .read(filterProvider.notifier)
                                              .setPriorityFilter(priority);
                                        } else {
                                          ref
                                              .read(filterProvider.notifier)
                                              .removePriorityFilter(priority);
                                        }
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
