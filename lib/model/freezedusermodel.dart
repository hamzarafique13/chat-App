import 'package:freezed_annotation/freezed_annotation.dart';

part 'freezedusermodel.freezed.dart';
part 'freezedusermodel.g.dart';

@freezed
class UserModel with _$UserModel {
  factory UserModel({
    required String fullname,
    required String id,
    required String email,
    required String profilepic,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
