// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FeedEntryComment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedEntryComment _$FeedEntryCommentFromJson(Map<String, dynamic> json) {
  return new FeedEntryComment(
      json['authorId'] as String,
      json['text'] as String,
      json['authorNickname'] as String,
      json['authorProfileImage'] as String,
      when: json['when'] as String);
}

abstract class _$FeedEntryCommentSerializerMixin {
  String get authorId;
  String get text;
  String get authorNickname;
  String get authorProfileImage;
  String get when;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'authorId': authorId,
        'text': text,
        'authorNickname': authorNickname,
        'authorProfileImage': authorProfileImage,
        'when': when
      };
}
