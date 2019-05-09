import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';

import 'package:achiever/BLLayer/Models/User/User.dart';
import 'package:achiever/BLLayer/Models/User/UserDto.dart';
import 'package:achiever/BLLayer/Models/Notifications/AchieverNotification.dart';

import '../AppState.dart';
import 'package:achiever/DALayer/ApiClient.dart';
import 'package:achiever/AppContainer.dart';

import 'Draft/DraftActions.dart';

import 'package:achiever/BLLayer/Redux/Keys.dart';
import 'dart:io';
import 'dart:async';

class UpdateFirebaseTokenAction {
  final String firebaseToken;

  UpdateFirebaseTokenAction(this.firebaseToken);
}

class UpdateTokenAction {
  final String token;

  UpdateTokenAction(this.token);
}

class UpdateUserAction {
  final User user;

  UpdateUserAction(this.user);
}

class SetAllUsers {
  final List<UserDto> allUsers;

  SetAllUsers(this.allUsers);
}

class UpdateNotificationsListAction {
  final List<AchieverNotification> notifications;

  UpdateNotificationsListAction(this.notifications);
}

class LogoutAction {}

class SetFollowersAction {
  final List<UserDto> followers;

  SetFollowersAction(this.followers);
}

class SetFollowingsAction {
  final List<UserDto> followings;

  SetFollowingsAction(this.followings);
}

class FollowUserAction {
  final String userId;

  FollowUserAction(this.userId);
}

class UnfollowUserAction {
  final String userId;

  UnfollowUserAction(this.userId);
}

class AddKnownUserAction {
  final UserDto user;

  AddKnownUserAction(this.user);
}

class AddManyKnownUsersAction {
  final List<UserDto> users;

  AddManyKnownUsersAction(this.users);
}

ThunkAction<AppState> logout = (Store<AppState> store) async {
  await AppContainer.sharedPrefsService.setToken('');

  store.dispatch(LogoutAction());
};

ThunkAction<AppState> followAndReload(String userId, Completer<bool> completer) {
  return (Store<AppState> store) async {
    store.dispatch(FollowUserAction(userId));
    
    try {
      await AppContainer.socialIntercationsApi.follow(userId);
      completer.complete(true);
    }
    catch (e) {
      await Future.delayed(Duration(seconds: 5));
      store.dispatch(UnfollowUserAction(userId));

      completer.complete(false);
    }
  };
}

ThunkAction<AppState> unfollowAndReload(String userId, Completer<bool> completer) {
  return (Store<AppState> store) async {
    store.dispatch(UnfollowUserAction(userId));

    try {
      await AppContainer.socialIntercationsApi.unfollow(userId);
      completer.complete(true);
    }
    catch (e) {
      await Future.delayed(Duration(seconds: 5));
      store.dispatch(FollowUserAction(userId));

      completer.complete(false);
    }
  };
}

ThunkAction<AppState> fetchFollowers = (Store<AppState> store) async {
  final followers = await AppContainer.userApi.getFollowers(store.state.userState.user.id);

  store.dispatch(SetFollowersAction(followers));
};

ThunkAction<AppState> fetchFollowings = (Store<AppState> store) async {
  final followings = await AppContainer.userApi.getFollowings(store.state.userState.user.id);

  store.dispatch(SetFollowingsAction(followings));
};

ThunkAction<AppState> fetchAllUsers = (Store<AppState> store) async {
  final allUsers = await AppContainer.allUsersApi.getAllUsers();

  store.dispatch(SetAllUsers(allUsers));
};

ThunkAction<AppState> fetchAllNotifications = (Store<AppState> store) async {
  final notifications = await AppContainer.userApi.getNotifications();

  store.dispatch(UpdateNotificationsListAction(notifications));
};

ThunkAction<AppState> updateUser = (Store<AppState> store) async {
  final draftState = store.state.draftState;
  final User update = new User(
    nickname: draftState.newNickname,
    about: draftState.newAbout,
    profileImagePath: draftState.newProfileImagePath);
  final user = await AppContainer.userApi.update(update, null);

  store.dispatch(UpdateUserAction(user));
  store.dispatch(UpdateDraftAction(
    user.nickname,
    user.about,
    user.profileImagePath
  ));
};

ThunkAction<AppState> updateUserV2(File image, String name, String nickname, String about, 
  Completer completer) {
  return (Store<AppState> store) async {
    final update = User(
      nickname: nickname,
      about: about,
      displayName: name
    );

    try {
      final user = await AppContainer.userApi.update(update, image);
      store.dispatch(UpdateUserAction(user));
    }
    finally {
      completer.complete();
    }
  };
}