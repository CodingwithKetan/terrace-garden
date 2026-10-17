import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:terrace_garden/core/units/measurements.dart';
import 'package:terrace_garden/features/garden/domain/garden.dart';
import 'package:terrace_garden/features/garden/domain/garden_enums.dart';
import 'package:terrace_garden/features/garden/domain/region.dart';

part 'garden_draft.freezed.dart';

/// Editable garden fields before they are saved. Used by onboarding and the
/// profile form; [validate] is the single source of validation rules.
@freezed
abstract class GardenDraft with _$GardenDraft {
  const factory GardenDraft({
    @Default('') String name,
    @Default(SpaceType.terrace) SpaceType spaceType,
    String? cityName,
    GrowingRegion? region,
    Length? length,
    Length? width,
    @Default(SunExposure.unknown) SunExposure sun,
    @Default(Facing.unknown) Facing facing,
    @Default(WindExposure.unknown) WindExposure wind,
    @Default(WaterAccess.unknown) WaterAccess water,
    @Default(<GardenGoal>{}) Set<GardenGoal> goals,
    GardenStyle? style,
    ExperienceLevel? experience,
    @Default(WeeklyTime.unknown) WeeklyTime weeklyTime,
    @Default(BudgetBand.unknown) BudgetBand budget,
    String? notes,
  }) = _GardenDraft;

  const GardenDraft._();

  factory GardenDraft.fromGarden(Garden garden) => GardenDraft(
    name: garden.name,
    spaceType: garden.spaceType,
    cityName: garden.cityName,
    region: garden.region,
    length: garden.length,
    width: garden.width,
    sun: garden.sun,
    facing: garden.facing,
    wind: garden.wind,
    water: garden.water,
    goals: garden.goals,
    style: garden.style,
    experience: garden.experience,
    weeklyTime: garden.weeklyTime,
    budget: garden.budget,
    notes: garden.notes,
  );

  static const maxNameLength = 60;

  /// Largest accepted side: 200 m covers any rooftop while catching typos.
  static const maxSide = Length.cm(20000);

  /// Returns field errors; empty when the draft can be saved.
  Set<GardenDraftError> validate() {
    final errors = <GardenDraftError>{};
    final trimmed = name.trim();
    if (trimmed.isEmpty) errors.add(GardenDraftError.nameRequired);
    if (trimmed.length > maxNameLength) {
      errors.add(GardenDraftError.nameTooLong);
    }
    for (final (side, error) in [
      (length, GardenDraftError.lengthOutOfRange),
      (width, GardenDraftError.widthOutOfRange),
    ]) {
      if (side != null && (side.cm <= 0 || side > maxSide)) errors.add(error);
    }
    return errors;
  }

  bool get isValid => validate().isEmpty;
}

enum GardenDraftError {
  nameRequired,
  nameTooLong,
  lengthOutOfRange,
  widthOutOfRange,
}
