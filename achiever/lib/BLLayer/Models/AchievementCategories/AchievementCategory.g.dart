// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AchievementCategory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AchievementCategory _$AchievementCategoryFromJson(Map<String, dynamic> json) {
  return new AchievementCategory(
      json['id'] as String,
      json['title'] as String,
      json['subtitle'] as String,
      json['maskHeight'] as int,
      json['maskImagePath'] as String,
      json['niceImagePath'] as String);
}

abstract class _$AchievementCategorySerializerMixin {
  String get id;
  String get title;
  String get subtitle;
  int get maskHeight;
  String get maskImagePath;
  String get niceImagePath;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'title': title,
        'subtitle': subtitle,
        'maskHeight': maskHeight,
        'maskImagePath': maskImagePath,
        'niceImagePath': niceImagePath
      };
}
