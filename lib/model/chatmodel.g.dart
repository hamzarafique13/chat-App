// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chatmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ChatModel _$$_ChatModelFromJson(Map<String, dynamic> json) => _$_ChatModel(
      chatroomid: json['chatroomid'] as String,
      participants: json['participants'] as Map<String, dynamic>,
      lastmassage: json['lastmassage'] as String,
    );

Map<String, dynamic> _$$_ChatModelToJson(_$_ChatModel instance) =>
    <String, dynamic>{
      'chatroomid': instance.chatroomid,
      'participants': instance.participants,
      'lastmassage': instance.lastmassage,
    };
