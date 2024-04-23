// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'massagemodel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MassageModel _$MassageModelFromJson(Map<String, dynamic> json) {
  return _MassageModel.fromJson(json);
}

/// @nodoc
mixin _$MassageModel {
  String get massageid => throw _privateConstructorUsedError;
  String get sender => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  bool get seen => throw _privateConstructorUsedError;
  DateTime get createdon => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MassageModelCopyWith<MassageModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MassageModelCopyWith<$Res> {
  factory $MassageModelCopyWith(
          MassageModel value, $Res Function(MassageModel) then) =
      _$MassageModelCopyWithImpl<$Res, MassageModel>;
  @useResult
  $Res call(
      {String massageid,
      String sender,
      String text,
      bool seen,
      DateTime createdon});
}

/// @nodoc
class _$MassageModelCopyWithImpl<$Res, $Val extends MassageModel>
    implements $MassageModelCopyWith<$Res> {
  _$MassageModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? massageid = null,
    Object? sender = null,
    Object? text = null,
    Object? seen = null,
    Object? createdon = null,
  }) {
    return _then(_value.copyWith(
      massageid: null == massageid
          ? _value.massageid
          : massageid // ignore: cast_nullable_to_non_nullable
              as String,
      sender: null == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      seen: null == seen
          ? _value.seen
          : seen // ignore: cast_nullable_to_non_nullable
              as bool,
      createdon: null == createdon
          ? _value.createdon
          : createdon // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MassageModelCopyWith<$Res>
    implements $MassageModelCopyWith<$Res> {
  factory _$$_MassageModelCopyWith(
          _$_MassageModel value, $Res Function(_$_MassageModel) then) =
      __$$_MassageModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String massageid,
      String sender,
      String text,
      bool seen,
      DateTime createdon});
}

/// @nodoc
class __$$_MassageModelCopyWithImpl<$Res>
    extends _$MassageModelCopyWithImpl<$Res, _$_MassageModel>
    implements _$$_MassageModelCopyWith<$Res> {
  __$$_MassageModelCopyWithImpl(
      _$_MassageModel _value, $Res Function(_$_MassageModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? massageid = null,
    Object? sender = null,
    Object? text = null,
    Object? seen = null,
    Object? createdon = null,
  }) {
    return _then(_$_MassageModel(
      massageid: null == massageid
          ? _value.massageid
          : massageid // ignore: cast_nullable_to_non_nullable
              as String,
      sender: null == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      seen: null == seen
          ? _value.seen
          : seen // ignore: cast_nullable_to_non_nullable
              as bool,
      createdon: null == createdon
          ? _value.createdon
          : createdon // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MassageModel implements _MassageModel {
  _$_MassageModel(
      {required this.massageid,
      required this.sender,
      required this.text,
      required this.seen,
      required this.createdon});

  factory _$_MassageModel.fromJson(Map<String, dynamic> json) =>
      _$$_MassageModelFromJson(json);

  @override
  final String massageid;
  @override
  final String sender;
  @override
  final String text;
  @override
  final bool seen;
  @override
  final DateTime createdon;

  @override
  String toString() {
    return 'MassageModel(massageid: $massageid, sender: $sender, text: $text, seen: $seen, createdon: $createdon)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MassageModel &&
            (identical(other.massageid, massageid) ||
                other.massageid == massageid) &&
            (identical(other.sender, sender) || other.sender == sender) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.seen, seen) || other.seen == seen) &&
            (identical(other.createdon, createdon) ||
                other.createdon == createdon));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, massageid, sender, text, seen, createdon);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MassageModelCopyWith<_$_MassageModel> get copyWith =>
      __$$_MassageModelCopyWithImpl<_$_MassageModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MassageModelToJson(
      this,
    );
  }
}

abstract class _MassageModel implements MassageModel {
  factory _MassageModel(
      {required final String massageid,
      required final String sender,
      required final String text,
      required final bool seen,
      required final DateTime createdon}) = _$_MassageModel;

  factory _MassageModel.fromJson(Map<String, dynamic> json) =
      _$_MassageModel.fromJson;

  @override
  String get massageid;
  @override
  String get sender;
  @override
  String get text;
  @override
  bool get seen;
  @override
  DateTime get createdon;
  @override
  @JsonKey(ignore: true)
  _$$_MassageModelCopyWith<_$_MassageModel> get copyWith =>
      throw _privateConstructorUsedError;
}
