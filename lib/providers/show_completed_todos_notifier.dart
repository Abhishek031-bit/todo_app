import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'show_completed_todos_notifier.g.dart';

@Riverpod(keepAlive: true)
class ShowCompletedTodosNotifier extends _$ShowCompletedTodosNotifier {
  @override
  bool build() => true;

  void toggle() => state = !state;
}
