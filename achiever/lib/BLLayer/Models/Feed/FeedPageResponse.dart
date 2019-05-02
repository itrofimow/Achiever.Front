import 'package:json_annotation/json_annotation.dart';
import 'FeedEntryResponse.dart';

part 'FeedPageResponse.g.dart';

@JsonSerializable()
class FeedPageResponse extends Object with _$FeedPageResponseSerializerMixin {
  final List<FeedEntryResponse> entries;
  final String startedAt;

  FeedPageResponse(this.entries, this.startedAt);

  factory FeedPageResponse.fromJson(Map<String, dynamic> json) => _$FeedPageResponseFromJson(json);
}