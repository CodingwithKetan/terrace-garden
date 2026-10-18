// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_export_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(fileSharer)
final fileSharerProvider = FileSharerProvider._();

final class FileSharerProvider
    extends $FunctionalProvider<FileSharer, FileSharer, FileSharer>
    with $Provider<FileSharer> {
  FileSharerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fileSharerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fileSharerHash();

  @$internal
  @override
  $ProviderElement<FileSharer> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FileSharer create(Ref ref) {
    return fileSharer(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FileSharer value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FileSharer>(value),
    );
  }
}

String _$fileSharerHash() => r'e34dc47e71363dccc733afba43be3a5f1736f39b';

@ProviderFor(dataExportService)
final dataExportServiceProvider = DataExportServiceProvider._();

final class DataExportServiceProvider
    extends
        $FunctionalProvider<
          DataExportService,
          DataExportService,
          DataExportService
        >
    with $Provider<DataExportService> {
  DataExportServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dataExportServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dataExportServiceHash();

  @$internal
  @override
  $ProviderElement<DataExportService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DataExportService create(Ref ref) {
    return dataExportService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DataExportService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DataExportService>(value),
    );
  }
}

String _$dataExportServiceHash() => r'1908da79c991ed104a281bd0e02170be8861104b';
