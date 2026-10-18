import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:terrace_garden/app/router/app_router.dart';
import 'package:terrace_garden/app/theme/app_tokens.dart';
import 'package:terrace_garden/core/errors/result.dart';
import 'package:terrace_garden/core/units/measurements.dart';
import 'package:terrace_garden/core/widgets/app_button.dart';
import 'package:terrace_garden/core/widgets/error_state.dart';
import 'package:terrace_garden/features/garden/garden.dart';
import 'package:terrace_garden/features/garden_designer/domain/geometry.dart';
import 'package:terrace_garden/features/garden_designer/domain/layout.dart';
import 'package:terrace_garden/features/garden_designer/garden_designer.dart';
import 'package:terrace_garden/features/onboarding/application/onboarding_controller.dart';
import 'package:terrace_garden/features/plant_catalog/plant_catalog.dart';
import 'package:terrace_garden/features/settings/settings.dart';
import 'package:terrace_garden/l10n/l10n.dart';

/// ONB-01..05.
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final name = context.l10n.defaultGardenName;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        ref.read(onboardingControllerProvider.notifier).prefillName(name);
      }
    });
  }

  Future<void> _explore() async {
    await ref.read(onboardingControllerProvider.notifier).explore();
    if (mounted) context.go(AppRoutes.today);
  }

  Future<void> _create() async {
    final result = await ref
        .read(onboardingControllerProvider.notifier)
        .createGarden();
    if (!mounted) return;
    if (result case Ok(:final value)) {
      context.go(AppRoutes.gardenDetail(value.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(onboardingControllerProvider);
    final controller = ref.read(onboardingControllerProvider.notifier);

    return PopScope(
      canPop: state.step == OnboardingStep.welcome,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) controller.back();
      },
      child: switch (state.step) {
        OnboardingStep.welcome => _WelcomeStep(
          onStart: controller.next,
          onExplore: _explore,
        ),
        _ => _FormStep(state: state, onCreate: _create),
      },
    );
  }
}

class _WelcomeStep extends StatelessWidget {
  const _WelcomeStep({required this.onStart, required this.onExplore});

  final VoidCallback onStart;
  final VoidCallback onExplore;

