import 'dart:async';

import 'package:alchemist/alchemist.dart';

/// Golden tests use alchemist "CI goldens" only. They replace text with solid
/// blocks, so images match across Windows (local) and Linux (CI). Platform
/// goldens with real fonts differ by OS, so they are disabled (ADR-010).
Future<void> testExecutable(FutureOr<void> Function() testMain) {
  return AlchemistConfig.runWithConfig(
    config: const AlchemistConfig(
      platformGoldensConfig: PlatformGoldensConfig(enabled: false),
    ),
    run: () async => testMain(),
  );
}
