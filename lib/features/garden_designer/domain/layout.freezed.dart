// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'layout.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LayoutElement {

 String get id; ElementKind get kind; Vec2 get center; double get width; double get height; double get rotationDeg; double? get depthCm; String? get label;
/// Create a copy of LayoutElement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LayoutElementCopyWith<LayoutElement> get copyWith => _$LayoutElementCopyWithImpl<LayoutElement>(this as LayoutElement, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LayoutElement&&(identical(other.id, id) || other.id == id)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.center, center) || other.center == center)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.rotationDeg, rotationDeg) || other.rotationDeg == rotationDeg)&&(identical(other.depthCm, depthCm) || other.depthCm == depthCm)&&(identical(other.label, label) || other.label == label));
}


@override
int get hashCode => Object.hash(runtimeType,id,kind,center,width,height,rotationDeg,depthCm,label);

@override
String toString() {
  return 'LayoutElement(id: $id, kind: $kind, center: $center, width: $width, height: $height, rotationDeg: $rotationDeg, depthCm: $depthCm, label: $label)';
}


}

/// @nodoc
abstract mixin class $LayoutElementCopyWith<$Res>  {
  factory $LayoutElementCopyWith(LayoutElement value, $Res Function(LayoutElement) _then) = _$LayoutElementCopyWithImpl;
@useResult
$Res call({
 String id, ElementKind kind, Vec2 center, double width, double height, double rotationDeg, double? depthCm, String? label
});




}
/// @nodoc
class _$LayoutElementCopyWithImpl<$Res>
    implements $LayoutElementCopyWith<$Res> {
  _$LayoutElementCopyWithImpl(this._self, this._then);

  final LayoutElement _self;
  final $Res Function(LayoutElement) _then;

/// Create a copy of LayoutElement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? kind = null,Object? center = null,Object? width = null,Object? height = null,Object? rotationDeg = null,Object? depthCm = freezed,Object? label = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as ElementKind,center: null == center ? _self.center : center // ignore: cast_nullable_to_non_nullable
as Vec2,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double,rotationDeg: null == rotationDeg ? _self.rotationDeg : rotationDeg // ignore: cast_nullable_to_non_nullable
as double,depthCm: freezed == depthCm ? _self.depthCm : depthCm // ignore: cast_nullable_to_non_nullable
as double?,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [LayoutElement].
extension LayoutElementPatterns on LayoutElement {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LayoutElement value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LayoutElement() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LayoutElement value)  $default,){
final _that = this;
switch (_that) {
case _LayoutElement():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LayoutElement value)?  $default,){
final _that = this;
switch (_that) {
case _LayoutElement() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  ElementKind kind,  Vec2 center,  double width,  double height,  double rotationDeg,  double? depthCm,  String? label)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LayoutElement() when $default != null:
return $default(_that.id,_that.kind,_that.center,_that.width,_that.height,_that.rotationDeg,_that.depthCm,_that.label);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  ElementKind kind,  Vec2 center,  double width,  double height,  double rotationDeg,  double? depthCm,  String? label)  $default,) {final _that = this;
switch (_that) {
case _LayoutElement():
return $default(_that.id,_that.kind,_that.center,_that.width,_that.height,_that.rotationDeg,_that.depthCm,_that.label);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  ElementKind kind,  Vec2 center,  double width,  double height,  double rotationDeg,  double? depthCm,  String? label)?  $default,) {final _that = this;
switch (_that) {
case _LayoutElement() when $default != null:
return $default(_that.id,_that.kind,_that.center,_that.width,_that.height,_that.rotationDeg,_that.depthCm,_that.label);case _:
  return null;

}
}

}

/// @nodoc


