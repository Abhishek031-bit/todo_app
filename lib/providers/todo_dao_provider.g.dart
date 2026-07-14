// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_dao_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(todoDao)
final todoDaoProvider = TodoDaoProvider._();

final class TodoDaoProvider
    extends $FunctionalProvider<TodoDao, TodoDao, TodoDao>
    with $Provider<TodoDao> {
  TodoDaoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'todoDaoProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$todoDaoHash();

  @$internal
  @override
  $ProviderElement<TodoDao> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TodoDao create(Ref ref) {
    return todoDao(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TodoDao value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TodoDao>(value),
    );
  }
}

String _$todoDaoHash() => r'9e46131d35dc972e7211ad2fe9cb6d94274a7fd4';
