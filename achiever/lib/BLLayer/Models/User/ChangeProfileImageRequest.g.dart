// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ChangeProfileImageRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangeProfileImageRequest _$ChangeProfileImageRequestFromJson(
    Map<String, dynamic> json) {
  return new ChangeProfileImageRequest(json['profileImagePath'] as String);
}

abstract class _$ChangeProfileImageRequestSerializerMixin {
  String get profileImagePath;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'profileImagePath': profileImagePath};
}
