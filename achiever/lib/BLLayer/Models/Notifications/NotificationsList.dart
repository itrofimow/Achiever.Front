import 'package:json_annotation/json_annotation.dart';
import 'AchieverNotification.dart';

part 'NotificationsList.g.dart';

@JsonSerializable()
class NotificationsList extends Object with _$NotificationsListSerializerMixin {
  final List<AchieverNotification> notifications;

  NotificationsList(this.notifications);

  factory NotificationsList.fromJson(Map<String, dynamic> json) => _$NotificationsListFromJson(json);
}