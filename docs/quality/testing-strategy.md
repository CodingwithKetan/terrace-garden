# Testing Strategy

Status: v0.1 (Phase 0). Applies from Phase 1 onwards.

## Goals

- Domain logic is correct and protected: geometry, unit conversion, validation, recommendation scoring, care scheduling.
- Reusable UI components behave predictably across themes, text scales and screen sizes.
- Critical user journeys work end to end on a real Android target.
- Tests are deterministic: no real network, no real clock, no paid APIs.

## Test pyramid and scope

| Layer | Tooling | What we test | Location |
|---|---|---|---|
| Unit (domain) | `package:test` via `flutter_test` | Value objects (dimensions, units), geometry (bounds, overlap, rotation, snapping, world↔screen transform), validation, recommendation rules & explanations, schedule/recurrence calculation, notification de-duplication planning | `test/features/<feature>/domain/` |
| Application / controllers | `flutter_test` + fakes, Riverpod `ProviderContainer` overrides (if Riverpod adopted) | State transitions (loading → data → error), undo/redo stacks, autosave, commands | `test/features/<feature>/application/` |
| Data | In-memory SQLite (drift `NativeDatabase.memory()` if drift adopted), temp directories for file storage | Repositories, mappers, migrations (schema snapshots), cascade deletes, photo file lifecycle | `test/features/<feature>/data/` |
| Widget | `flutter_test` | Reusable components (all states, semantics labels, tap targets ≥48dp, text scale 2.0), key screens with faked repositories | `test/core/widgets/`, `test/features/<feature>/presentation/` |
| Golden | `matchesGoldenFile` (or a golden helper package evaluated in Phase 1) | Design-system components in light/dark; canvas painter output for fixed layouts | `test/goldens/` |
| Integration | `integration_test` on Android emulator | Journeys: onboarding → create garden; create layout + add pot + undo + save + reopen; add plant → care plan generated → complete task → next task recalculated; add progress photo | `integration_test/` |

## Determinism rules

- **Clock:** domain code never calls `DateTime.now()` directly; it depends on an injectable `Clock` abstraction. Tests use fixed dates, including DST/time-zone edge cases (India has no DST; test a DST zone as well because the app is usable globally).
- **IDs:** injectable ID generator for stable test output.
- **Files/photos:** an abstract `PhotoStorage` with a temp-directory or in-memory fake.
- **Notifications:** an abstract `NotificationScheduler`; tests assert on the *planned* set of notifications, never on the platform plugin.
- **Network/AI/weather:** abstract services with fakes; no test hits the network.
- **Randomness:** none in domain logic; if needed, seeded.

## Mandatory test cases (high-risk areas)

### Geometry & dimensions
- Unit conversions cm↔m↔in↔ft round-trip within tolerance (1e-6 cm); display rounding rules.
- World↔screen transform at multiple zoom levels and pan offsets; inverse transform round-trips.
- Rect containment and overlap for axis-aligned and rotated rectangles and circles (separating-axis tests).
- Snapping to grid, to boundary, rotation snapping (15°).
- Validation: object outside boundary, overlap between containers (error), plant outside a container/bed (warning), plant spacing crowding (warning), zero/negative/absurd sizes.
- Undo/redo: command sequences, redo cleared after new command, max history size.

### Scheduling
- Recurrence generation for daily/every-N-days/weekly/monthly-ish intervals and seasonal windows.
- Completing a task early/late shifts the next occurrence according to the rule ("from completion" vs "fixed calendar").
- Skip and reschedule semantics.
- No duplicate tasks or notifications after repeated recalculation (idempotency).
- iOS pending notification limit respected (plan only the next N notifications, roll forward).
- Paused/removed plantings cancel future tasks and notifications.

### Recommendations
- Each rule produces the expected score and human-readable reason.
- Unknown inputs (no sun data, no location) degrade gracefully and are reported as "assumed/unknown".
- Container-size incompatibility excludes or warns as specified.

## Quality gates

Run before marking any phase or substantial task complete:

```bash
dart format --output=none --set-exit-if-changed .
flutter analyze
flutter test
```

Additionally, at phase boundaries:

```bash
flutter test integration_test   # requires a running Android emulator
flutter build apk --debug        # build sanity check
```

Device test setup (Android 13+). `flutter test` uninstalls the app after each run, so grant the notification permission on a freshly installed build first. Otherwise the system dialog blocks the daily-digest step:

```bash
flutter build apk --debug
adb install -r build/app/outputs/flutter-apk/app-debug.apk
adb shell pm clear com.terracegarden.terrace_garden
adb shell pm grant com.terracegarden.terrace_garden android.permission.POST_NOTIFICATIONS
flutter test integration_test -d emulator-5554
```

Coverage target (guidance, not a vanity metric): ≥ 90% line coverage for `domain/` packages, ≥ 70% overall. Run with `flutter test --coverage`.

Rules: no skipped tests without a linked `known-issues.md` entry; no weakened assertions to get green; lints are not disabled to hide problems (any `// ignore:` needs a reason comment).

## Accessibility & responsive checks

- Widget tests with `textScaler: TextScaler.linear(2.0)` for key screens (no overflow exceptions).
- `meetsGuideline(androidTapTargetGuideline)`, `labeledTapTargetGuideline`, `textContrastGuideline` on key screens.
- Layout tests at compact (360×800), medium (700×1000) and expanded (1200×800) sizes.

## CI (future)

GitHub Actions workflow running format, analyze, test (unit/widget/golden on Linux) once a remote repository exists. Integration tests run manually on an emulator until a device farm is justified.
