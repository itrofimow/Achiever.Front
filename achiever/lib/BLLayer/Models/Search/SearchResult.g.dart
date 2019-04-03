// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SearchResult.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResult _$SearchResultFromJson(Map<String, dynamic> json) {
  return new SearchResult(
      (json['achievements'] as List)
          ?.map((e) => e == null
              ? null
              : new Achievement.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      (json['users'] as List)
          ?.map((e) => e == null
              ? null
              : new UserDto.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

abstract class _$SearchResultSerializerMixin {
  List<Achievement> get achievements;
  List<UserDto> get users;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'achievements': achievements, 'users': users};
}
