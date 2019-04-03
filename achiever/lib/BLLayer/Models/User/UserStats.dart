import 'package:json_annotation/json_annotation.dart';

part 'UserStats.g.dart';

@JsonSerializable()
class UserStats extends Object with _$UserStatsSerializerMixin {
  final int following;
  final int followers;
  final int achievementsCount;
  UserStats(this.following, this.followers, this.achievementsCount);

  factory UserStats.fromJson(Map<String, dynamic> json) => _$UserStatsFromJson(json);
}