import 'package:flutter/material.dart';
import 'package:terrace_garden/app/theme/app_tokens.dart';
import 'package:terrace_garden/core/widgets/dialogs.dart';
import 'package:terrace_garden/features/care/domain/care.dart';
import 'package:terrace_garden/features/care/presentation/care_labels.dart';
import 'package:terrace_garden/features/plant_catalog/domain/plant_species.dart';
import 'package:terrace_garden/l10n/l10n.dart';

/// What the user found when they checked the soil.
enum SoilCheckAnswer {
  /// Dry at 2–3 cm: they watered (the task is done).
  watered,

  /// Still moist: no water needed (the task is skipped, reason recorded).
  stillMoist,
}

/// The soil-check moment (Living Terrace): a cutaway that teaches the
/// finger test, the sourced guide for this plant, and two honest answers.
Future<SoilCheckAnswer?> showSoilCheckSheet(
  BuildContext context, {
  required String plantName,
  required String containerName,
  required PlantSpecies? species,
  bool growBag = false,
}) {
  final l10n = context.l10n;
  return showAppBottomSheet<SoilCheckAnswer>(
    context,
    title: plantName,
    builder: (context) {
      final theme = Theme.of(context);
      final colors = theme.colorScheme;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.soilSheetLabel(containerName).toUpperCase(),
            style: theme.textTheme.labelMedium?.copyWith(
              color: colors.primary,
              letterSpacing: 1.1,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Semantics(
            image: true,
            label: l10n.soilDiagramLabel,
            child: ExcludeSemantics(
              child: AspectRatio(
                aspectRatio: 1.8,
                child: CustomPaint(
                  painter: SoilCheckDiagramPainter(
                    background: colors.surfaceContainerHigh,
                    growBag: growBag,
                    dryOnTop: l10n.soilDryOnTop,
                    feelBelow: l10n.soilFeelBelow,
                    labelStyle: theme.textTheme.labelMedium!,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            CareTaskType.checkSoil.guide(l10n, species: species),
            style: theme.textTheme.bodyLarge,
          ),
          const SizedBox(height: AppSpacing.lg),
          FilledButton.icon(
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(56),
              backgroundColor: const Color(0xFF2E6FB0),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            icon: const Icon(Icons.water_drop),
            label: Text(l10n.soilDry),
            onPressed: () => Navigator.of(context).pop(SoilCheckAnswer.watered),
          ),
          const SizedBox(height: AppSpacing.sm),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              minimumSize: const Size.fromHeight(56),
              side: BorderSide(color: colors.onSurface, width: 2),
              foregroundColor: colors.onSurface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            onPressed: () =>
                Navigator.of(context).pop(SoilCheckAnswer.stillMoist),
            child: Text(l10n.soilMoist),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(l10n.soilMorning, style: theme.textTheme.bodySmall),
        ],
      );
    },
  );
}

/// A pot cut open: drier soil on top, a finger 2–3 cm in, a depth bracket.
class SoilCheckDiagramPainter extends CustomPainter {
  const SoilCheckDiagramPainter({
    required this.background,
    required this.growBag,
    required this.dryOnTop,
    required this.feelBelow,
    required this.labelStyle,
  });

  final Color background;
  final bool growBag;
  final String dryOnTop;
  final String feelBelow;
  final TextStyle labelStyle;

  static const _water = Color(0xFF2E6FB0);

  @override
  void paint(Canvas canvas, Size size) {
    // Drawn in a 346 × 190 box, scaled to fit.
    final k = size.width / 346;
    canvas
      ..save()
      ..scale(k)
      ..drawRRect(
        RRect.fromRectAndRadius(
          const Rect.fromLTWH(0, 0, 346, 190),
          const Radius.circular(20),
        ),
        Paint()..color = background,
      );

    final pot = Path()
      ..moveTo(36, 54)
      ..lineTo(310, 54)
      ..lineTo(302, 176)
      ..quadraticBezierTo(173, 184, 44, 176)
      ..close();
    canvas.drawPath(
      pot,
      Paint()
        ..shader = LinearGradient(
          colors: growBag
              ? const [Color(0xFF262E2A), Color(0xFF3A4540), Color(0xFF1F2622)]
              : const [Color(0xFFB9532A), Color(0xFFD2703F), Color(0xFFA4441D)],
          stops: const [0, .5, 1],
        ).createShader(const Rect.fromLTWH(36, 54, 274, 130)),
    );
    final soil = Path()
      ..moveTo(44, 60)
      ..lineTo(302, 60)
      ..lineTo(296, 170)
      ..quadraticBezierTo(173, 177, 50, 170)
      ..close();
    canvas.drawPath(
      soil,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFA47A55),
            Color(0xFF8B6342),
            Color(0xFF5E412B),
            Color(0xFF3F2B1C),
          ],
          stops: [0, .22, .23, 1],
        ).createShader(const Rect.fromLTWH(44, 60, 258, 117)),
    );

    // Seedling, then the finger.
    final leaf = Paint()..color = const Color(0xFF4E8E3E);
    canvas
      ..drawPath(
        Path()
          ..moveTo(150, 60)
          ..cubicTo(152, 40, 160, 26, 170, 14),
        Paint()
          ..color = const Color(0xFF3E7A34)
          ..strokeWidth = 4
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round,
      )
      ..drawOval(const Rect.fromLTWH(168, 8, 26, 12), leaf)
      ..drawOval(const Rect.fromLTWH(138, 26, 24, 11), leaf)
      ..drawRRect(
        RRect.fromRectAndCorners(
          const Rect.fromLTWH(219, 0, 26, 92),
          bottomLeft: const Radius.circular(13),
          bottomRight: const Radius.circular(13),
        ),
        Paint()..color = const Color(0xFFC88B5E),
      )
      ..drawRect(
        const Rect.fromLTWH(219, 0, 26, 20),
        Paint()..color = const Color(0xFFB87A4D),
      )
      ..drawOval(
        const Rect.fromLTWH(224, 74, 16, 12),
        Paint()..color = const Color(0xFFE3B08A),
      );

    // Depth bracket and label.
    final bracket = Paint()
      ..color = _water
      ..strokeWidth = 2;
    canvas
      ..drawLine(const Offset(262, 60), const Offset(276, 60), bracket)
      ..drawLine(const Offset(262, 90), const Offset(276, 90), bracket)
      ..drawLine(const Offset(269, 60), const Offset(269, 90), bracket)
      ..drawRRect(
        RRect.fromRectAndRadius(
          const Rect.fromLTWH(280, 64, 54, 22),
          const Radius.circular(11),
        ),
        Paint()..color = _water,
      );
    _text(
      canvas,
      '2–3 cm',
      const Offset(307, 75),
      labelStyle.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
      center: true,
    );
    _text(
      canvas,
      dryOnTop,
      const Offset(62, 118),
      labelStyle.copyWith(
        color: const Color(0xFFF2E6D8),
        fontWeight: FontWeight.w600,
      ),
    );
    _text(
      canvas,
      feelBelow,
      const Offset(62, 136),
      labelStyle.copyWith(color: const Color(0xFFD8C8B6)),
    );
    canvas.restore();
  }

  void _text(
    Canvas canvas,
    String text,
    Offset at,
    TextStyle style, {
    bool center = false,
  }) {
    final tp = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    )..layout(maxWidth: 150);
    tp.paint(
      canvas,
      center ? at - Offset(tp.width / 2, tp.height / 2) : at,
    );
  }

  @override
  bool shouldRepaint(SoilCheckDiagramPainter oldDelegate) =>
      oldDelegate.background != background || oldDelegate.growBag != growBag;
}
