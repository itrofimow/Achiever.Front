// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDto _$UserDtoFromJson(Map<String, dynamic> json) {
  return new UserDto(
      json['user'] == null
          ? null
          : new User.fromJson(json['user'] as Map<String, dynamic>),
      json['following'] as bool);
}

abstract class _$UserDtoSerializerMixin {
  User get user;
  bool get following;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'user': user, 'following': following};
}
