import 'AppState.dart';
import 'Login/LoginReducer.dart';
import 'User/UserReducer.dart';
import 'User/Draft/DraftReducer.dart';
import 'Achievements/AllAchievementsReducer.dart';
import 'Feed/FeedReducer.dart';
import 'User/UserActions.dart';

AppState appReducer(AppState state, dynamic action) {
  if (action is LogoutAction) return AppState.initial();

  return new AppState(
    loginState: loginReducer(state.loginState, action),
    userState: userReducer(state.userState, action),
    draftState: draftReducer(state.draftState, action),
    allAchievementsState: allAchievementsReducer(state.allAchievementsState, action),
    feedState: feedReducer(state.feedState, action)
  );
}