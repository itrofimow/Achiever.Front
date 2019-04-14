import '../Models/User/User.dart';
import '../Models/Notifications/AchieverNotification.dart';
import 'dart:io';
import 'package:achiever/BLLayer/Models/User/UserDto.dart';

abstract class IUserApi {
  Future<User> getCurrentUser();

  Future<User> getById(String id);

  Future<User> update(User model, File image);

  Future<List<AchieverNotification>> getNotifications();

  Future<int> countFeedEntries(String userId);

  Future<List<UserDto>> getFollowers(String userId);

  Future<List<UserDto>> getFollowings(String userId);
}