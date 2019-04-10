import 'package:json_annotation/json_annotation.dart';

part 'FeedEntriesCount.g.dart';

@JsonSerializable()
class FeedEntriesCount extends Object with _$FeedEntriesCountSerializerMixin {
  final int count;

  FeedEntriesCount(this.count);

  factory FeedEntriesCount.fromJson(Map<String, dynamic> json) => _$FeedEntriesCountFromJson(json);
}