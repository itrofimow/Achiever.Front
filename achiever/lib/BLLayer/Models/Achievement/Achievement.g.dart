// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Achievement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Achievement _$AchievementFromJson(Map<String, dynamic> json) {
  return new Achievement(
      json['id'] as String,
      json['title'] as String,
      json['description'] as String,
      json['backgroundImagePath'] as String,
      json['frontImagePath'] as String,
      json['bigImage'] == null
          ? null
          : new ImageInfo.fromJson(json['bigImage'] as Map<String, dynamic>),
      json['backgroundImage'] == null
          ? null
          : new ImageInfo.fromJson(
              json['backgroundImage'] as Map<String, dynamic>),
      json['frontImage'] == null
          ? null
          : new ImageInfo.fromJson(json['frontImage'] as Map<String, dynamic>),
      json['hasDefaultBackground'] as bool,
      json['defaultBackgroundColor'] as String,
      json['category'] == null
          ? null
          : new AchievementCategory.fromJson(
              json['category'] as Map<String, dynamic>));
}

abstract class _$AchievementSerializerMixin {
  String get id;
  String get title;
  String get description;
  String get backgroundImagePath;
  String get frontImagePath;
  bool get hasDefaultBackground;
  String get defaultBackgroundColor;
  ImageInfo get backgroundImage;
  ImageInfo get frontImage;
  ImageInfo get bigImage;
  AchievementCategory get category;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'title': title,
        'description': description,
        'backgroundImagePath': backgroundImagePath,
        'frontImagePath': frontImagePath,
        'hasDefaultBackground': hasDefaultBackground,
        'defaultBackgroundColor': defaultBackgroundColor,
        'backgroundImage': backgroundImage,
        'frontImage': frontImage,
        'bigImage': bigImage,
        'category': category
      };
}
