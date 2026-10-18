import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:terrace_garden/core/errors/app_failure.dart';
import 'package:terrace_garden/core/errors/result.dart';
import 'package:terrace_garden/features/garden/domain/garden.dart';
import 'package:terrace_garden/features/garden/domain/garden_draft.dart';
import 'package:terrace_garden/features/garden/garden.dart';
import 'package:terrace_garden/features/settings/settings.dart';

part 'onboarding_controller.freezed.dart';
part 'onboarding_controller.g.dart';

enum OnboardingStep { welcome, space, light, goals, ready }

@freezed
abstract class OnboardingState with _$OnboardingState {
  const factory OnboardingState({
    @Default(OnboardingStep.welcome) OnboardingStep step,
    @Default(GardenDraft()) GardenDraft draft,

    /// Validation errors are shown only after the user tries to continue.
    @Default(false) bool showErrors,
    @Default(false) bool isSaving,
    AppFailure? failure,
  }) = _OnboardingState;
}

/// Drives the progressive onboarding flow (screen-inventory ONB-01..05).
/// Only the garden name is required; every other step can be skipped.
@riverpod
class OnboardingController extends _$OnboardingController {
  @override
  OnboardingState build() => const OnboardingState();

  static const List<OnboardingStep> formSteps = [
    OnboardingStep.space,
    OnboardingStep.light,
    OnboardingStep.goals,
  ];

  /// Pre-fills a friendly default name the first time ("My terrace").
  void prefillName(String name) {
    if (state.draft.name.isEmpty) {
      state = state.copyWith(draft: state.draft.copyWith(name: name));
    }
  }

  /// Applies [edit] to the latest draft (see `DraftEdit`).
  void editDraft(GardenDraft Function(GardenDraft) edit) =>
      state = state.copyWith(draft: edit(state.draft), failure: null);

  /// Moves forward. Returns false if the current step is invalid.
  bool next() {
    if (state.step == OnboardingStep.space && !state.draft.isValid) {
      state = state.copyWith(showErrors: true);
      return false;
    }
    const steps = OnboardingStep.values;
    final index = steps.indexOf(state.step);
    if (index < steps.length - 1) {
      state = state.copyWith(step: steps[index + 1], showErrors: false);
    }
    return true;
  }

  /// Moves back. Returns false when already at the first step.
  bool back() {
    final index = OnboardingStep.values.indexOf(state.step);
    if (index == 0) return false;
    state = state.copyWith(step: OnboardingStep.values[index - 1]);
    return true;
  }

  /// "I'll explore first": finish onboarding without creating a garden.
  Future<void> explore() async {
    await ref.read(settingsControllerProvider.notifier).completeOnboarding();
  }

  /// Creates the garden and finishes onboarding.
  Future<Result<Garden>> createGarden() async {
    state = state.copyWith(isSaving: true, failure: null);
    final result = await ref.read(gardenRepositoryProvider).create(state.draft);
    switch (result) {
      case Ok():
        await ref
            .read(settingsControllerProvider.notifier)
            .completeOnboarding();
        state = state.copyWith(isSaving: false);
      case Err(:final failure):
        state = state.copyWith(isSaving: false, failure: failure);
    }
    return result;
  }
}
