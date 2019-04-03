// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return new User(
      id: json['id'] as String,
      nickname: json['nickname'] as String,
      profileImagePath: json['profileImagePath'] as String,
      stats: json['stats'] == null
          ? null
          : new UserStats.fromJson(json['stats'] as Map<String, dynamic>),
      about: json['about'] as String);
}

abstract class _$UserSerializerMixin {
  String get id;
  String get nickname;
  String get profileImagePath;
  UserStats get stats;
  String get about;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'nickname': nickname,
        'profileImagePath': profileImagePath,
        'stats': stats,
        'about': about
      };
}
