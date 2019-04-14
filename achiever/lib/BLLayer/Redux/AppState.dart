import 'package:meta/meta.dart';
import 'Login/LoginState.dart';
import 'User/UserState.dart';
import 'User/Draft/DraftState.dart';
import 'Achievements/AllAchievementsState.dart';
import 'Feed/FeedState.dart';
import 'Navigation/NavigationState.dart';
import 'PersonalFeed/PersonalFeedState.dart';

@immutable
class AppState {
  final LoginState loginState;
  final UserState userState;
  final DraftState draftState;
  final AllAchievementsState allAchievementsState;
  final FeedState feedState;
  final NavigationState navigationState;
  final PersonalFeedState personalFeedState;

  AppState({
    @required this.loginState,
    @required this.userState,
    @required this.draftState,
    @required this.allAchievementsState,
    @required this.feedState,
    @required this.navigationState,
    @required this.personalFeedState
  });

  factory AppState.initial() {
    return AppState(
      loginState: LoginState.initial(),
      userState: UserState.initial(),
      draftState: DraftState.initial(),
      allAchievementsState: AllAchievementsState.initial(),
      feedState: FeedState.initial(),
      navigationState: NavigationState.initial(),
      personalFeedState: PersonalFeedState.initial()
    );
  }

  AppState copyWith({
    LoginState loginState,
    UserState userState,
    DraftState draftState,
    AllAchievementsState allAchievementsState,
    FeedState feedState,
    NavigationState navigationState,
    PersonalFeedState personalFeedState
  }) {
    return AppState(
      loginState: loginState ?? this.loginState,
      userState: userState ?? this.userState,
      draftState: draftState ?? this.draftState,
      allAchievementsState: allAchievementsState ?? this.allAchievementsState,
      feedState: feedState ?? this.feedState,
      navigationState: navigationState ?? this.navigationState,
      personalFeedState: personalFeedState ?? this.personalFeedState
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
      allAchievementsState == other.allAchievementsState &&
      feedState == other.feedState &&
      navigationState == other.navigationState && 
      personalFeedState == other.personalFeedState;

  @override
  int get hashCode =>
    loginState.hashCode ^
    userState.hashCode ^
    draftState.hashCode ^
    allAchievementsState.hashCode ^
    feedState.hashCode ^
    navigationState.hashCode ^
    personalFeedState.hashCode;
}