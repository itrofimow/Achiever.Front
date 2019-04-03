// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AllUsersDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllUsersDto _$AllUsersDtoFromJson(Map<String, dynamic> json) {
  return new AllUsersDto((json['allUsers'] as List)
      ?.map((e) =>
          e == null ? null : new UserDto.fromJson(e as Map<String, dynamic>))
      ?.toList());
}

abstract class _$AllUsersDtoSerializerMixin {
  List<UserDto> get allUsers;
  Map<String, dynamic> toJson() => <String, dynamic>{'allUsers': allUsers};
}