class _LayoutElement extends LayoutElement {
  const _LayoutElement({required this.id, required this.kind, required this.center, required this.width, required this.height, this.rotationDeg = 0, this.depthCm, this.label}): super._();
  

@override final  String id;
@override final  ElementKind kind;
@override final  Vec2 center;
@override final  double width;
@override final  double height;
@override@JsonKey() final  double rotationDeg;
@override final  double? depthCm;
@override final  String? label;

/// Create a copy of LayoutElement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LayoutElementCopyWith<_LayoutElement> get copyWith => __$LayoutElementCopyWithImpl<_LayoutElement>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LayoutElement&&(identical(other.id, id) || other.id == id)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.center, center) || other.center == center)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.rotationDeg, rotationDeg) || other.rotationDeg == rotationDeg)&&(identical(other.depthCm, depthCm) || other.depthCm == depthCm)&&(identical(other.label, label) || other.label == label));
}


@override
int get hashCode => Object.hash(runtimeType,id,kind,center,width,height,rotationDeg,depthCm,label);

@override
String toString() {
  return 'LayoutElement(id: $id, kind: $kind, center: $center, width: $width, height: $height, rotationDeg: $rotationDeg, depthCm: $depthCm, label: $label)';
}


}

/// @nodoc
abstract mixin class _$LayoutElementCopyWith<$Res> implements $LayoutElementCopyWith<$Res> {
  factory _$LayoutElementCopyWith(_LayoutElement value, $Res Function(_LayoutElement) _then) = __$LayoutElementCopyWithImpl;
@override @useResult
$Res call({
 String id, ElementKind kind, Vec2 center, double width, double height, double rotationDeg, double? depthCm, String? label
});




}
/// @nodoc
class __$LayoutElementCopyWithImpl<$Res>
    implements _$LayoutElementCopyWith<$Res> {
  __$LayoutElementCopyWithImpl(this._self, this._then);

  final _LayoutElement _self;
  final $Res Function(_LayoutElement) _then;

/// Create a copy of LayoutElement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? kind = null,Object? center = null,Object? width = null,Object? height = null,Object? rotationDeg = null,Object? depthCm = freezed,Object? label = freezed,}) {
  return _then(_LayoutElement(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as ElementKind,center: null == center ? _self.center : center // ignore: cast_nullable_to_non_nullable
as Vec2,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double,rotationDeg: null == rotationDeg ? _self.rotationDeg : rotationDeg // ignore: cast_nullable_to_non_nullable
as double,depthCm: freezed == depthCm ? _self.depthCm : depthCm // ignore: cast_nullable_to_non_nullable
as double?,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$LayoutDocument {

 String get gardenId;/// Garden size along x (length) and y (width), in cm.
 double get length; double get width; List<LayoutElement> get elements;
/// Create a copy of LayoutDocument
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LayoutDocumentCopyWith<LayoutDocument> get copyWith => _$LayoutDocumentCopyWithImpl<LayoutDocument>(this as LayoutDocument, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LayoutDocument&&(identical(other.gardenId, gardenId) || other.gardenId == gardenId)&&(identical(other.length, length) || other.length == length)&&(identical(other.width, width) || other.width == width)&&const DeepCollectionEquality().equals(other.elements, elements));
}


@override
int get hashCode => Object.hash(runtimeType,gardenId,length,width,const DeepCollectionEquality().hash(elements));

@override
String toString() {
  return 'LayoutDocument(gardenId: $gardenId, length: $length, width: $width, elements: $elements)';
}


}

/// @nodoc
abstract mixin class $LayoutDocumentCopyWith<$Res>  {
  factory $LayoutDocumentCopyWith(LayoutDocument value, $Res Function(LayoutDocument) _then) = _$LayoutDocumentCopyWithImpl;
@useResult
$Res call({
 String gardenId, double length, double width, List<LayoutElement> elements
});




}
/// @nodoc
class _$LayoutDocumentCopyWithImpl<$Res>
    implements $LayoutDocumentCopyWith<$Res> {
  _$LayoutDocumentCopyWithImpl(this._self, this._then);

  final LayoutDocument _self;
  final $Res Function(LayoutDocument) _then;

/// Create a copy of LayoutDocument
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? gardenId = null,Object? length = null,Object? width = null,Object? elements = null,}) {
  return _then(_self.copyWith(
gardenId: null == gardenId ? _self.gardenId : gardenId // ignore: cast_nullable_to_non_nullable
as String,length: null == length ? _self.length : length // ignore: cast_nullable_to_non_nullable
as double,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double,elements: null == elements ? _self.elements : elements // ignore: cast_nullable_to_non_nullable
as List<LayoutElement>,
  ));
}

}


