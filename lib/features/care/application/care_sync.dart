import 'package:terrace_garden/core/logging/app_logger.dart';
import 'package:terrace_garden/core/time/clock.dart';
import 'package:terrace_garden/core/time/local_date.dart';
import 'package:terrace_garden/features/care/domain/care.dart';
import 'package:terrace_garden/features/care/domain/care_planner.dart';
import 'package:terrace_garden/features/care/domain/care_repository.dart';
import 'package:terrace_garden/features/care/domain/notification_planner.dart';
import 'package:terrace_garden/features/care/domain/notification_scheduler.dart';
import 'package:terrace_garden/features/garden/domain/garden_repository.dart';
import 'package:terrace_garden/features/plant_catalog/domain/catalogue_repository.dart';
import 'package:terrace_garden/features/plantings/domain/planting.dart';
import 'package:terrace_garden/features/plantings/domain/planting_repository.dart';

/// Keeps care plans and tasks in step with plantings (P5-02, P5-03).
///
/// [reconcile] is idempotent: it gives every planting without a plan its
/// default rules, then creates any missing tasks for today's horizon. It runs
/// at start-up, whenever plantings change and when the app resumes, so plans
/// also appear for plantings created before care tracking existed.
final class CareSync {
  CareSync({
    required this._care,
    required this._plantings,
    required this._gardens,
    required this._catalogue,
    required this._clock,
    required this._logger,
  });

  final CareRepository _care;
  final PlantingRepository _plantings;
  final GardenRepository _gardens;
  final CatalogueRepository _catalogue;
  final Clock _clock;
  final AppLogger _logger;

  Future<void>? _running;
  bool _again = false;

  /// Runs a reconcile, coalescing calls made while one is in progress into a
  /// single follow-up run.
  Future<void> reconcile() {
    if (_running != null) {
      _again = true;
      return _running!;
    }
    return _running = _loop().whenComplete(() => _running = null);
  }

  Future<void> _loop() async {
    do {
      _again = false;
      await _reconcileOnce();
    } while (_again);
  }

  Future<void> _reconcileOnce() async {
    try {
      final today = LocalDate.fromDateTime(_clock.now());
      final catalogue = await _catalogue.load();
      final planned = await _care.plantingIdsWithRules();
      for (final planting in await _plantings.all()) {
        final species = catalogue.byId(planting.speciesId);
        if (species == null) continue;
        final garden = await _gardens.find(planting.gardenId);
        final drafts = CarePlanner.plan(
          planting: planting,
          species: species,
          region: garden?.region,
          today: today,
        );
        if (planned.contains(planting.id)) {
          await _syncDatedRules(planting, drafts, today);
        } else {
          await _care.addRules(
            gardenId: planting.gardenId,
            plantingId: planting.id,
            drafts: drafts,
            createdOn: today,
          );
        }
      }
      await _care.materialize(today);
    } on Object catch (error, stackTrace) {
      _logger.error(
        'Care reconcile failed',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  /// Keeps date-based rules in step with the planting and garden after an
  /// edit (KI-027): the transplant and harvest dates follow the planting
  /// date and start type, and jasmine pruning follows the garden region.
  /// Repeating checks are left alone so the user's interval changes stay.
  /// A rule the user switched off keeps its switch.
  Future<void> _syncDatedRules(
    Planting planting,
    List<CareRuleDraft> drafts,
    LocalDate today,
  ) async {
    final rules = await _care.rulesFor(planting.id);
    for (final type in _datedTypes) {
      final draft = drafts.where((d) => d.type == type).firstOrNull;
      final existing = rules.where((r) => r.type == type).toList();
      if (draft == null) {
        for (final rule in existing) {
          await _care.deleteRule(rule.id);
        }
      } else if (existing.isEmpty) {
        await _care.addRules(
          gardenId: planting.gardenId,
          plantingId: planting.id,
          drafts: [draft],
          createdOn: today,
        );
      } else if (type != CareTaskType.prune &&
          existing.first.recurrence != draft.recurrence) {
        await _care.updateRule(
          existing.first.copyWith(recurrence: draft.recurrence),
          today: today,
        );
      }
    }
  }

  static const List<CareTaskType> _datedTypes = [
    CareTaskType.transplant,
    CareTaskType.harvest,
    CareTaskType.prune,
  ];
}

/// Mirrors pending tasks into daily digest notifications (P5-07).
final class NotificationSync {
  NotificationSync({
    required this._care,
    required this._scheduler,
    required this._clock,
    required this._logger,
  });

  final CareRepository _care;
  final NotificationScheduler _scheduler;
  final Clock _clock;
  final AppLogger _logger;
  Future<void> _queue = Future.value();

  /// Plans digests for [tasks] and applies only the difference. Calls are
  /// queued so two quick changes never interleave.
  Future<void> sync({
    required List<CareTask> tasks,
    required bool enabled,
    required int minutesOfDay,
    required String title,
    required String Function(int count) body,
  }) => _queue = _queue.then(
    (_) => _syncOnce(
      tasks: tasks,
      enabled: enabled,
      minutesOfDay: minutesOfDay,
      title: title,
      body: body,
    ),
  );

  Future<void> _syncOnce({
    required List<CareTask> tasks,
    required bool enabled,
    required int minutesOfDay,
    required String title,
    required String Function(int count) body,
  }) async {
    try {
      final desired = NotificationPlanner.plan(
        tasks: tasks,
        now: _clock.now(),
        enabled: enabled,
        minutesOfDay: minutesOfDay,
      );
      final diff = NotificationPlanner.diff(
        desired: desired,
        current: await _care.scheduledDigests(),
      );
      if (diff.isEmpty) return;
      for (final id in diff.cancel) {
        await _scheduler.cancel(id);
      }
      for (final digest in diff.schedule) {
        await _scheduler.scheduleDigest(
          digest,
          title: title,
          body: body(digest.taskCount),
        );
      }
      await _care.recordScheduled(diff);
    } on Object catch (error, stackTrace) {
      _logger.error(
        'Notification sync failed',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}
