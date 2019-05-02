// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FeedPageResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedPageResponse _$FeedPageResponseFromJson(Map<String, dynamic> json) {
  return new FeedPageResponse(
      (json['entries'] as List)
          ?.map((e) => e == null
              ? null
              : new FeedEntryResponse.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['startedAt'] as String);
}

abstract class _$FeedPageResponseSerializerMixin {
  List<FeedEntryResponse> get entries;
  String get startedAt;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'entries': entries, 'startedAt': startedAt};
}
