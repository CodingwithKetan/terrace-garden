import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:terrace_garden/app/router/app_router.dart';
import 'package:terrace_garden/app/theme/app_tokens.dart';
import 'package:terrace_garden/core/errors/app_failure.dart';
import 'package:terrace_garden/core/errors/result.dart';
import 'package:terrace_garden/core/units/measurement_formatter.dart';
import 'package:terrace_garden/core/units/measurements.dart';
import 'package:terrace_garden/core/widgets/app_button.dart';
import 'package:terrace_garden/core/widgets/app_card.dart';
import 'package:terrace_garden/core/widgets/async_state_view.dart';
import 'package:terrace_garden/core/widgets/dialogs.dart';
import 'package:terrace_garden/core/widgets/error_state.dart';
import 'package:terrace_garden/core/widgets/info_row.dart';
import 'package:terrace_garden/core/widgets/section_header.dart';
import 'package:terrace_garden/core/widgets/stored_photo_image.dart';
import 'package:terrace_garden/features/garden/data/garden_providers.dart';
import 'package:terrace_garden/features/garden/domain/garden.dart';
import 'package:terrace_garden/features/garden/domain/garden_enums.dart';
import 'package:terrace_garden/features/garden/domain/garden_photo.dart';
import 'package:terrace_garden/features/garden/presentation/garden_labels.dart';
import 'package:terrace_garden/features/garden/presentation/photo_actions.dart';
import 'package:terrace_garden/features/garden/presentation/widgets/garden_cover.dart';
import 'package:terrace_garden/features/garden_designer/data/designer_providers.dart';
import 'package:terrace_garden/features/settings/application/settings_controller.dart';
import 'package:terrace_garden/l10n/l10n.dart';

/// GDN-02. Everything about one garden; unknown details invite completion.
class GardenOverviewScreen extends ConsumerWidget {
  const GardenOverviewScreen({required this.gardenId, super.key});

  final String gardenId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final garden = ref.watch(gardenProvider(gardenId));
    return Scaffold(
      body: AsyncStateView(
        value: garden,
        onRetry: () => ref.invalidate(gardenProvider(gardenId)),
        data: (garden) => garden == null
            ? const ErrorState(failure: NotFoundFailure())
            : _Overview(garden: garden),
      ),
    );
  }
}

class _Overview extends ConsumerWidget {
  const _Overview({required this.garden});

  final Garden garden;

