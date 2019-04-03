// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CreateEntryByAchievementRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateEntryByAchievementRequest _$CreateEntryByAchievementRequestFromJson(
    Map<String, dynamic> json) {
  return new CreateEntryByAchievementRequest(
      json['achievementId'] as String, json['comment'] as String);
}

abstract class _$CreateEntryByAchievementRequestSerializerMixin {
  String get achievementId;
  String get comment;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'achievementId': achievementId, 'comment': comment};
}
