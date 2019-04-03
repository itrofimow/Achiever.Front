import 'package:redux/redux.dart';

import 'UserState.dart';
import 'UserActions.dart';

final userReducer = combineReducers<UserState>([
  TypedReducer<UserState, UpdateTokenAction>(_updateToken),
  TypedReducer<UserState, UpdateUserAction>(_updateUser),
  TypedReducer<UserState, SetAllUsers>(_setAllUsers),
  TypedReducer<UserState, UpdateFirebaseTokenAction>(_updateFirebaseToken),
  TypedReducer<UserState, UpdateNotificationsListAction>(_updateNotificationsList),
]);

UserState _updateToken(UserState state, UpdateTokenAction action) =>
  state.copyWith(token: action.token);

UserState _updateUser(UserState state, UpdateUserAction action) =>
  state.copyWith(user: action.user);

UserState _setAllUsers(UserState state, SetAllUsers action) =>
  state.copyWith(allUsers: action.allUsers);

UserState _updateFirebaseToken(UserState state, UpdateFirebaseTokenAction action) =>
  state.copyWith(firebaseToken: action.firebaseToken);

UserState _updateNotificationsList(UserState state, UpdateNotificationsListAction action) =>
  state.copyWith(notifications: action.notifications);