  Future<void> _delete(BuildContext context, WidgetRef ref) async {
    final l10n = context.l10n;
    final messenger = ScaffoldMessenger.of(context);
    final router = GoRouter.of(context);
    final confirmed = await showConfirmDialog(
      context,
      title: l10n.gardenDeleteTitle(garden.name),
      message: l10n.gardenDeleteBody,
      confirmLabel: l10n.actionDelete,
      destructive: true,
    );
    if (!confirmed) return;
    final result = await ref
        .read(gardenServiceProvider)
        .deleteGarden(garden.id);
    switch (result) {
      case Ok():
        router.go(AppRoutes.garden);
        messenger.showSnackBar(SnackBar(content: Text(l10n.gardenDeleted)));
      case Err(:final failure):
        messenger.showSnackBar(
          SnackBar(content: Text(ErrorState.messageFor(l10n, failure))),
        );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final units =
        ref.watch(settingsControllerProvider).value?.unitSystem ??
        UnitSystem.metric;
    final format = MeasurementFormatter(
      units,
      locale: Localizations.localeOf(context).toLanguageTag(),
    );
    final photos = ref.watch(gardenPhotosProvider(garden.id)).value ?? const [];
    final insets = MediaQuery.paddingOf(context);
    final gutter = AppSpacing.gutterFor(MediaQuery.sizeOf(context).width);
    void edit() => context.push(AppRoutes.gardenEdit(garden.id));

    String? known<T>(T value, T unknown, String Function(T) label) =>
        value == unknown ? null : label(value);

    final subtitle = [
      garden.spaceType.label(l10n),
      ?garden.cityName,
    ].join(' · ');

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          stretch: true,
          expandedHeight: 300,
          foregroundColor: Colors.white,
          actions: [
            IconButton(
              tooltip: l10n.actionEdit,
              icon: const Icon(Icons.edit_outlined),
              onPressed: edit,
            ),
            PopupMenuButton<void>(
              tooltip: l10n.moreActions,
              itemBuilder: (context) => [
                PopupMenuItem(
                  onTap: () => _delete(context, ref),
                  child: Text(l10n.gardenDelete),
                ),
              ],
            ),
          ],
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: const EdgeInsetsDirectional.only(
              start: 56,
              bottom: 14,
              end: 96,
            ),
            title: Text(
              garden.name,
              style: theme.textTheme.titleLarge?.copyWith(color: Colors.white),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            background: Stack(
              fit: StackFit.expand,
              children: [
                GardenCover(garden: garden),
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0x99000000),
                        Color(0x00000000),
                        Color(0xB3000000),
                      ],
                      stops: [0, 0.45, 1],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.fromLTRB(
            gutter,
            AppSpacing.lg,
            gutter,
            insets.bottom + AppSpacing.xxl,
          ),
          sliver: SliverList.list(
            children: [
              Text(subtitle, style: theme.textTheme.titleMedium),
              const SizedBox(height: AppSpacing.lg),
              _DesignCard(garden: garden),
              const SizedBox(height: AppSpacing.xl),
              _Section(
                title: l10n.gardenSectionSpace,
                children: [
                  InfoRow(
                    icon: Icons.straighten_outlined,
                    label: l10n.gardenSize,
                    value: garden.hasDimensions
                        ? l10n.gardenSizeValue(
                            format.length(garden.length!),
                            format.length(garden.width!),
                          )
                        : null,
                    notSetLabel: l10n.notSetAdd,
                    onTap: edit,
                  ),
                  if (garden.area != null)
                    InfoRow(
                      icon: Icons.square_foot_outlined,
                      label: l10n.gardenArea,
                      value: format.area(garden.area!),
                      notSetLabel: l10n.notSetAdd,
                    ),
                  InfoRow(
                    icon: Icons.location_on_outlined,
                    label: l10n.gardenLocation,
                    value: garden.cityName,
                    notSetLabel: l10n.notSetAdd,
                    onTap: edit,
                  ),
                  if (garden.cityName != null)
                    InfoRow(
                      icon: Icons.public_outlined,
                      label: l10n.gardenRegion,
                      value: garden.region?.label(l10n),
                      notSetLabel: l10n.notSet,
                    ),
                  if (garden.cityName != null && garden.region == null)
                    Padding(
                      padding: const EdgeInsets.only(top: AppSpacing.xs),
                      child: Text(
                        l10n.cityNoRegion,
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                ],
              ),
              _Section(
                title: l10n.gardenSectionLight,
                children: [
                  InfoRow(
                    icon: Icons.wb_sunny_outlined,
                    label: l10n.fieldSun,
                    value: known(
                      garden.sun,
                      SunExposure.unknown,
                      (v) => v.label(l10n),
                    ),
                    notSetLabel: l10n.notSetAdd,
                    onTap: edit,
                  ),
                  InfoRow(
                    icon: Icons.explore_outlined,
                    label: l10n.fieldFacing,
                    value: known(
                      garden.facing,
                      Facing.unknown,
                      (v) => v.label(l10n),
                    ),
                    notSetLabel: l10n.notSetAdd,
                    onTap: edit,
                  ),
                  InfoRow(
                    icon: Icons.air_outlined,
                    label: l10n.fieldWind,
                    value: known(
                      garden.wind,
                      WindExposure.unknown,
                      (v) => v.label(l10n),
                    ),
                    notSetLabel: l10n.notSetAdd,
                    onTap: edit,
                  ),
                  InfoRow(
                    icon: Icons.water_outlined,
                    label: l10n.fieldWater,
                    value: known(
                      garden.water,
                      WaterAccess.unknown,
                      (v) => v.label(l10n),
                    ),
                    notSetLabel: l10n.notSetAdd,
                    onTap: edit,
                  ),
                ],
              ),
              _PhotosSection(garden: garden, photos: photos),
              _Section(
                title: l10n.gardenSectionGoals,
                children: [
                  InfoRow(
                    icon: Icons.eco_outlined,
                    label: l10n.fieldGoals,
                    value: garden.goals.isEmpty
                        ? null
                        : garden.goals.map((g) => g.label(l10n)).join(', '),
                    notSetLabel: l10n.notSetAdd,
                    onTap: edit,
                  ),
                  InfoRow(
                    icon: Icons.school_outlined,
                    label: l10n.fieldExperience,
                    value: garden.experience?.label(l10n),
                    notSetLabel: l10n.notSetAdd,
                    onTap: edit,
                  ),
                  InfoRow(
                    icon: Icons.schedule_outlined,
                    label: l10n.fieldWeeklyTime,
                    value: known(
                      garden.weeklyTime,
                      WeeklyTime.unknown,
                      (v) => v.label(l10n),
                    ),
                    notSetLabel: l10n.notSetAdd,
                    onTap: edit,
                  ),
                  InfoRow(
                    icon: Icons.palette_outlined,
                    label: l10n.fieldStyle,
                    value: garden.style?.label(l10n),
                    notSetLabel: l10n.notSetAdd,
                    onTap: edit,
                  ),
                ],
              ),
              AppCard(
                semanticLabel: l10n.checklistTitle,
                onTap: () => context.push(AppRoutes.gardenChecklist(garden.id)),
                child: Row(
                  children: [
                    Icon(
                      Icons.fact_check_outlined,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(width: AppSpacing.lg),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.checklistTitle,
                            style: theme.textTheme.titleMedium,
                          ),
                          Text(
                            l10n.checklistSubtitle,
                            style: theme.textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right_rounded),
                  ],
                ),
              ),
              if (garden.notes != null) ...[
                const SizedBox(height: AppSpacing.xl),
                SectionHeader(title: l10n.fieldNotes),
                Text(garden.notes!, style: theme.textTheme.bodyLarge),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SectionHeader(title: title),
          AppCard(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.sm,
            ),
            child: Column(children: children),
          ),
        ],
      ),
    );
  }
}

class _PhotosSection extends ConsumerWidget {
  const _PhotosSection({required this.garden, required this.photos});

  final Garden garden;
  final List<GardenPhoto> photos;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SectionHeader(
            title: l10n.gardenPhotos,
            actionLabel: photos.isEmpty ? null : l10n.seeAll,
            onAction: photos.isEmpty
                ? null
                : () => context.push(AppRoutes.gardenPhotos(garden.id)),
          ),
          if (photos.isEmpty)
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.gardenPhotosEmpty,
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  AppButton.secondary(
                    label: l10n.photoAdd,
                    icon: Icons.add_a_photo_outlined,
                    onPressed: () => addGardenPhotos(context, ref, garden.id),
                  ),
                ],
              ),
            )
          else
            SizedBox(
              height: 112,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: photos.length + 1,
                separatorBuilder: (_, _) =>
                    const SizedBox(width: AppSpacing.sm),
                itemBuilder: (context, index) {
                  if (index == photos.length) {
                    return _AddPhotoTile(
                      label: l10n.photoAdd,
                      onTap: () => addGardenPhotos(context, ref, garden.id),
                    );
                  }
                  final photo = photos[index];
                  return ClipRRect(
                    borderRadius: AppRadii.mdAll,
                    child: SizedBox.square(
                      dimension: 112,
                      child: InkWell(
                        onTap: () => context.push(
                          AppRoutes.gardenPhoto(garden.id, photo.id),
                        ),
                        child: StoredPhotoImage(
                          relativePath: photo.thumbnailPath,
                          cacheWidth: 336,
                          semanticLabel: photo.caption ?? l10n.gardenPhotos,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

class _AddPhotoTile extends StatelessWidget {
  const _AddPhotoTile({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Material(
      color: colors.surfaceContainerHigh,
      borderRadius: AppRadii.mdAll,
      child: InkWell(
        borderRadius: AppRadii.mdAll,
        onTap: onTap,
        child: SizedBox.square(
          dimension: 112,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add_a_photo_outlined, color: colors.primary),
              const SizedBox(height: AppSpacing.xs),
              Text(label, style: Theme.of(context).textTheme.labelMedium),
            ],
          ),
        ),
      ),
    );
  }
}

class _DesignCard extends ConsumerWidget {
  const _DesignCard({required this.garden});

  final Garden garden;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final count = ref.watch(layoutElementsProvider(garden.id)).value?.length;
    final subtitle = (count == null || count == 0)
        ? l10n.designOpenSubtitle
        : l10n.layoutObjectCount(count);

    return Material(
      color: theme.colorScheme.primaryContainer,
      borderRadius: AppRadii.mdAll,
      child: InkWell(
        borderRadius: AppRadii.mdAll,
        onTap: () => context.push(AppRoutes.gardenDesign(garden.id)),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Row(
            children: [
              Icon(
                Icons.dashboard_customize_outlined,
                color: theme.colorScheme.onPrimaryContainer,
              ),
              const SizedBox(width: AppSpacing.lg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.designOpen,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: theme.colorScheme.onPrimaryContainer,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
