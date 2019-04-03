import 'package:json_annotation/json_annotation.dart';

part 'AchievementCategory.g.dart';

@JsonSerializable()
class AchievementCategory extends Object with _$AchievementCategorySerializerMixin {
  final String id;
  final String title;
  final String subtitle;
  final int maskHeight;
  final String maskImagePath;

  AchievementCategory(
    this.id,
    this.title,
    this.subtitle,
    this.maskHeight,
    this.maskImagePath
  );

  factory AchievementCategory.fromJson(Map<String, dynamic> json) => _$AchievementCategoryFromJson(json);
}