/// Adds pattern-matching-related methods to [LayoutDocument].
extension LayoutDocumentPatterns on LayoutDocument {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LayoutDocument value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LayoutDocument() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LayoutDocument value)  $default,){
final _that = this;
switch (_that) {
case _LayoutDocument():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LayoutDocument value)?  $default,){
final _that = this;
switch (_that) {
case _LayoutDocument() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String gardenId,  double length,  double width,  List<LayoutElement> elements)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LayoutDocument() when $default != null:
return $default(_that.gardenId,_that.length,_that.width,_that.elements);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String gardenId,  double length,  double width,  List<LayoutElement> elements)  $default,) {final _that = this;
switch (_that) {
case _LayoutDocument():
return $default(_that.gardenId,_that.length,_that.width,_that.elements);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String gardenId,  double length,  double width,  List<LayoutElement> elements)?  $default,) {final _that = this;
switch (_that) {
case _LayoutDocument() when $default != null:
return $default(_that.gardenId,_that.length,_that.width,_that.elements);case _:
  return null;

}
}

}

/// @nodoc


class _LayoutDocument extends LayoutDocument {
  const _LayoutDocument({required this.gardenId, required this.length, required this.width, final  List<LayoutElement> elements = const <LayoutElement>[]}): _elements = elements,super._();
  

@override final  String gardenId;
/// Garden size along x (length) and y (width), in cm.
@override final  double length;
@override final  double width;
 final  List<LayoutElement> _elements;
@override@JsonKey() List<LayoutElement> get elements {
  if (_elements is EqualUnmodifiableListView) return _elements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_elements);
}


/// Create a copy of LayoutDocument
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LayoutDocumentCopyWith<_LayoutDocument> get copyWith => __$LayoutDocumentCopyWithImpl<_LayoutDocument>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LayoutDocument&&(identical(other.gardenId, gardenId) || other.gardenId == gardenId)&&(identical(other.length, length) || other.length == length)&&(identical(other.width, width) || other.width == width)&&const DeepCollectionEquality().equals(other._elements, _elements));
}


@override
int get hashCode => Object.hash(runtimeType,gardenId,length,width,const DeepCollectionEquality().hash(_elements));

@override
String toString() {
  return 'LayoutDocument(gardenId: $gardenId, length: $length, width: $width, elements: $elements)';
}


}

/// @nodoc
abstract mixin class _$LayoutDocumentCopyWith<$Res> implements $LayoutDocumentCopyWith<$Res> {
  factory _$LayoutDocumentCopyWith(_LayoutDocument value, $Res Function(_LayoutDocument) _then) = __$LayoutDocumentCopyWithImpl;
@override @useResult
$Res call({
 String gardenId, double length, double width, List<LayoutElement> elements
});




}
/// @nodoc
class __$LayoutDocumentCopyWithImpl<$Res>
    implements _$LayoutDocumentCopyWith<$Res> {
  __$LayoutDocumentCopyWithImpl(this._self, this._then);

  final _LayoutDocument _self;
  final $Res Function(_LayoutDocument) _then;

/// Create a copy of LayoutDocument
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? gardenId = null,Object? length = null,Object? width = null,Object? elements = null,}) {
  return _then(_LayoutDocument(
gardenId: null == gardenId ? _self.gardenId : gardenId // ignore: cast_nullable_to_non_nullable
as String,length: null == length ? _self.length : length // ignore: cast_nullable_to_non_nullable
as double,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double,elements: null == elements ? _self._elements : elements // ignore: cast_nullable_to_non_nullable
as List<LayoutElement>,
  ));
}


}

// dart format on
