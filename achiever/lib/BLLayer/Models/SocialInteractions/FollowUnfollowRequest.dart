import 'package:json_annotation/json_annotation.dart';
import '../AchieverJsonable.dart';

part 'FollowUnfollowRequest.g.dart';

@JsonSerializable()
class FollowUnfollowRequest extends AchieverJsonable with _$FollowUnfollowRequestSerializerMixin {
  final String targetId;

  FollowUnfollowRequest(this.targetId);

  factory FollowUnfollowRequest.fromJson(Map<String, dynamic> json) => _$FollowUnfollowRequestFromJson(json);
}