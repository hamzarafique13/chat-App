import 'package:freezed_annotation/freezed_annotation.dart';

part 'massagemodel.freezed.dart';
part 'massagemodel.g.dart';

@freezed
class MassageModel with _$MassageModel {
  factory MassageModel({
    required String massageid,
    required String sender,
    required String text,
    required bool seen,
    required DateTime createdon,
  }) = _MassageModel;

  factory MassageModel.fromJson(Map<String, dynamic> json) =>
      _$MassageModelFromJson(json);
}
