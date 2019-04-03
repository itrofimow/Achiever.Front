// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AllAchievementsResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllAchievementsResponse _$AllAchievementsResponseFromJson(
    Map<String, dynamic> json) {
  return new AllAchievementsResponse((json['achievements'] as List)
      ?.map((e) => e == null
          ? null
          : new Achievement.fromJson(e as Map<String, dynamic>))
      ?.toList());
}

abstract class _$AllAchievementsResponseSerializerMixin {
  List<Achievement> get achievements;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'achievements': achievements};
}
