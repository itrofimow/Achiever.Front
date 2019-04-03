import 'package:json_annotation/json_annotation.dart';
import '../AchieverJsonable.dart';

part 'CreateEntryByAchievementRequest.g.dart';

@JsonSerializable()
class CreateEntryByAchievementRequest extends AchieverJsonable with _$CreateEntryByAchievementRequestSerializerMixin {
  final String achievementId;
  final String comment;
  CreateEntryByAchievementRequest(
    this.achievementId, this.comment
  );

  factory CreateEntryByAchievementRequest.fromJson(
    Map<String, dynamic> json
  ) => _$CreateEntryByAchievementRequestFromJson(json);
}