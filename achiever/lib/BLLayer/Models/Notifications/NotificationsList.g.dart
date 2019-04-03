// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NotificationsList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationsList _$NotificationsListFromJson(Map<String, dynamic> json) {
  return new NotificationsList((json['notifications'] as List)
      ?.map((e) => e == null
          ? null
          : new AchieverNotification.fromJson(e as Map<String, dynamic>))
      ?.toList());
}

abstract class _$NotificationsListSerializerMixin {
  List<AchieverNotification> get notifications;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'notifications': notifications};
}
