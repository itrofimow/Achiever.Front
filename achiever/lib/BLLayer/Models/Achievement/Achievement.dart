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

  AchievementPaintingType get paintingType {
    if (backgroundImage != null && frontImage != null && bigImage != null)
      return AchievementPaintingType.fullyCustom;

    if (frontImage != null && bigImage != null)
      return AchievementPaintingType.semiCustom;

    return AchievementPaintingType.lazy;
  }
}

enum AchievementPaintingType {
  /*
  https://trello.com/c/0rVqeGTF/
  */

  // 3 separate images - back, front, big
  fullyCustom,

  // 2 images - front, big
  semiCustom,

  // 1 image - big
  lazy
}