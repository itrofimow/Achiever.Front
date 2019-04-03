// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FollowUnfollowRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FollowUnfollowRequest _$FollowUnfollowRequestFromJson(
    Map<String, dynamic> json) {
  return new FollowUnfollowRequest(json['targetId'] as String);
}

abstract class _$FollowUnfollowRequestSerializerMixin {
  String get targetId;
  Map<String, dynamic> toJson() => <String, dynamic>{'targetId': targetId};
}
