// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AcquiredAchievement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AcquiredAchievement _$AcquiredAchievementFromJson(Map<String, dynamic> json) {
  return new AcquiredAchievement(
      json['achievement'] == null
          ? null
          : new Achievement.fromJson(
              json['achievement'] as Map<String, dynamic>),
      json['ownerId'] as String,
      json['when'] as String);
}

abstract class _$AcquiredAchievementSerializerMixin {
  Achievement get achievement;
  String get ownerId;
  String get when;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'achievement': achievement,
        'ownerId': ownerId,
        'when': when
      };
}
