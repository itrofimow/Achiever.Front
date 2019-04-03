// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FeedEntry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedEntry _$FeedEntryFromJson(Map<String, dynamic> json) {
  return new FeedEntry(
      json['id'] as String,
      json['authorId'] as String,
      json['achievementId'] as String,
      json['achievement'] == null
          ? null
          : new Achievement.fromJson(
              json['achievement'] as Map<String, dynamic>),
      json['comment'] as String,
      (json['images'] as List)?.map((e) => e as String)?.toList(),
      (json['likes'] as List)?.map((e) => e as String)?.toList(),
      json['likesCount'] as int,
      (json['comments'] as List)
          ?.map((e) => e == null
              ? null
              : new FeedEntryComment.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['commentsCount'] as int);
}

abstract class _$FeedEntrySerializerMixin {
  String get id;
  String get authorId;
  String get achievementId;
  Achievement get achievement;
  String get comment;
  List<String> get images;
  List<String> get likes;
  int get likesCount;
  List<FeedEntryComment> get comments;
  int get commentsCount;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'authorId': authorId,
        'achievementId': achievementId,
        'achievement': achievement,
        'comment': comment,
        'images': images,
        'likes': likes,
        'likesCount': likesCount,
        'comments': comments,
        'commentsCount': commentsCount
      };
}
