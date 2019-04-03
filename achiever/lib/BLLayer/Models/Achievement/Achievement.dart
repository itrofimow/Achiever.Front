import 'package:json_annotation/json_annotation.dart';
import 'ImageInfo.dart';
import '../AchievementCategories/AchievementCategory.dart';

part 'Achievement.g.dart';

@JsonSerializable()
class Achievement extends Object with _$AchievementSerializerMixin {
	final String id;
	final String title;
	final String description;
	final String backgroundImagePath;
  final String frontImagePath;

  final bool hasDefaultBackground;
  final String defaultBackgroundColor;

  final ImageInfo backgroundImage;
  final ImageInfo frontImage;
  final ImageInfo bigImage;

  final AchievementCategory category;

	Achievement(this.id, this.title, this.description,
    this.backgroundImagePath, this.frontImagePath, this.bigImage,
    this.backgroundImage, this.frontImage, this.hasDefaultBackground, this.defaultBackgroundColor,
    this.category);

	factory Achievement.fromJson(Map<String, dynamic> json) => _$AchievementFromJson(json);
}