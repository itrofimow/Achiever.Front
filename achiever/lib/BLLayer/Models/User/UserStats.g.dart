// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserStats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserStats _$UserStatsFromJson(Map<String, dynamic> json) {
  return new UserStats(json['following'] as int, json['followers'] as int,
      json['achievementsCount'] as int);
}

abstract class _$UserStatsSerializerMixin {
  int get following;
  int get followers;
  int get achievementsCount;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'following': following,
        'followers': followers,
        'achievementsCount': achievementsCount
      };
}
