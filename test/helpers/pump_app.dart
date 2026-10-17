import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:terrace_garden/app/theme/app_theme.dart';
import 'package:terrace_garden/l10n/l10n.dart';

extension PumpApp on WidgetTester {
  /// Pumps [widget] inside a themed, localised MaterialApp and a
  /// ProviderScope with optional [overrides].
  Future<void> pumpLocalized(
    Widget widget, {
    ThemeData? theme,
    List<Override> overrides = const [],
    double textScale = 1,
  }) {
    return pumpWidget(
      ProviderScope(
        overrides: overrides,
        child: MaterialApp(
          theme: theme ?? AppTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: MediaQuery.withClampedTextScaling(
            minScaleFactor: textScale,
            maxScaleFactor: textScale,
            child: Scaffold(body: widget),
          ),
        ),
      ),
    );
  }

  /// Sets the logical screen size for responsive-layout tests.
  void setScreenSize(Size size) {
    view.physicalSize = size * view.devicePixelRatio;
    addTearDown(view.resetPhysicalSize);
  }
}
