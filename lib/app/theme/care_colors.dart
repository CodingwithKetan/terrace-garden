import 'package:flutter/material.dart';

/// Semantic colours for care categories and statuses (design-system.md §2.2).
///
/// Colour is never the only signal: widgets pair these with an icon and label.
@immutable
class CareColors extends ThemeExtension<CareColors> {
  const CareColors({
    required this.water,
    required this.fertilise,
    required this.prune,
    required this.repot,
    required this.inspect,
    required this.sow,
    required this.harvest,
    required this.success,
    required this.warning,
  });

  static const light = CareColors(
    water: Color(0xFF2E6FB0),
    fertilise: Color(0xFF855B00),
    prune: Color(0xFF7A5C99),
    repot: Color(0xFFA4471F),
    inspect: Color(0xFFA4471F),
    sow: Color(0xFF2B6530),
    harvest: Color(0xFFA8700F),
    success: Color(0xFF2B6530),
    warning: Color(0xFF855B00),
  );

  static const dark = CareColors(
    water: Color(0xFF8EC1E8),
    fertilise: Color(0xFFBCD07A),
    prune: Color(0xFFCDB3E8),
    repot: Color(0xFFF0B394),
    inspect: Color(0xFFE9C46A),
    sow: Color(0xFF92D1AE),
    harvest: Color(0xFFF2C46B),
    success: Color(0xFF8FD4A8),
    warning: Color(0xFFE9C46A),
  );

  final Color water;
  final Color fertilise;
  final Color prune;
  final Color repot;
  final Color inspect;
  final Color sow;
  final Color harvest;
  final Color success;
  final Color warning;

  List<Color> get all => [
    water,
    fertilise,
    prune,
    repot,
    inspect,
    sow,
    harvest,
    success,
    warning,
  ];

  @override
  CareColors copyWith({
    Color? water,
    Color? fertilise,
    Color? prune,
    Color? repot,
    Color? inspect,
    Color? sow,
    Color? harvest,
    Color? success,
    Color? warning,
  }) => CareColors(
    water: water ?? this.water,
    fertilise: fertilise ?? this.fertilise,
    prune: prune ?? this.prune,
    repot: repot ?? this.repot,
    inspect: inspect ?? this.inspect,
    sow: sow ?? this.sow,
    harvest: harvest ?? this.harvest,
    success: success ?? this.success,
    warning: warning ?? this.warning,
  );

  @override
  CareColors lerp(covariant CareColors? other, double t) {
    if (other == null) return this;
    return CareColors(
      water: Color.lerp(water, other.water, t)!,
      fertilise: Color.lerp(fertilise, other.fertilise, t)!,
      prune: Color.lerp(prune, other.prune, t)!,
      repot: Color.lerp(repot, other.repot, t)!,
      inspect: Color.lerp(inspect, other.inspect, t)!,
      sow: Color.lerp(sow, other.sow, t)!,
      harvest: Color.lerp(harvest, other.harvest, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
    );
  }
}

extension CareColorsContext on BuildContext {
  CareColors get careColors =>
      Theme.of(this).extension<CareColors>() ?? CareColors.light;
}
