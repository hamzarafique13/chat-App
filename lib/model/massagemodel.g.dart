// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'massagemodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MassageModel _$$_MassageModelFromJson(Map<String, dynamic> json) =>
    _$_MassageModel(
      massageid: json['massageid'] as String,
      sender: json['sender'] as String,
      text: json['text'] as String,
      seen: json['seen'] as bool,
      createdon: DateTime.parse(json['createdon'] as String),
    );

Map<String, dynamic> _$$_MassageModelToJson(_$_MassageModel instance) =>
    <String, dynamic>{
      'massageid': instance.massageid,
      'sender': instance.sender,
      'text': instance.text,
      'seen': instance.seen,
      'createdon': instance.createdon.toIso8601String(),
    };
