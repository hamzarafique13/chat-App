import 'package:freezed_annotation/freezed_annotation.dart';

part 'chatmodel.freezed.dart';
part 'chatmodel.g.dart';

@freezed
class ChatModel with _$ChatModel {
  factory ChatModel({
    required String chatroomid,
    required Map<String, dynamic> participants,
    required String lastmassage,
  }) = _ChatModel;

  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);


}
