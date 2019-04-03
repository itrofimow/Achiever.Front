// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AchievementCategoriesResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AchievementCategoriesResponse _$AchievementCategoriesResponseFromJson(
    Map<String, dynamic> json) {
  return new AchievementCategoriesResponse((json['categories'] as List)
      ?.map((e) => e == null
          ? null
          : new AchievementCategory.fromJson(e as Map<String, dynamic>))
      ?.toList());
}

abstract class _$AchievementCategoriesResponseSerializerMixin {
  List<AchievementCategory> get categories;
  Map<String, dynamic> toJson() => <String, dynamic>{'categories': categories};
}
