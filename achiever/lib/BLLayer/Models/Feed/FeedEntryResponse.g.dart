// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FeedEntryResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedEntryResponse _$FeedEntryResponseFromJson(Map<String, dynamic> json) {
  return new FeedEntryResponse(
      json['authorProfileImagePath'] as String,
      json['authorNickname'] as String,
      json['entry'] == null
          ? null
          : new FeedEntry.fromJson(json['entry'] as Map<String, dynamic>),
      json['isLiked'] as bool);
}

abstract class _$FeedEntryResponseSerializerMixin {
  String get authorProfileImagePath;
  String get authorNickname;
  FeedEntry get entry;
  bool get isLiked;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'authorProfileImagePath': authorProfileImagePath,
        'authorNickname': authorNickname,
        'entry': entry,
        'isLiked': isLiked
      };
}