  /// A small sample terrace, drawn like the user's own will be.
  static final _sample = [
    const PlanItem(
      element: LayoutElement(
        id: 'path',
        kind: ElementKind.path,
        center: Vec2(200, 272),
        width: 400,
        height: 56,
      ),
    ),
    PlanItem(
      element: const LayoutElement(
        id: 'bag',
        kind: ElementKind.growBag,
        center: Vec2(85, 85),
        width: 100,
        height: 80,
      ),
      plants: [PlantArtSpec.of('tomato')],
      badge: PlanBadge.due,
    ),
    PlanItem(
      element: const LayoutElement(
        id: 'pot',
        kind: ElementKind.roundPot,
        center: Vec2(215, 80),
        width: 72,
        height: 72,
      ),
      plants: [PlantArtSpec.of('tulsi')],
      badge: PlanBadge.done,
    ),
    PlanItem(
      element: const LayoutElement(
        id: 'pot2',
        kind: ElementKind.roundPot,
        center: Vec2(330, 95),
        width: 54,
        height: 54,
      ),
      plants: [PlantArtSpec.of('marigold')],
    ),
    PlanItem(
      element: const LayoutElement(
        id: 'bed',
        kind: ElementKind.rectPlanter,
        center: Vec2(210, 190),
        width: 190,
        height: 52,
      ),
      plants: [
        PlantArtSpec.of('palak'),
        PlantArtSpec.of('palak'),
        PlantArtSpec.of('palak'),
      ],
    ),
    const PlanItem(
      element: LayoutElement(
        id: 'tap',
        kind: ElementKind.waterPoint,
        center: Vec2(370, 262),
        width: 15,
        height: 15,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final insets = MediaQuery.paddingOf(context);
    final benefits = [
      (Icons.straighten_outlined, l10n.onbBenefitPlan),
      (Icons.wb_sunny_outlined, l10n.onbBenefitSeason),
      (Icons.water_drop_outlined, l10n.onbBenefitCare),
    ];

    return Scaffold(
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppBreakpoints.readableMaxWidth,
          ),
          child: ListView(
            padding: EdgeInsets.fromLTRB(
              AppSpacing.lg,
              insets.top + AppSpacing.lg,
              AppSpacing.lg,
              insets.bottom + AppSpacing.lg,
            ),
            children: [
              Text(
                l10n.appTitle.toUpperCase(),
                style: theme.textTheme.labelLarge?.copyWith(
                  color: theme.colorScheme.primary,
                  letterSpacing: 1.4,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              // Gives way on short screens so the buttons stay in reach.
              ExcludeSemantics(
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: math.min(
                        300,
                        MediaQuery.sizeOf(context).height * .3,
                      ),
                    ),
                    child: AspectRatio(
                      aspectRatio: 4 / 3,
                      child: TerracePlan(
                        lengthCm: 400,
                        widthCm: 300,
                        items: _sample,
                        dusk: theme.brightness == Brightness.dark,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              Semantics(
                header: true,
                child: Text(
                  l10n.onbWelcomeTitle,
                  style: theme.textTheme.headlineLarge,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              for (final (icon, text) in benefits)
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.md),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(icon, color: theme.colorScheme.primary),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Text(text, style: theme.textTheme.bodyLarge),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: AppSpacing.md),
              AppButton(label: l10n.onbStart, onPressed: onStart, expand: true),
              const SizedBox(height: AppSpacing.sm),
              AppButton.text(
                label: l10n.onbExplore,
                onPressed: onExplore,
                expand: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FormStep extends ConsumerWidget {
  const _FormStep({required this.state, required this.onCreate});

  final OnboardingState state;
  final VoidCallback onCreate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final controller = ref.read(onboardingControllerProvider.notifier);
    final unitSystem =
        ref.watch(settingsControllerProvider).value?.unitSystem ??
        UnitSystem.metric;
    final formIndex = OnboardingController.formSteps.indexOf(state.step);
    final isReady = state.step == OnboardingStep.ready;
    final draft = state.draft;
    final gutter = AppSpacing.gutterFor(MediaQuery.sizeOf(context).width);

    final (title, subtitle, Widget body) = switch (state.step) {
      OnboardingStep.space => (
        l10n.onbSpaceTitle,
        null,
        GardenSpaceSection(
          draft: draft,
          unitSystem: unitSystem,
          errors: state.showErrors ? draft.validate() : const {},
          onEdit: controller.editDraft,
        ),
      ),
      OnboardingStep.light => (
        l10n.onbLightTitle,
        l10n.onbOptionalHint,
        GardenLightSection(draft: draft, onEdit: controller.editDraft),
      ),
      OnboardingStep.goals => (
        l10n.onbGoalsTitle,
        l10n.onbOptionalHint,
        GardenGoalsSection(draft: draft, onEdit: controller.editDraft),
      ),
      _ => (
        l10n.onbReadyTitle,
        l10n.onbReadyBody,
        _ReadySummary(state: state),
      ),
    };

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: controller.back),
        title: formIndex >= 0
            ? Text(
                l10n.onbStepOf(
                  formIndex + 1,
                  OnboardingController.formSteps.length,
                ),
                style: theme.textTheme.titleSmall,
              )
            : null,
        bottom: formIndex >= 0
            ? PreferredSize(
                preferredSize: const Size.fromHeight(4),
                child: LinearProgressIndicator(
                  value:
                      (formIndex + 1) / OnboardingController.formSteps.length,
                ),
              )
            : null,
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppBreakpoints.readableMaxWidth,
          ),
          child: ListView(
            padding: EdgeInsets.fromLTRB(
              gutter,
              AppSpacing.lg,
              gutter,
              AppSpacing.xxl,
            ),
            children: [
              Semantics(
                header: true,
                child: Text(title, style: theme.textTheme.headlineMedium),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: AppSpacing.sm),
                Text(subtitle, style: theme.textTheme.bodyLarge),
              ],
              const SizedBox(height: AppSpacing.xl),
              body,
              if (state.failure != null) ...[
                const SizedBox(height: AppSpacing.lg),
                Text(
                  ErrorState.messageFor(l10n, state.failure),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.error,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            gutter,
            AppSpacing.sm,
            gutter,
            AppSpacing.md,
          ),
          child: Row(
            children: [
              if (!isReady && state.step != OnboardingStep.space)
                AppButton.text(
                  label: l10n.actionSkip,
                  onPressed: controller.next,
                ),
              const Spacer(),
              if (isReady)
                AppButton(
                  label: l10n.onbCreateGarden,
                  isLoading: state.isSaving,
                  onPressed: onCreate,
                )
              else
                AppButton(
                  label: l10n.actionContinue,
                  onPressed: controller.next,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReadySummary extends StatelessWidget {
  const _ReadySummary({required this.state});

  final OnboardingState state;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final d = state.draft;
    final rows = [
      (Icons.badge_outlined, l10n.fieldGardenName, d.name.trim()),
      (d.spaceType.icon, l10n.fieldSpaceType, d.spaceType.label(l10n)),
      (Icons.location_on_outlined, l10n.fieldCity, d.cityName ?? l10n.notSet),
      (Icons.wb_sunny_outlined, l10n.fieldSun, d.sun.label(l10n)),
      (
        Icons.eco_outlined,
        l10n.fieldGoals,
        d.goals.isEmpty
            ? l10n.notSet
            : d.goals.map((g) => g.label(l10n)).join(', '),
      ),
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          children: [
            for (final (icon, label, value) in rows)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(icon, size: 20),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Text(label, style: theme.textTheme.bodyMedium),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Flexible(
                      child: Text(
                        value,
                        textAlign: TextAlign.end,
                        style: theme.textTheme.titleSmall,
                      ),
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
