// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_actions_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(todoActions)
final todoActionsProvider = TodoActionsProvider._();

final class TodoActionsProvider
    extends $FunctionalProvider<TodoActions, TodoActions, TodoActions>
    with $Provider<TodoActions> {
  TodoActionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'todoActionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$todoActionsHash();

  @$internal
  @override
  $ProviderElement<TodoActions> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TodoActions create(Ref ref) {
    return todoActions(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TodoActions value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TodoActions>(value),
    );
  }
}

String _$todoActionsHash() => r'b49435b23538e14ebc67d091d8dc1f5c9c7b6705';
