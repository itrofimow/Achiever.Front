import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';

import 'package:achiever/AppContainer.dart';
import 'package:achiever/BLLayer/Models/Login/Login.dart';

import '../AppState.dart';
import '../Models/LoadingStatus.dart';

import '../User/UserActions.dart';
import '../User/Draft/DraftActions.dart';

import 'package:achiever/BLLayer/Redux/Keys.dart';
import '../Feed/FeedActions.dart';

import 'package:flutter/material.dart';
import 'package:achiever/UILayer/Main/MainAppPage.dart';

ThunkAction<AppState> validateLoginAction = (Store<AppState> store) async {
  final loginModel = Login(
    store.state.loginState.nickname,
    store.state.loginState.password,
    store.state.userState.firebaseToken);
  final userWithToken = await AppContainer.authApi.authenticate(loginModel);

  store.dispatch(UpdateTokenAction(userWithToken.token));
  await AppContainer.sharedPrefsService.setToken(userWithToken.token);

  store.dispatch(UpdateUserAction(userWithToken.user));
  store.dispatch(UpdateDraftAction(
    userWithToken.user.nickname,
    userWithToken.user.about,
    userWithToken.user.profileImagePath
  ));

  store.dispatch(UpdateLoadingStatusAction(LoadingStatus.success));
  store.dispatch(ResetFeedAction());

  Keys.baseNavigatorKey.currentState.pushAndRemoveUntil(
    MaterialPageRoute(
      builder: (_) => MainAppPage()
    ), (_) => false);
};

class UpdateNicknameAction {
  final String nickname;

  UpdateNicknameAction(this.nickname);
}

class UpdatePasswordAction {
  final String password;

  UpdatePasswordAction(this.password);
}

class UpdateLoadingStatusAction {
  final LoadingStatus status;

  UpdateLoadingStatusAction(this.status);
}

class ClearErrorsAction {}