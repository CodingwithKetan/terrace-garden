// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_reset_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(dataResetService)
final dataResetServiceProvider = DataResetServiceProvider._();

final class DataResetServiceProvider
    extends
        $FunctionalProvider<
          DataResetService,
          DataResetService,
          DataResetService
        >
    with $Provider<DataResetService> {
  DataResetServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dataResetServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dataResetServiceHash();

  @$internal
  @override
  $ProviderElement<DataResetService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DataResetService create(Ref ref) {
    return dataResetService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DataResetService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DataResetService>(value),
    );
  }
}

String _$dataResetServiceHash() => r'2932db50568dfa544f31a714ea0a655a6c26bd5e';
