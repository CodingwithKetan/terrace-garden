// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'garden.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Garden {

 String get id; String get name; SpaceType get spaceType; DateTime get createdAt; DateTime get updatedAt; String? get cityName; GrowingRegion? get region; Length? get length; Length? get width; SunExposure get sun; Facing get facing; WindExposure get wind; WaterAccess get water; Set<GardenGoal> get goals; GardenStyle? get style; ExperienceLevel? get experience; WeeklyTime get weeklyTime; BudgetBand get budget; String? get coverPhotoId; String? get notes;
/// Create a copy of Garden
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GardenCopyWith<Garden> get copyWith => _$GardenCopyWithImpl<Garden>(this as Garden, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Garden&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.spaceType, spaceType) || other.spaceType == spaceType)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.cityName, cityName) || other.cityName == cityName)&&(identical(other.region, region) || other.region == region)&&(identical(other.length, length) || other.length == length)&&(identical(other.width, width) || other.width == width)&&(identical(other.sun, sun) || other.sun == sun)&&(identical(other.facing, facing) || other.facing == facing)&&(identical(other.wind, wind) || other.wind == wind)&&(identical(other.water, water) || other.water == water)&&const DeepCollectionEquality().equals(other.goals, goals)&&(identical(other.style, style) || other.style == style)&&(identical(other.experience, experience) || other.experience == experience)&&(identical(other.weeklyTime, weeklyTime) || other.weeklyTime == weeklyTime)&&(identical(other.budget, budget) || other.budget == budget)&&(identical(other.coverPhotoId, coverPhotoId) || other.coverPhotoId == coverPhotoId)&&(identical(other.notes, notes) || other.notes == notes));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,name,spaceType,createdAt,updatedAt,cityName,region,length,width,sun,facing,wind,water,const DeepCollectionEquality().hash(goals),style,experience,weeklyTime,budget,coverPhotoId,notes]);

@override
String toString() {
  return 'Garden(id: $id, name: $name, spaceType: $spaceType, createdAt: $createdAt, updatedAt: $updatedAt, cityName: $cityName, region: $region, length: $length, width: $width, sun: $sun, facing: $facing, wind: $wind, water: $water, goals: $goals, style: $style, experience: $experience, weeklyTime: $weeklyTime, budget: $budget, coverPhotoId: $coverPhotoId, notes: $notes)';
}


}

