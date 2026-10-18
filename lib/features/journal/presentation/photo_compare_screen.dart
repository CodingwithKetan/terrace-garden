import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:terrace_garden/app/theme/app_tokens.dart';
import 'package:terrace_garden/core/time/local_date.dart';
import 'package:terrace_garden/core/widgets/app_button.dart';
import 'package:terrace_garden/core/widgets/stored_photo_image.dart';
import 'package:terrace_garden/features/journal/data/journal_providers.dart';
import 'package:terrace_garden/features/journal/domain/journal_entry.dart';
import 'package:terrace_garden/l10n/l10n.dart';

/// A journal photo with the day it was recorded.
typedef DatedPhoto = ({JournalPhoto photo, LocalDate date});

/// JRN-03. Pick two journal photos and see them side by side, oldest
/// first, each labelled with its date.
class PhotoCompareScreen extends ConsumerStatefulWidget {
  const PhotoCompareScreen({this.gardenId, this.plantingId, super.key});

  final String? gardenId;
  final String? plantingId;

  @override
  ConsumerState<PhotoCompareScreen> createState() => _PhotoCompareScreenState();
}

class _PhotoCompareScreenState extends ConsumerState<PhotoCompareScreen> {
  final _selected = <String>[];

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final entries = ref.watch(journalEntriesProvider).value ?? const [];
    final photos = <DatedPhoto>[
      for (final e in entries)
        if ((widget.gardenId == null || e.gardenId == widget.gardenId) &&
            (widget.plantingId == null || e.plantingId == widget.plantingId))
          for (final ph in e.photos) (photo: ph, date: e.date),
    ]..sort((a, b) => a.date.compareTo(b.date));
    final chosen = [
      for (final id in _selected)
        ?photos.where((p) => p.photo.id == id).firstOrNull,
    ]..sort((a, b) => a.date.compareTo(b.date));
    final gutter = AppSpacing.gutterFor(MediaQuery.sizeOf(context).width);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.compareTitle)),
      body: Padding(
        padding: EdgeInsets.fromLTRB(gutter, AppSpacing.md, gutter, 0),
        child: photos.length < 2
            ? Text(l10n.compareNeedTwo, style: theme.textTheme.bodyLarge)
            : chosen.length == 2
            ? _Comparison(
                pair: chosen,
                onReset: () => setState(_selected.clear),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(l10n.compareHint, style: theme.textTheme.bodyLarge),
                  const SizedBox(height: AppSpacing.md),
                  Expanded(
                    child: GridView.extent(
                      maxCrossAxisExtent: 160,
                      mainAxisSpacing: AppSpacing.sm,
                      crossAxisSpacing: AppSpacing.sm,
                      children: [
                        for (final p in photos)
                          _PickTile(
                            photo: p,
                            selected: _selected.contains(p.photo.id),
                            onTap: () => setState(() {
                              if (!_selected.remove(p.photo.id)) {
                                _selected.add(p.photo.id);
                              }
                            }),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

String _dateLabel(BuildContext context, LocalDate date) => DateFormat.yMMMd(
  Localizations.localeOf(context).toLanguageTag(),
).format(date.toLocalDateTime());

class _PickTile extends StatelessWidget {
  const _PickTile({
    required this.photo,
    required this.selected,
    required this.onTap,
  });

  final DatedPhoto photo;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final date = _dateLabel(context, photo.date);
    return Semantics(
      button: true,
      selected: selected,
      label: date,
      child: InkWell(
        borderRadius: AppRadii.mdAll,
        onTap: onTap,
        child: Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: AppRadii.mdAll,
              child: StoredPhotoImage(
                relativePath: photo.photo.thumbnailPath,
                cacheWidth: 360,
                semanticLabel: date,
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.xs),
                color: const Color(0x99000000),
                child: Text(
                  date,
                  style: Theme.of(
                    context,
                  ).textTheme.labelSmall?.copyWith(color: Colors.white),
                ),
              ),
            ),
            if (selected)
              DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: AppRadii.mdAll,
                  border: Border.all(color: colors.primary, width: 4),
                ),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.xs),
                    child: Icon(
                      Icons.check_circle,
                      color: colors.primary,
                      semanticLabel: context.l10n.compareSelected,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _Comparison extends StatelessWidget {
  const _Comparison({required this.pair, required this.onReset});

  final List<DatedPhoto> pair;
  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final wide = MediaQuery.sizeOf(context).aspectRatio > 1;
    final panes = [
      for (final p in pair)
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                _dateLabel(context, p.date),
                style: theme.textTheme.titleSmall,
              ),
              const SizedBox(height: AppSpacing.xs),
              Expanded(
                child: ClipRRect(
                  borderRadius: AppRadii.mdAll,
                  child: StoredPhotoImage(
                    relativePath: p.photo.relativePath,
                    cacheWidth: 1080,
                    fit: BoxFit.contain,
                    semanticLabel: _dateLabel(context, p.date),
                  ),
                ),
              ),
            ],
          ),
        ),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: wide
              ? Row(
                  children: [
                    panes[0],
                    const SizedBox(width: AppSpacing.md),
                    panes[1],
                  ],
                )
              : Column(
                  children: [
                    panes[0],
                    const SizedBox(height: AppSpacing.md),
                    panes[1],
                  ],
                ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: AppSpacing.md,
            bottom: MediaQuery.paddingOf(context).bottom + AppSpacing.md,
          ),
          child: AppButton.secondary(
            label: context.l10n.compareAgain,
            icon: Icons.grid_view_outlined,
            onPressed: onReset,
          ),
        ),
      ],
    );
  }
}
