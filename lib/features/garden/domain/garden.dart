import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:terrace_garden/core/units/measurements.dart';
import 'package:terrace_garden/features/garden/domain/garden_enums.dart';
import 'package:terrace_garden/features/garden/domain/region.dart';

part 'garden.freezed.dart';

/// A garden project: one terrace, balcony or other growing space
/// (data-model.md §3). Every field except [name] may be unknown.
@freezed
abstract class Garden with _$Garden {
  const factory Garden({
    required String id,
    required String name,
    required SpaceType spaceType,
    required DateTime createdAt,
    required DateTime updatedAt,
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
    String? coverPhotoId,
    String? notes,
  }) = _Garden;

  const Garden._();

  /// Footprint area when both dimensions are known.
  Area? get area =>
      (length != null && width != null) ? length!.by(width!) : null;

  bool get hasDimensions => length != null && width != null;
}