/// @nodoc
abstract mixin class $GardenCopyWith<$Res>  {
  factory $GardenCopyWith(Garden value, $Res Function(Garden) _then) = _$GardenCopyWithImpl;
@useResult
$Res call({
 String id, String name, SpaceType spaceType, DateTime createdAt, DateTime updatedAt, String? cityName, GrowingRegion? region, Length? length, Length? width, SunExposure sun, Facing facing, WindExposure wind, WaterAccess water, Set<GardenGoal> goals, GardenStyle? style, ExperienceLevel? experience, WeeklyTime weeklyTime, BudgetBand budget, String? coverPhotoId, String? notes
});




}
/// @nodoc
class _$GardenCopyWithImpl<$Res>
    implements $GardenCopyWith<$Res> {
  _$GardenCopyWithImpl(this._self, this._then);

  final Garden _self;
  final $Res Function(Garden) _then;

/// Create a copy of Garden
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? spaceType = null,Object? createdAt = null,Object? updatedAt = null,Object? cityName = freezed,Object? region = freezed,Object? length = freezed,Object? width = freezed,Object? sun = null,Object? facing = null,Object? wind = null,Object? water = null,Object? goals = null,Object? style = freezed,Object? experience = freezed,Object? weeklyTime = null,Object? budget = null,Object? coverPhotoId = freezed,Object? notes = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,spaceType: null == spaceType ? _self.spaceType : spaceType // ignore: cast_nullable_to_non_nullable
as SpaceType,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,cityName: freezed == cityName ? _self.cityName : cityName // ignore: cast_nullable_to_non_nullable
as String?,region: freezed == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as GrowingRegion?,length: freezed == length ? _self.length : length // ignore: cast_nullable_to_non_nullable
as Length?,width: freezed == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as Length?,sun: null == sun ? _self.sun : sun // ignore: cast_nullable_to_non_nullable
as SunExposure,facing: null == facing ? _self.facing : facing // ignore: cast_nullable_to_non_nullable
as Facing,wind: null == wind ? _self.wind : wind // ignore: cast_nullable_to_non_nullable
as WindExposure,water: null == water ? _self.water : water // ignore: cast_nullable_to_non_nullable
as WaterAccess,goals: null == goals ? _self.goals : goals // ignore: cast_nullable_to_non_nullable
as Set<GardenGoal>,style: freezed == style ? _self.style : style // ignore: cast_nullable_to_non_nullable
as GardenStyle?,experience: freezed == experience ? _self.experience : experience // ignore: cast_nullable_to_non_nullable
as ExperienceLevel?,weeklyTime: null == weeklyTime ? _self.weeklyTime : weeklyTime // ignore: cast_nullable_to_non_nullable
as WeeklyTime,budget: null == budget ? _self.budget : budget // ignore: cast_nullable_to_non_nullable
as BudgetBand,coverPhotoId: freezed == coverPhotoId ? _self.coverPhotoId : coverPhotoId // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Garden].
extension GardenPatterns on Garden {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Garden value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Garden() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Garden value)  $default,){
final _that = this;
switch (_that) {
case _Garden():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Garden value)?  $default,){
final _that = this;
switch (_that) {
case _Garden() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  SpaceType spaceType,  DateTime createdAt,  DateTime updatedAt,  String? cityName,  GrowingRegion? region,  Length? length,  Length? width,  SunExposure sun,  Facing facing,  WindExposure wind,  WaterAccess water,  Set<GardenGoal> goals,  GardenStyle? style,  ExperienceLevel? experience,  WeeklyTime weeklyTime,  BudgetBand budget,  String? coverPhotoId,  String? notes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Garden() when $default != null:
return $default(_that.id,_that.name,_that.spaceType,_that.createdAt,_that.updatedAt,_that.cityName,_that.region,_that.length,_that.width,_that.sun,_that.facing,_that.wind,_that.water,_that.goals,_that.style,_that.experience,_that.weeklyTime,_that.budget,_that.coverPhotoId,_that.notes);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  SpaceType spaceType,  DateTime createdAt,  DateTime updatedAt,  String? cityName,  GrowingRegion? region,  Length? length,  Length? width,  SunExposure sun,  Facing facing,  WindExposure wind,  WaterAccess water,  Set<GardenGoal> goals,  GardenStyle? style,  ExperienceLevel? experience,  WeeklyTime weeklyTime,  BudgetBand budget,  String? coverPhotoId,  String? notes)  $default,) {final _that = this;
switch (_that) {
case _Garden():
return $default(_that.id,_that.name,_that.spaceType,_that.createdAt,_that.updatedAt,_that.cityName,_that.region,_that.length,_that.width,_that.sun,_that.facing,_that.wind,_that.water,_that.goals,_that.style,_that.experience,_that.weeklyTime,_that.budget,_that.coverPhotoId,_that.notes);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  SpaceType spaceType,  DateTime createdAt,  DateTime updatedAt,  String? cityName,  GrowingRegion? region,  Length? length,  Length? width,  SunExposure sun,  Facing facing,  WindExposure wind,  WaterAccess water,  Set<GardenGoal> goals,  GardenStyle? style,  ExperienceLevel? experience,  WeeklyTime weeklyTime,  BudgetBand budget,  String? coverPhotoId,  String? notes)?  $default,) {final _that = this;
switch (_that) {
case _Garden() when $default != null:
return $default(_that.id,_that.name,_that.spaceType,_that.createdAt,_that.updatedAt,_that.cityName,_that.region,_that.length,_that.width,_that.sun,_that.facing,_that.wind,_that.water,_that.goals,_that.style,_that.experience,_that.weeklyTime,_that.budget,_that.coverPhotoId,_that.notes);case _:
  return null;

}
}

}

/// @nodoc


class _Garden extends Garden {
  const _Garden({required this.id, required this.name, required this.spaceType, required this.createdAt, required this.updatedAt, this.cityName, this.region, this.length, this.width, this.sun = SunExposure.unknown, this.facing = Facing.unknown, this.wind = WindExposure.unknown, this.water = WaterAccess.unknown, final  Set<GardenGoal> goals = const <GardenGoal>{}, this.style, this.experience, this.weeklyTime = WeeklyTime.unknown, this.budget = BudgetBand.unknown, this.coverPhotoId, this.notes}): _goals = goals,super._();
  

@override final  String id;
@override final  String name;
@override final  SpaceType spaceType;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  String? cityName;
@override final  GrowingRegion? region;
@override final  Length? length;
@override final  Length? width;
@override@JsonKey() final  SunExposure sun;
@override@JsonKey() final  Facing facing;
@override@JsonKey() final  WindExposure wind;
@override@JsonKey() final  WaterAccess water;
 final  Set<GardenGoal> _goals;
@override@JsonKey() Set<GardenGoal> get goals {
  if (_goals is EqualUnmodifiableSetView) return _goals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_goals);
}

@override final  GardenStyle? style;
@override final  ExperienceLevel? experience;
@override@JsonKey() final  WeeklyTime weeklyTime;
@override@JsonKey() final  BudgetBand budget;
@override final  String? coverPhotoId;
@override final  String? notes;

