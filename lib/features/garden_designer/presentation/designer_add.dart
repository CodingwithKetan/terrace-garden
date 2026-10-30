import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:terrace_garden/app/theme/app_tokens.dart';
import 'package:terrace_garden/core/units/measurement_formatter.dart';
import 'package:terrace_garden/core/units/measurements.dart';
import 'package:terrace_garden/core/widgets/dialogs.dart';
import 'package:terrace_garden/features/garden_designer/domain/container_presets.dart';
import 'package:terrace_garden/features/garden_designer/domain/geometry.dart';
import 'package:terrace_garden/features/garden_designer/domain/layout.dart';
import 'package:terrace_garden/features/garden_designer/presentation/designer_labels.dart';
import 'package:terrace_garden/features/garden_designer/presentation/terrace_artist.dart';
import 'package:terrace_garden/l10n/l10n.dart';

/// What to place: a kind, at a preset size or (null) its standard size.
typedef Placement = ({ElementKind kind, ElementPreset? preset});

LayoutElement placementElement(Placement p) =>
    p.preset?.toElement(id: '', center: Vec2.zero) ??
    LayoutElement(
      id: '',
      kind: p.kind,
      center: Vec2.zero,
      width: p.kind.w,
      height: p.kind.round ? p.kind.w : p.kind.h,
      depthCm: p.kind.depth,
    );

/// An object drawn as it looks on the terrace, scaled to fit [size].
class ElementThumbnail extends StatelessWidget {
  const ElementThumbnail({required this.element, this.size = 40, super.key});

  ElementThumbnail.of(Placement placement, {double size = 40, Key? key})
    : this(element: placementElement(placement), size: size, key: key);

  final LayoutElement element;
  final double size;

  @override
  Widget build(BuildContext context) => ExcludeSemantics(
    child: CustomPaint(
      size: Size.square(size),
      painter: _ThumbnailPainter(element),
    ),
  );
}

class _ThumbnailPainter extends CustomPainter {
  _ThumbnailPainter(this.element);

  final LayoutElement element;

  @override
  void paint(Canvas canvas, Size size) {
    final b = element.shape.bounds;
    // Thin objects (railings) are drawn at least a fifth as tall as wide.
    final k = math.min(
      size.width * .9 / b.width,
      size.height * .9 / math.max(b.height, b.width / 5),
    );
    canvas
      ..save()
      ..translate(
        size.width / 2 - element.center.x * k,
        size.height / 2 - element.center.y * k,
      );
    TerraceArtist.paintElement(canvas, element, k);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_ThumbnailPainter oldDelegate) =>
      oldDelegate.element != element;
}

/// The size list for [kind]: shop sizes with their soil volume, then the
/// standard size. Pops with the chosen [Placement].
class _SizeList extends StatelessWidget {
  const _SizeList({required this.kind, required this.format});

  final ElementKind kind;
  final MeasurementFormatter format;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final presets = elementPresets[kind] ?? const [];
    final options = <Placement>[
      for (final p in presets) (kind: kind, preset: p),
      (kind: kind, preset: null),
    ];
    // Thumbnails share one scale so sizes compare at a glance.
    final largest = options
        .map((o) => placementElement(o).shape.bounds)
        .map((b) => math.max(b.width, b.height))
        .reduce(math.max);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final option in options)
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: SizedBox.square(
              dimension: 48,
              child: Center(
                child: ElementThumbnail.of(
                  option,
                  size: 48 * math.sqrt(_extent(option) / largest),
                ),
              ),
            ),
            title: Text(
              option.preset == null
                  ? l10n.presetDefault
                  : l10n.presetInches(option.preset!.sizeLabel),
            ),
            subtitle: Text(_details(placementElement(option))),
            onTap: () => Navigator.of(context).pop(option),
          ),
        const SizedBox(height: AppSpacing.sm),
        Text(l10n.presetNote, style: theme.textTheme.bodySmall),
      ],
    );
  }

  static double _extent(Placement o) {
    final b = placementElement(o).shape.bounds;
    return math.max(b.width, b.height);
  }

  String _details(LayoutElement e) {
    final w = format.length(Length.cm(e.width));
    final size = e.kind.round
        ? 'Ø $w'
        : '$w × ${format.length(Length.cm(e.height))}';
    final litres = e.soilLitres;
    return litres == null
        ? size
        : '$size · ${format.volume(Volume.litres(litres))}';
  }
}

/// Asks for a size when [kind] has shop sizes; otherwise places the
/// standard size straight away.
Future<Placement?> showSizePicker(
  BuildContext context,
  ElementKind kind,
  MeasurementFormatter format,
) async {
  if (!elementPresets.containsKey(kind)) return (kind: kind, preset: null);
  return showAppBottomSheet<Placement>(
    context,
    title: '${kind.label(context.l10n)} · ${context.l10n.presetChooseSize}',
    builder: (context) => _SizeList(kind: kind, format: format),
  );
}

