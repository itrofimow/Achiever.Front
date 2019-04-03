import 'package:json_annotation/json_annotation.dart';
import './Achievement.dart';

part 'AllAchievementsResponse.g.dart';

@JsonSerializable()
class AllAchievementsResponse extends Object with _$AllAchievementsResponseSerializerMixin {
  final List<Achievement> achievements;

  AllAchievementsResponse(this.achievements);

  factory AllAchievementsResponse.fromJson(Map<String, dynamic> json) => _$AllAchievementsResponseFromJson(json);
}