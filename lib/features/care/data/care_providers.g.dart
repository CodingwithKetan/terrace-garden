// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'care_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(careRepository)
final careRepositoryProvider = CareRepositoryProvider._();

final class CareRepositoryProvider
    extends $FunctionalProvider<CareRepository, CareRepository, CareRepository>
    with $Provider<CareRepository> {
  CareRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'careRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$careRepositoryHash();

  @$internal
  @override
  $ProviderElement<CareRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CareRepository create(Ref ref) {
    return careRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CareRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CareRepository>(value),
    );
  }
}

String _$careRepositoryHash() => r'6443eaf78574ad41ad6d4d770af00a7e0cb5068d';

@ProviderFor(notificationScheduler)
final notificationSchedulerProvider = NotificationSchedulerProvider._();

final class NotificationSchedulerProvider
    extends
        $FunctionalProvider<
          NotificationScheduler,
          NotificationScheduler,
          NotificationScheduler
        >
    with $Provider<NotificationScheduler> {
  NotificationSchedulerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationSchedulerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationSchedulerHash();

  @$internal
  @override
  $ProviderElement<NotificationScheduler> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NotificationScheduler create(Ref ref) {
    return notificationScheduler(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationScheduler value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotificationScheduler>(value),
    );
  }
}

String _$notificationSchedulerHash() =>
    r'd57faf6405b468f7e0c2bf2c7ee97a7e7b163c78';

/// Today's agenda: overdue, today and the next [agendaDays] days, plus tasks
/// finished today.

@ProviderFor(agenda)
final agendaProvider = AgendaProvider._();

/// Today's agenda: overdue, today and the next [agendaDays] days, plus tasks
/// finished today.

final class AgendaProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<CareTask>>,
          List<CareTask>,
          Stream<List<CareTask>>
        >
    with $FutureModifier<List<CareTask>>, $StreamProvider<List<CareTask>> {
  /// Today's agenda: overdue, today and the next [agendaDays] days, plus tasks
  /// finished today.
  AgendaProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'agendaProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$agendaHash();

  @$internal
  @override
  $StreamProviderElement<List<CareTask>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<CareTask>> create(Ref ref) {
    return agenda(ref);
  }
}

String _$agendaHash() => r'b4cd61a8cbee3872f9e0ea11a9408c1a0b0cb1a1';

@ProviderFor(pendingTasks)
final pendingTasksProvider = PendingTasksProvider._();

final class PendingTasksProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<CareTask>>,
          List<CareTask>,
          Stream<List<CareTask>>
        >
    with $FutureModifier<List<CareTask>>, $StreamProvider<List<CareTask>> {
  PendingTasksProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pendingTasksProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pendingTasksHash();

  @$internal
  @override
  $StreamProviderElement<List<CareTask>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<CareTask>> create(Ref ref) {
    return pendingTasks(ref);
  }
}

String _$pendingTasksHash() => r'be1dc985281b677f4fc3976f51af7b73481153f5';

@ProviderFor(plantingRules)
final plantingRulesProvider = PlantingRulesFamily._();

final class PlantingRulesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<CareRule>>,
          List<CareRule>,
          Stream<List<CareRule>>
        >
    with $FutureModifier<List<CareRule>>, $StreamProvider<List<CareRule>> {
  PlantingRulesProvider._({
    required PlantingRulesFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'plantingRulesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$plantingRulesHash();

  @override
  String toString() {
    return r'plantingRulesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<CareRule>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<CareRule>> create(Ref ref) {
    final argument = this.argument as String;
    return plantingRules(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PlantingRulesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$plantingRulesHash() => r'bf1efaa79866fef91cc897b64d6e8e8b7d56f7dd';

final class PlantingRulesFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<CareRule>>, String> {
  PlantingRulesFamily._()
    : super(
        retry: null,
        name: r'plantingRulesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PlantingRulesProvider call(String plantingId) =>
      PlantingRulesProvider._(argument: plantingId, from: this);

  @override
  String toString() => r'plantingRulesProvider';
}