/// Create a copy of Garden
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GardenCopyWith<_Garden> get copyWith => __$GardenCopyWithImpl<_Garden>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Garden&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.spaceType, spaceType) || other.spaceType == spaceType)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.cityName, cityName) || other.cityName == cityName)&&(identical(other.region, region) || other.region == region)&&(identical(other.length, length) || other.length == length)&&(identical(other.width, width) || other.width == width)&&(identical(other.sun, sun) || other.sun == sun)&&(identical(other.facing, facing) || other.facing == facing)&&(identical(other.wind, wind) || other.wind == wind)&&(identical(other.water, water) || other.water == water)&&const DeepCollectionEquality().equals(other._goals, _goals)&&(identical(other.style, style) || other.style == style)&&(identical(other.experience, experience) || other.experience == experience)&&(identical(other.weeklyTime, weeklyTime) || other.weeklyTime == weeklyTime)&&(identical(other.budget, budget) || other.budget == budget)&&(identical(other.coverPhotoId, coverPhotoId) || other.coverPhotoId == coverPhotoId)&&(identical(other.notes, notes) || other.notes == notes));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,name,spaceType,createdAt,updatedAt,cityName,region,length,width,sun,facing,wind,water,const DeepCollectionEquality().hash(_goals),style,experience,weeklyTime,budget,coverPhotoId,notes]);

@override
String toString() {
  return 'Garden(id: $id, name: $name, spaceType: $spaceType, createdAt: $createdAt, updatedAt: $updatedAt, cityName: $cityName, region: $region, length: $length, width: $width, sun: $sun, facing: $facing, wind: $wind, water: $water, goals: $goals, style: $style, experience: $experience, weeklyTime: $weeklyTime, budget: $budget, coverPhotoId: $coverPhotoId, notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$GardenCopyWith<$Res> implements $GardenCopyWith<$Res> {
  factory _$GardenCopyWith(_Garden value, $Res Function(_Garden) _then) = __$GardenCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, SpaceType spaceType, DateTime createdAt, DateTime updatedAt, String? cityName, GrowingRegion? region, Length? length, Length? width, SunExposure sun, Facing facing, WindExposure wind, WaterAccess water, Set<GardenGoal> goals, GardenStyle? style, ExperienceLevel? experience, WeeklyTime weeklyTime, BudgetBand budget, String? coverPhotoId, String? notes
});




}
/// @nodoc
class __$GardenCopyWithImpl<$Res>
    implements _$GardenCopyWith<$Res> {
  __$GardenCopyWithImpl(this._self, this._then);

  final _Garden _self;
  final $Res Function(_Garden) _then;

/// Create a copy of Garden
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? spaceType = null,Object? createdAt = null,Object? updatedAt = null,Object? cityName = freezed,Object? region = freezed,Object? length = freezed,Object? width = freezed,Object? sun = null,Object? facing = null,Object? wind = null,Object? water = null,Object? goals = null,Object? style = freezed,Object? experience = freezed,Object? weeklyTime = null,Object? budget = null,Object? coverPhotoId = freezed,Object? notes = freezed,}) {
  return _then(_Garden(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,spaceType: null == spaceType ? _self.spaceType : spaceType // ignore: cast_nullable_to_non_nullable
as SpaceType,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,cityName: freezed == cityName ? _self.cityName : cityName // ignore: cast_nullable_to_non_nullable
as String?,region: freezed == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as GrowingRegion?,length: freezed == length ? _self.length : length // ignore: cast_nullable_to_non_nullable
as Length?,width: freezed == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as Length?,sun: null == sun ? _self.sun : sun // ignore: cast_nullable_to_non_nullable
as SunExposure,facing: null == facing ? _self.facing : facing // ignore: cast_nullable_to_non_nullable
as Facing,wind: null == wind ? _self.wind : wind // ignore: cast_nullable_to_non_nullable
as WindExposure,water: null == water ? _self.water : water // ignore: cast_nullable_to_non_nullable
as WaterAccess,goals: null == goals ? _self._goals : goals // ignore: cast_nullable_to_non_nullable
as Set<GardenGoal>,style: freezed == style ? _self.style : style // ignore: cast_nullable_to_non_nullable
as GardenStyle?,experience: freezed == experience ? _self.experience : experience // ignore: cast_nullable_to_non_nullable
as ExperienceLevel?,weeklyTime: null == weeklyTime ? _self.weeklyTime : weeklyTime // ignore: cast_nullable_to_non_nullable
as WeeklyTime,budget: null == budget ? _self.budget : budget // ignore: cast_nullable_to_non_nullable
as BudgetBand,coverPhotoId: freezed == coverPhotoId ? _self.coverPhotoId : coverPhotoId // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
