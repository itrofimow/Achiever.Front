import '../Achievement/Achievement.dart';
import 'package:json_annotation/json_annotation.dart';
import 'FeedEntryComment.dart';
import 'package:achiever/BLLayer/Models/User/UserDto.dart';

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
  final List<UserDto> likedUsers;
  int likesCount;

  final List<FeedEntryComment> comments;
  int commentsCount;

  FeedEntry(this.id, this.authorId, this.achievementId,
   this.achievement, this.comment, this.when, this.images, 
   this.likes, this.likedUsers, this.likesCount,
   this.comments, this.commentsCount);

  factory FeedEntry.fromJson(Map<String, dynamic> json) => _$FeedEntryFromJson(json);

  static FeedEntry copy(FeedEntry entry) {
    return FeedEntry(
      entry.id, entry.authorId, entry.achievementId, entry.achievement,
      entry.comment, entry.when, entry.images, 
      entry.likes, entry.likedUsers, entry.likesCount,
      entry.comments, entry.commentsCount
    );
  }
}