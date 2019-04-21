import 'package:json_annotation/json_annotation.dart';
import '../AchieverJsonable.dart';

part 'FeedEntryComment.g.dart';

@JsonSerializable()
class FeedEntryComment extends AchieverJsonable with _$FeedEntryCommentSerializerMixin {
  final String authorId;
  final String text;
  final String authorNickname;
  final String authorProfileImage;
  final String when;

  FeedEntryComment(this.authorId, this.text,
    this.authorNickname, this.authorProfileImage, {this.when});

  factory FeedEntryComment.fromJson(Map<String, dynamic> json) => _$FeedEntryCommentFromJson(json);
}