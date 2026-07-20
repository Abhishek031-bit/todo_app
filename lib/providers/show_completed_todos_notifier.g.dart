// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'show_completed_todos_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ShowCompletedTodosNotifier)
final showCompletedTodosProvider = ShowCompletedTodosNotifierProvider._();

final class ShowCompletedTodosNotifierProvider
    extends $NotifierProvider<ShowCompletedTodosNotifier, bool> {
  ShowCompletedTodosNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'showCompletedTodosProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$showCompletedTodosNotifierHash();

  @$internal
  @override
  ShowCompletedTodosNotifier create() => ShowCompletedTodosNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$showCompletedTodosNotifierHash() =>
    r'8d3d057c559c703b57eb9fa4faacbd1b92e5fe4a';

abstract class _$ShowCompletedTodosNotifier extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
