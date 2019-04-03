// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserWithToken.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserWithToken _$UserWithTokenFromJson(Map<String, dynamic> json) {
  return new UserWithToken(
      json['token'] as String,
      json['user'] == null
          ? null
          : new User.fromJson(json['user'] as Map<String, dynamic>));
}

abstract class _$UserWithTokenSerializerMixin {
  String get token;
  User get user;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'token': token, 'user': user};
}
