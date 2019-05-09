import 'package:redux/redux.dart';

import 'UserState.dart';
import 'UserActions.dart';

import 'package:achiever/BLLayer/Models/User/UserDto.dart';
import 'package:achiever/BLLayer/Models/User/UserStats.dart';

final userReducer = combineReducers<UserState>([
  TypedReducer<UserState, UpdateTokenAction>(_updateToken),
  TypedReducer<UserState, UpdateUserAction>(_updateUser),

  TypedReducer<UserState, SetAllUsers>(_setAllUsers),

  TypedReducer<UserState, UpdateFirebaseTokenAction>(_updateFirebaseToken),
  TypedReducer<UserState, UpdateNotificationsListAction>(_updateNotificationsList),

  TypedReducer<UserState, SetFollowersAction>(_setFollowers),
  TypedReducer<UserState, SetFollowingsAction>(_setFollowings),

  TypedReducer<UserState, FollowUserAction>(_followUser),
  TypedReducer<UserState, UnfollowUserAction>(_unfollowUser),

  TypedReducer<UserState, AddKnownUserAction>(_addKnownUser),
  TypedReducer<UserState, AddManyKnownUsersAction>(_addManyKnownUsers),
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

UserState _setFollowers(UserState state, SetFollowersAction action) {
  final knownUsers = Map<String, UserDto>.from(state.knownUsers);
  action.followers.forEach((x) => knownUsers[x.user.id] = x);

  return state.copyWith(knownUsers: knownUsers, followers: action.followers.map((x) => x.user.id).toSet());
}

UserState _setFollowings(UserState state, SetFollowingsAction action) {
  final knownUsers = Map<String, UserDto>.from(state.knownUsers);
  action.followings.forEach((x) => knownUsers[x.user.id] = x);

  return state.copyWith(knownUsers: knownUsers, followings: action.followings.map((x) => x.user.id).toSet());
}

UserState _followUser(UserState state, FollowUserAction action) {
  final followings = Set<String>.from(state.followings);
  followings.add(action.userId);

  final knownUsers = Map<String, UserDto>.from(state.knownUsers);
  knownUsers[action.userId] = UserDto(state.knownUsers[action.userId].user, true);
  

  final stats = state.user.stats;
  final newStats = UserStats(stats.following + 1, stats.followers, stats.achievementsCount);

  state.user.stats = newStats;

  return state.copyWith(followings: followings, knownUsers: knownUsers);
}

UserState _unfollowUser(UserState state, UnfollowUserAction action) {
  final followings = Set<String>.from(state.followings);
  followings.remove(action.userId);

  final knownUsers = Map<String, UserDto>.from(state.knownUsers);
  knownUsers[action.userId] = UserDto(state.knownUsers[action.userId].user, false);

  final stats = state.user.stats;
  final newStats = UserStats(stats.following - 1, stats.followers, stats.achievementsCount);

  state.user.stats = newStats;

  return state.copyWith(followings: followings, knownUsers: knownUsers);
}

UserState _addKnownUser(UserState state, AddKnownUserAction action) {
  final knownUsers = Map<String, UserDto>.from(state.knownUsers);
  knownUsers[action.user.user.id] = action.user;

  return state.copyWith(knownUsers: knownUsers);
}

UserState _addManyKnownUsers(UserState state, AddManyKnownUsersAction action) {
  final knownUsers = Map<String, UserDto>.from(state.knownUsers);
  action.users.forEach((f) => knownUsers[f.user.id] = f);

  return state.copyWith(knownUsers: knownUsers);
}



