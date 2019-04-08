import '../Achievement/Achievement.dart';
import 'package:json_annotation/json_annotation.dart';
import 'FeedEntryComment.dart';

part 'FeedEntry.g.dart';

@JsonSerializable()
class FeedEntry extends Object with _$FeedEntrySerializerMixin {
  final String id;
  final String authorId;
  final String achievementId;
  final Achievement achievement;
  final String comment;
  final List<String> images;

  final String when;

  final List<String> likes;
  int likesCount;

  final List<FeedEntryComment> comments;
  int commentsCount;

  FeedEntry(this.id, this.authorId, this.achievementId,
   this.achievement, this.comment, this.when, this.images, this.likes, this.likesCount,
   this.comments, this.commentsCount);

  factory FeedEntry.fromJson(Map<String, dynamic> json) => _$FeedEntryFromJson(json);

  static FeedEntry copy(FeedEntry entry) {
    return FeedEntry(
      entry.id, entry.authorId, entry.achievementId, entry.achievement,
      entry.comment, entry.when, entry.images, entry.likes, entry.likesCount,
      entry.comments, entry.commentsCount
    );
  }
}