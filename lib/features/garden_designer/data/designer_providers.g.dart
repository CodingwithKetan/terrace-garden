// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'designer_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(layoutRepository)
final layoutRepositoryProvider = LayoutRepositoryProvider._();

final class LayoutRepositoryProvider
    extends
        $FunctionalProvider<
          LayoutRepository,
          LayoutRepository,
          LayoutRepository
        >
    with $Provider<LayoutRepository> {
  LayoutRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'layoutRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$layoutRepositoryHash();

  @$internal
  @override
  $ProviderElement<LayoutRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LayoutRepository create(Ref ref) {
    return layoutRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LayoutRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LayoutRepository>(value),
    );
  }
}

String _$layoutRepositoryHash() => r'8d0044ba395a141a924eab1844343fb762698172';

/// The saved elements of a garden's layout, live (for previews and counts).

@ProviderFor(layoutElements)
final layoutElementsProvider = LayoutElementsFamily._();

/// The saved elements of a garden's layout, live (for previews and counts).

final class LayoutElementsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<LayoutElement>>,
          List<LayoutElement>,
          Stream<List<LayoutElement>>
        >
    with
        $FutureModifier<List<LayoutElement>>,
        $StreamProvider<List<LayoutElement>> {
  /// The saved elements of a garden's layout, live (for previews and counts).
  LayoutElementsProvider._({
    required LayoutElementsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'layoutElementsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$layoutElementsHash();

  @override
  String toString() {
    return r'layoutElementsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<LayoutElement>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<LayoutElement>> create(Ref ref) {
    final argument = this.argument as String;
    return layoutElements(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is LayoutElementsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$layoutElementsHash() => r'ac155b49dc03dc328fd8564984d8ce7a3f59aa30';

/// The saved elements of a garden's layout, live (for previews and counts).

final class LayoutElementsFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<LayoutElement>>, String> {
  LayoutElementsFamily._()
    : super(
        retry: null,
        name: r'layoutElementsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// The saved elements of a garden's layout, live (for previews and counts).

  LayoutElementsProvider call(String gardenId) =>
      LayoutElementsProvider._(argument: gardenId, from: this);

  @override
  String toString() => r'layoutElementsProvider';
}
