import 'package:json_annotation/json_annotation.dart';
import 'package:achiever/BLLayer/Models/User/User.dart';

part 'AchieverNotification.g.dart';

@JsonSerializable()
class AchieverNotification extends Object with _$AchieverNotificationSerializerMixin {
  final String feedEntryId;
  final User author;
  final String text;
  final String when;

  AchieverNotification(this.feedEntryId, this.author, this.text, this.when);

  factory AchieverNotification.fromJson(Map<String, dynamic> json) => _$AchieverNotificationFromJson(json);
}