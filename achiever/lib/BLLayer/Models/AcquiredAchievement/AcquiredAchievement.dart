import 'package:json_annotation/json_annotation.dart';
import '../Achievement/Achievement.dart';

part 'AcquiredAchievement.g.dart';

@JsonSerializable()
class AcquiredAchievement extends Object with _$AcquiredAchievementSerializerMixin {
  final Achievement achievement;
	final String ownerId;
	final String when;

	AcquiredAchievement(this.achievement, this.ownerId, this.when);

	factory AcquiredAchievement.fromJson(Map<String, dynamic> json) => _$AcquiredAchievementFromJson(json);
}