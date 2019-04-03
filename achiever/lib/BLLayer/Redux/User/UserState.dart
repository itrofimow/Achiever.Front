import 'package:meta/meta.dart';
import 'package:achiever/BLLayer/Models/User/User.dart';
import 'package:achiever/BLLayer/Models/User/UserDto.dart';
import 'package:achiever/BLLayer/Models/Notifications/AchieverNotification.dart';

@immutable
class UserState {
  final String token;
  final String firebaseToken;
  final User user;
  final List<UserDto> allUsers;
  final List<AchieverNotification> notifications;

  UserState({
    this.token,
    this.firebaseToken,
    this.user,
    this.allUsers,
    this.notifications
  });

  UserState copyWith({
    String token,
    String firebaseToken,
    User user,
    List<UserDto> allUsers,
    List<AchieverNotification> notifications
  }) {
    return UserState(
      token: token ?? this.token,
      firebaseToken: firebaseToken ?? this.firebaseToken,
      user: user ?? this.user,
      allUsers: allUsers ?? this.allUsers,
      notifications: notifications ?? this.notifications
    );
  }

  factory UserState.initial() {
    return UserState(
      token: null,
      firebaseToken: null,
      user: null,
      allUsers: List<UserDto>(),
      notifications: List<AchieverNotification>()
    );
  }
}