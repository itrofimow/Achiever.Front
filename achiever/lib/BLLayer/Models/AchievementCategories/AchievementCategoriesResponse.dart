import 'package:json_annotation/json_annotation.dart';
import 'AchievementCategory.dart';

part 'AchievementCategoriesResponse.g.dart';

@JsonSerializable()
class AchievementCategoriesResponse extends Object with _$AchievementCategoriesResponseSerializerMixin {
  final List<AchievementCategory> categories;

  AchievementCategoriesResponse(this.categories);

  factory AchievementCategoriesResponse.fromJson(Map<String, dynamic> json) =>
    _$AchievementCategoriesResponseFromJson(json);
}