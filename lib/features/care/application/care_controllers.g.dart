// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'care_controllers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(careSync)
final careSyncProvider = CareSyncProvider._();

final class CareSyncProvider
    extends $FunctionalProvider<CareSync, CareSync, CareSync>
    with $Provider<CareSync> {
  CareSyncProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'careSyncProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$careSyncHash();

  @$internal
  @override
  $ProviderElement<CareSync> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CareSync create(Ref ref) {
    return careSync(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CareSync value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CareSync>(value),
    );
  }
}

String _$careSyncHash() => r'dcfec75d8c59c6bf79d87ad7b768de171c8ad363';

@ProviderFor(notificationSync)
final notificationSyncProvider = NotificationSyncProvider._();

final class NotificationSyncProvider
    extends
        $FunctionalProvider<
          NotificationSync,
          NotificationSync,
          NotificationSync
        >
    with $Provider<NotificationSync> {
  NotificationSyncProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationSyncProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationSyncHash();

  @$internal
  @override
  $ProviderElement<NotificationSync> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  NotificationSync create(Ref ref) {
    return notificationSync(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationSync value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotificationSync>(value),
    );
  }
}

String _$notificationSyncHash() => r'40e39f5f7f90324e248f7653fe6062c052d80e17';

/// Watched by the app root: reconciles care plans whenever plantings change,
/// and mirrors pending tasks into digest notifications whenever tasks or
/// reminder settings change.

@ProviderFor(careAutomation)
final careAutomationProvider = CareAutomationProvider._();

/// Watched by the app root: reconciles care plans whenever plantings change,
/// and mirrors pending tasks into digest notifications whenever tasks or
/// reminder settings change.

final class CareAutomationProvider extends $FunctionalProvider<void, void, void>
    with $Provider<void> {
  /// Watched by the app root: reconciles care plans whenever plantings change,
  /// and mirrors pending tasks into digest notifications whenever tasks or
  /// reminder settings change.
  CareAutomationProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'careAutomationProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$careAutomationHash();

  @$internal
  @override
  $ProviderElement<void> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  void create(Ref ref) {
    return careAutomation(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$careAutomationHash() => r'5e10ee5ccfea942e2da80830743b7b1b09299ab3';
