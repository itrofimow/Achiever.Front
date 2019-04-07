import 'package:redux/redux.dart';
import 'package:achiever/BLLayer/Redux/AppState.dart';
import 'package:achiever/BLLayer/Redux/Navigation/NavigationActions.dart';
import 'package:achiever/BLLayer/Redux/Keys.dart';

import 'package:flutter/material.dart';

import '../Pages/Feed/FeedPage.dart';
import '../Pages/Achievements/AchievementCategories/AchievementCategoriesPage.dart';
import '../Pages/Achievements/AllAchievementsPage.dart';
import '../Pages/Notifications/MyNotificationsPage.dart';
import '../Pages/Profile/MyProfile/MyProfilePage.dart';


final mainAppRoutes = {
  'feed': (BuildContext context) => FeedPage(),
  'search': (BuildContext context) => AchievementCategoriesPage(),
  'add': (BuildContext context) => AllAchievementsPage(),
  'notifications': (BuildContext context) => MyNotificationsPage(),
  'profile': (BuildContext context) => MyProfilePage()
};

class MainAppViewModel {
  final int currentNavigationIndex;
  final String userProfileImage;

  final Function(int) processTap;
  final Function processBackNavigation;

  final Widget Function() buildAppBar;

  MainAppViewModel({
    this.currentNavigationIndex,
    this.userProfileImage,

    this.processTap,
    this.processBackNavigation,

    this.buildAppBar
  });

  static MainAppViewModel fromStore(Store<AppState> store) {
    final state = store.state.navigationState;

    return MainAppViewModel(
      currentNavigationIndex: state.currentNavigationIndex,
      userProfileImage: store.state.userState.user.profileImagePath,

      processTap: (index) {
        if (index == state.currentNavigationIndex) return; 

        if (index == NavigationIndexes.feedNavigationIndex) 
          store.dispatch(GoToFeedAction());

        if (index == NavigationIndexes.searchNavigationIndex) 
          store.dispatch(GoToSearchAction());

        if (index == NavigationIndexes.addNavigationIndex) 
          store.dispatch(GoToAddAction());

        if (index == NavigationIndexes.notificationsNavigationIndex)
          store.dispatch(GoToNotificationsAction());

        if (index == NavigationIndexes.profileNavigationIndex)
          store.dispatch(GoToProfileAction());
      },

      processBackNavigation: () async {
        final currentCanPop = await Keys.mainPageNavigators[state.currentNavigationIndex].currentState.maybePop();
        if (currentCanPop) return false;

        if (state.navigatorsStack.length == 1) return true;

        store.dispatch(GoBackAction());
        return false;
      },

      buildAppBar: () => _buildAppBar(state.currentRoute[state.currentNavigationIndex])
    );
  }

  static Widget _buildAppBar(String currentRoute) {
    if (currentRoute == 'editProfile') return null;
    
    return AppBar(title: Text(currentRoute), backgroundColor: Colors.white,
    elevation: 0,);
  }
}