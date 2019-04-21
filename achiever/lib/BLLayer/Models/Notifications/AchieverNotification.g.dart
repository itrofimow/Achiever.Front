// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AchieverNotification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AchieverNotification _$AchieverNotificationFromJson(Map<String, dynamic> json) {
  return new AchieverNotification(
      json['feedEntryId'] as String,
      json['author'] == null
          ? null
          : new User.fromJson(json['author'] as Map<String, dynamic>),
      json['text'] as String,
      json['when'] as String);
}

abstract class _$AchieverNotificationSerializerMixin {
  String get feedEntryId;
  User get author;
  String get text;
  String get when;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'feedEntryId': feedEntryId,
        'author': author,
        'text': text,
        'when': when
      };
}
