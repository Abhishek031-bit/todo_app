// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TodoNotifier)
final todoProvider = TodoNotifierProvider._();

final class TodoNotifierProvider
    extends $NotifierProvider<TodoNotifier, List<TodoModel>> {
  TodoNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'todoProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$todoNotifierHash();

  @$internal
  @override
  TodoNotifier create() => TodoNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<TodoModel> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<TodoModel>>(value),
    );
  }
}

String _$todoNotifierHash() => r'c267892fd2809a8dc3fcb9963accb1d6d44a38b1';

abstract class _$TodoNotifier extends $Notifier<List<TodoModel>> {
  List<TodoModel> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<List<TodoModel>, List<TodoModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<TodoModel>, List<TodoModel>>,
              List<TodoModel>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
