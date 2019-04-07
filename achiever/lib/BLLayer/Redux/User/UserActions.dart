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

ThunkAction<AppState> logout = (Store<AppState> store) async {
  await AppContainer.sharedPrefsService.setToken('');

  store.dispatch(LogoutAction());
};

ThunkAction<AppState> followAndReload(String id) {
  return (Store<AppState> store) async {
    await AppContainer.socialIntercationsApi.follow(id);

    store.dispatch(fetchAllUsers);
  };
}

ThunkAction<AppState> unfollowAndReload(String id) {
  return (Store<AppState> store) async {
    await AppContainer.socialIntercationsApi.unfollow(id);

    store.dispatch(fetchAllUsers);
  };
}

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
      about: about
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