/// The add sheet's groups, in order.
enum _Group { containers, structures, sunShape, other }

_Group _groupOf(ElementKind k) => switch (k.role) {
  ElementRole.container => _Group.containers,
  ElementRole.structure => _Group.structures,
  ElementRole.zone || ElementRole.cutOut => _Group.sunShape,
  ElementRole.marker when k == ElementKind.northArrow => _Group.sunShape,
  ElementRole.walkway || ElementRole.marker => _Group.other,
};

/// DSN-02. Every kind, grouped and drawn as it looks; kinds with shop sizes
/// then ask for one in the same sheet.
Future<Placement?> showAddSheet(
  BuildContext context,
  MeasurementFormatter format,
) => showAppBottomSheet<Placement>(
  context,
  title: context.l10n.designerAdd,
  builder: (context) => _AddSheetBody(format: format),
);

/// Sun areas, cut-outs and the north arrow, with how to use them.
Future<Placement?> showSunShapeSheet(
  BuildContext context,
  MeasurementFormatter format,
) => showAppBottomSheet<Placement>(
  context,
  title: context.l10n.paletteSunShape,
  builder: (context) => _AddSheetBody(format: format, only: _Group.sunShape),
);

class _AddSheetBody extends StatefulWidget {
  const _AddSheetBody({required this.format, this.only});

  final MeasurementFormatter format;

  /// Shows just this group, with its explanation.
  final _Group? only;

  @override
  State<_AddSheetBody> createState() => _AddSheetBodyState();
}

class _AddSheetBodyState extends State<_AddSheetBody> {
  ElementKind? _sizing;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final sizing = _sizing;
    if (sizing != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              IconButton(
                tooltip: MaterialLocalizations.of(context).backButtonTooltip,
                icon: const Icon(Icons.arrow_back),
                onPressed: () => setState(() => _sizing = null),
              ),
              Expanded(
                child: Text(
                  '${sizing.label(l10n)} · ${l10n.presetChooseSize}',
                  style: theme.textTheme.titleMedium,
                ),
              ),
            ],
          ),
          _SizeList(kind: sizing, format: widget.format),
        ],
      );
    }
    final only = widget.only;
    final groups = [
      for (final g in _Group.values)
        if (only == null || g == only)
          (
            switch (g) {
              _Group.containers => l10n.paletteContainers,
              _Group.structures => l10n.paletteStructures,
              _Group.sunShape => l10n.paletteSunShape,
              _Group.other => l10n.paletteOther,
            },
            g,
          ),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (only == _Group.sunShape)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.md),
            child: Text(l10n.sunShapeNote, style: theme.textTheme.bodyMedium),
          ),
        for (final (title, group) in groups) ...[
          if (only == null)
            Padding(
              padding: const EdgeInsets.only(
                top: AppSpacing.md,
                bottom: AppSpacing.sm,
              ),
              child: Text(title, style: theme.textTheme.titleSmall),
            ),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              for (final kind in ElementKind.values.where(
                (k) => _groupOf(k) == group,
              ))
                KindTile(
                  placement: (kind: kind, preset: null),
                  onTap: () {
                    if (elementPresets.containsKey(kind)) {
                      setState(() => _sizing = kind);
                    } else {
                      Navigator.of(context).pop((kind: kind, preset: null));
                    }
                  },
                ),
            ],
          ),
        ],
      ],
    );
  }
}

/// A square button showing an object as it looks, its name and,
/// optionally, its size.
class KindTile extends StatelessWidget {
  const KindTile({
    required this.placement,
    required this.onTap,
    this.caption,
    super.key,
  });

  final Placement placement;
  final VoidCallback onTap;

  /// A second line, such as the size that will be placed.
  final String? caption;

  static const double width = 84;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final label = placement.kind.label(context.l10n);
    final labelStyle = theme.textTheme.labelMedium!;
    // Two lines are always reserved, so tiles line up in rows.
    final twoLines =
        MediaQuery.textScalerOf(context).scale(labelStyle.fontSize!) *
        (labelStyle.height ?? 1.2) *
        2;
    return SizedBox(
      width: width,
      child: Material(
        color: theme.colorScheme.surfaceContainerLow,
        borderRadius: AppRadii.mdAll,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.xs,
              vertical: AppSpacing.sm,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElementThumbnail.of(placement),
                const SizedBox(height: AppSpacing.xs),
                ConstrainedBox(
                  constraints: BoxConstraints(minHeight: twoLines),
                  child: Text(
                    label,
                    style: labelStyle,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (caption != null)
                  Text(
                    caption!,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
