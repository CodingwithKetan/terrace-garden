import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:terrace_garden/app/theme/app_colors.dart';
import 'package:terrace_garden/app/theme/care_colors.dart';
import 'package:terrace_garden/app/theme/glass_theme.dart';

/// WCAG 2.x contrast ratio between two opaque colours.
double contrastRatio(Color a, Color b) {
  final la = a.computeLuminance();
  final lb = b.computeLuminance();
  final lighter = la > lb ? la : lb;
  final darker = la > lb ? lb : la;
  return (lighter + 0.05) / (darker + 0.05);
}

const double bodyText = 4.5; // WCAG AA, normal text
const double uiComponent = 3; // WCAG AA, large text and UI components

void main() {
  for (final (name, scheme, care) in [
    ('light', AppColorSchemes.light, CareColors.light),
    ('dark', AppColorSchemes.dark, CareColors.dark),
  ]) {
    group('$name theme contrast', () {
      final surfaces = {
        'surface': scheme.surface,
        'surfaceContainerLowest': scheme.surfaceContainerLowest,
        'surfaceContainerLow': scheme.surfaceContainerLow,
        'surfaceContainer': scheme.surfaceContainer,
        'surfaceContainerHigh': scheme.surfaceContainerHigh,
        'surfaceContainerHighest': scheme.surfaceContainerHighest,
      };

      final textPairs = <String, (Color, Color)>{
        'onPrimary/primary': (scheme.onPrimary, scheme.primary),
        'onPrimaryContainer/primaryContainer': (
          scheme.onPrimaryContainer,
          scheme.primaryContainer,
        ),
        'onSecondary/secondary': (scheme.onSecondary, scheme.secondary),
        'onSecondaryContainer/secondaryContainer': (
          scheme.onSecondaryContainer,
          scheme.secondaryContainer,
        ),
        'onTertiary/tertiary': (scheme.onTertiary, scheme.tertiary),
        'onTertiaryContainer/tertiaryContainer': (
          scheme.onTertiaryContainer,
          scheme.tertiaryContainer,
        ),
        'onError/error': (scheme.onError, scheme.error),
        'onErrorContainer/errorContainer': (
          scheme.onErrorContainer,
          scheme.errorContainer,
        ),
        'onInverseSurface/inverseSurface': (
          scheme.onInverseSurface,
          scheme.inverseSurface,
        ),
        'inversePrimary/inverseSurface (snackbar action)': (
          scheme.inversePrimary,
          scheme.inverseSurface,
        ),
        for (final MapEntry(:key, :value) in surfaces.entries) ...{
          'onSurface/$key': (scheme.onSurface, value),
          'onSurfaceVariant/$key': (scheme.onSurfaceVariant, value),
          'primary/$key (text buttons, links)': (scheme.primary, value),
          'error/$key (error text)': (scheme.error, value),
        },
      };

      for (final MapEntry(key: pair, value: (fg, bg)) in textPairs.entries) {
        test('$pair meets $bodyText:1', () {
          expect(contrastRatio(fg, bg), greaterThanOrEqualTo(bodyText));
        });
      }

      for (final MapEntry(:key, :value) in {
        'surface': scheme.surface,
        'surfaceContainerLowest': scheme.surfaceContainerLowest,
      }.entries) {
        test('outline on $key meets $uiComponent:1', () {
          expect(
            contrastRatio(scheme.outline, value),
            greaterThanOrEqualTo(uiComponent),
          );
        });

        test('every care colour on $key meets $uiComponent:1', () {
          for (final color in care.all) {
            expect(
              contrastRatio(color, value),
              greaterThanOrEqualTo(uiComponent),
              reason: 'care colour $color',
            );
          }
        });
      }
    });
  }

  group('glass surfaces', () {
    // Glass sits over arbitrary photos, so text must pass over the tint
    // composited on both extremes: a pure black and a pure white backdrop.
    for (final (name, scheme, glass) in [
      ('light', AppColorSchemes.light, GlassTheme.light),
      ('dark', AppColorSchemes.dark, GlassTheme.dark),
    ]) {
      for (final (backdropName, backdrop) in [
        ('black', Colors.black),
        ('white', Colors.white),
      ]) {
        test(
          '$name: onSurface on glass over $backdropName meets $bodyText:1',
          () {
            final surface = Color.alphaBlend(glass.tint, backdrop);
            expect(
              contrastRatio(scheme.onSurface, surface),
              greaterThanOrEqualTo(bodyText),
            );
          },
        );
      }

      // Living Terrace has no photo backdrops: "on photo" text sits on the
      // plain screen background.
      test('$name: header text on the screen background meets 4.5:1', () {
        expect(
          contrastRatio(glass.onPhoto, scheme.surface),
          greaterThanOrEqualTo(bodyText),
        );
      });
    }
  });

  test('decorative haldi and terracotta are not text colours', () {
    // Guard against regressions: the decorative tones fail body-text
    // contrast, so text uses their deep variants.
    expect(
      contrastRatio(AppPalette.haldi, AppPalette.paper),
      lessThan(bodyText),
    );
    expect(AppColorSchemes.light.tertiary, AppPalette.haldiDeep);
    expect(AppColorSchemes.light.secondary, AppPalette.terracottaDeep);
  });
}
