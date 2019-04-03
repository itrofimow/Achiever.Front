import 'package:meta/meta.dart';
import 'Login/LoginState.dart';
import 'User/UserState.dart';
import 'User/Draft/DraftState.dart';
import 'Achievements/AllAchievementsState.dart';
import 'Feed/FeedState.dart';

@immutable
class AppState {
  final LoginState loginState;
  final UserState userState;
  final DraftState draftState;
  final AllAchievementsState allAchievementsState;
  final FeedState feedState;

  AppState({
    @required this.loginState,
    @required this.userState,
    @required this.draftState,
    @required this.allAchievementsState,
    @required this.feedState
  });

  factory AppState.initial() {
    return AppState(
      loginState: LoginState.initial(),
      userState: UserState.initial(),
      draftState: DraftState.initial(),
      allAchievementsState: AllAchievementsState.initial(),
      feedState: FeedState.initial()
    );
  }

  AppState copyWith({
    LoginState loginState,
    UserState userState,
    DraftState draftState,
    AllAchievementsState allAchievementsState,
    FeedState feedState
  }) {
    return AppState(
      loginState: loginState ?? this.loginState,
      userState: userState ?? this.userState,
      draftState: draftState ?? this.draftState,
      allAchievementsState: allAchievementsState ?? this.allAchievementsState,
      feedState: feedState ?? this.feedState
    );
  }

  @override
  bool operator == (Object other) =>
    identical(this, other) ||
    other is AppState &&
      runtimeType == other.runtimeType &&
      loginState == other.loginState &&
      userState == other.userState &&
      draftState == other.draftState &&
      allAchievementsState ==other.allAchievementsState;

  @override
  int get hashCode =>
    loginState.hashCode ^
    userState.hashCode ^
    draftState.hashCode ^
    allAchievementsState.hashCode;
}