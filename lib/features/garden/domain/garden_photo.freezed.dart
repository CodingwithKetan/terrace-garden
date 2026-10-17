// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'garden_photo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GardenPhoto {

 String get id; String get gardenId; String get relativePath; String get thumbnailPath; int get width; int get height; DateTime get takenAt; DateTime get createdAt; String? get caption;
/// Create a copy of GardenPhoto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GardenPhotoCopyWith<GardenPhoto> get copyWith => _$GardenPhotoCopyWithImpl<GardenPhoto>(this as GardenPhoto, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GardenPhoto&&(identical(other.id, id) || other.id == id)&&(identical(other.gardenId, gardenId) || other.gardenId == gardenId)&&(identical(other.relativePath, relativePath) || other.relativePath == relativePath)&&(identical(other.thumbnailPath, thumbnailPath) || other.thumbnailPath == thumbnailPath)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.takenAt, takenAt) || other.takenAt == takenAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.caption, caption) || other.caption == caption));
}


@override
int get hashCode => Object.hash(runtimeType,id,gardenId,relativePath,thumbnailPath,width,height,takenAt,createdAt,caption);

@override
String toString() {
  return 'GardenPhoto(id: $id, gardenId: $gardenId, relativePath: $relativePath, thumbnailPath: $thumbnailPath, width: $width, height: $height, takenAt: $takenAt, createdAt: $createdAt, caption: $caption)';
}


}

/// @nodoc
abstract mixin class $GardenPhotoCopyWith<$Res>  {
  factory $GardenPhotoCopyWith(GardenPhoto value, $Res Function(GardenPhoto) _then) = _$GardenPhotoCopyWithImpl;
@useResult
$Res call({
 String id, String gardenId, String relativePath, String thumbnailPath, int width, int height, DateTime takenAt, DateTime createdAt, String? caption
});




}
/// @nodoc
class _$GardenPhotoCopyWithImpl<$Res>
    implements $GardenPhotoCopyWith<$Res> {
  _$GardenPhotoCopyWithImpl(this._self, this._then);

  final GardenPhoto _self;
  final $Res Function(GardenPhoto) _then;

/// Create a copy of GardenPhoto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? gardenId = null,Object? relativePath = null,Object? thumbnailPath = null,Object? width = null,Object? height = null,Object? takenAt = null,Object? createdAt = null,Object? caption = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,gardenId: null == gardenId ? _self.gardenId : gardenId // ignore: cast_nullable_to_non_nullable
as String,relativePath: null == relativePath ? _self.relativePath : relativePath // ignore: cast_nullable_to_non_nullable
as String,thumbnailPath: null == thumbnailPath ? _self.thumbnailPath : thumbnailPath // ignore: cast_nullable_to_non_nullable
as String,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as int,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int,takenAt: null == takenAt ? _self.takenAt : takenAt // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,caption: freezed == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [GardenPhoto].
extension GardenPhotoPatterns on GardenPhoto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GardenPhoto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GardenPhoto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GardenPhoto value)  $default,){
final _that = this;
switch (_that) {
case _GardenPhoto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GardenPhoto value)?  $default,){
final _that = this;
switch (_that) {
case _GardenPhoto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String gardenId,  String relativePath,  String thumbnailPath,  int width,  int height,  DateTime takenAt,  DateTime createdAt,  String? caption)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GardenPhoto() when $default != null:
return $default(_that.id,_that.gardenId,_that.relativePath,_that.thumbnailPath,_that.width,_that.height,_that.takenAt,_that.createdAt,_that.caption);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String gardenId,  String relativePath,  String thumbnailPath,  int width,  int height,  DateTime takenAt,  DateTime createdAt,  String? caption)  $default,) {final _that = this;
switch (_that) {
case _GardenPhoto():
return $default(_that.id,_that.gardenId,_that.relativePath,_that.thumbnailPath,_that.width,_that.height,_that.takenAt,_that.createdAt,_that.caption);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String gardenId,  String relativePath,  String thumbnailPath,  int width,  int height,  DateTime takenAt,  DateTime createdAt,  String? caption)?  $default,) {final _that = this;
switch (_that) {
case _GardenPhoto() when $default != null:
return $default(_that.id,_that.gardenId,_that.relativePath,_that.thumbnailPath,_that.width,_that.height,_that.takenAt,_that.createdAt,_that.caption);case _:
  return null;

}
}

}

/// @nodoc


class _GardenPhoto implements GardenPhoto {
  const _GardenPhoto({required this.id, required this.gardenId, required this.relativePath, required this.thumbnailPath, required this.width, required this.height, required this.takenAt, required this.createdAt, this.caption});
  

@override final  String id;
@override final  String gardenId;
@override final  String relativePath;
@override final  String thumbnailPath;
@override final  int width;
@override final  int height;
@override final  DateTime takenAt;
@override final  DateTime createdAt;
@override final  String? caption;

/// Create a copy of GardenPhoto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GardenPhotoCopyWith<_GardenPhoto> get copyWith => __$GardenPhotoCopyWithImpl<_GardenPhoto>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GardenPhoto&&(identical(other.id, id) || other.id == id)&&(identical(other.gardenId, gardenId) || other.gardenId == gardenId)&&(identical(other.relativePath, relativePath) || other.relativePath == relativePath)&&(identical(other.thumbnailPath, thumbnailPath) || other.thumbnailPath == thumbnailPath)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.takenAt, takenAt) || other.takenAt == takenAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.caption, caption) || other.caption == caption));
}


@override
int get hashCode => Object.hash(runtimeType,id,gardenId,relativePath,thumbnailPath,width,height,takenAt,createdAt,caption);

@override
String toString() {
  return 'GardenPhoto(id: $id, gardenId: $gardenId, relativePath: $relativePath, thumbnailPath: $thumbnailPath, width: $width, height: $height, takenAt: $takenAt, createdAt: $createdAt, caption: $caption)';
}


}

/// @nodoc
abstract mixin class _$GardenPhotoCopyWith<$Res> implements $GardenPhotoCopyWith<$Res> {
  factory _$GardenPhotoCopyWith(_GardenPhoto value, $Res Function(_GardenPhoto) _then) = __$GardenPhotoCopyWithImpl;
@override @useResult
$Res call({
 String id, String gardenId, String relativePath, String thumbnailPath, int width, int height, DateTime takenAt, DateTime createdAt, String? caption
});




}
/// @nodoc
class __$GardenPhotoCopyWithImpl<$Res>
    implements _$GardenPhotoCopyWith<$Res> {
  __$GardenPhotoCopyWithImpl(this._self, this._then);

  final _GardenPhoto _self;
  final $Res Function(_GardenPhoto) _then;

/// Create a copy of GardenPhoto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? gardenId = null,Object? relativePath = null,Object? thumbnailPath = null,Object? width = null,Object? height = null,Object? takenAt = null,Object? createdAt = null,Object? caption = freezed,}) {
  return _then(_GardenPhoto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,gardenId: null == gardenId ? _self.gardenId : gardenId // ignore: cast_nullable_to_non_nullable
as String,relativePath: null == relativePath ? _self.relativePath : relativePath // ignore: cast_nullable_to_non_nullable
as String,thumbnailPath: null == thumbnailPath ? _self.thumbnailPath : thumbnailPath // ignore: cast_nullable_to_non_nullable
as String,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as int,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int,takenAt: null == takenAt ? _self.takenAt : takenAt // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,caption: freezed == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
