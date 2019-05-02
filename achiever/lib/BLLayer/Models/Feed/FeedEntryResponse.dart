import 'package:json_annotation/json_annotation.dart';
import './FeedEntry.dart';
import 'package:achiever/BLLayer/Models/User/UserDto.dart';

part 'FeedEntryResponse.g.dart';

@JsonSerializable()
class FeedEntryResponse extends Object with _$FeedEntryResponseSerializerMixin {
  final String authorProfileImagePath;
  final String authorNickname;
  final FeedEntry entry;
  bool isLiked;

  FeedEntryResponse(
    this.authorProfileImagePath, this.authorNickname, 
    this.entry, this.isLiked);

  factory FeedEntryResponse.fromJson(Map<String, dynamic> json) => _$FeedEntryResponseFromJson(json);
}