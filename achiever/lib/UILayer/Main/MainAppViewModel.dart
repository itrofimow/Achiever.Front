import 'package:redux/redux.dart';
import 'package:achiever/BLLayer/Redux/AppState.dart';
import 'package:achiever/BLLayer/Redux/Navigation/NavigationActions.dart';
import 'package:achiever/BLLayer/Redux/Keys.dart';

import 'package:flutter/material.dart';

import '../Pages/Feed/FeedPage.dart';
import '../Pages/Achievements/AchievementCategories/AchievementCategoriesPage.dart';
import '../Pages/Achievements/AllAchievementsPage.dart';
import '../Pages/Notifications/NotificationsPage.dart';
import '../Pages/Profile/MyProfile/MyProfilePage.dart';


final mainAppRoutes = {
  'feed': (BuildContext context) => FeedPage(),
  'search': (BuildContext context) => AchievementCategoriesPage(),
  'add': (BuildContext context) => AllAchievementsPage(),
  'notifications': (BuildContext context) => NotificationsPage(),
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
        if (index == state.currentNavigationIndex) {
          Keys.mainPageNavigators[index].currentState.popUntil((r) => r.isFirst);
          return;
        }

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
    if (currentRoute == 'selectedAchievement') return null;

    if (currentRoute == 'editProfile') return null;

    if (currentRoute == 'feed') {
      return AppBar(
        centerTitle: true,
        title: Image.asset('assets/achiever_logo.png', 
              color: Color.fromRGBO(51, 51, 51, 1), 
              colorBlendMode: BlendMode.srcIn,
              width: 28,
              height: 26,),
        backgroundColor: Colors.white,
        elevation: 0,
      );
    }

    if (currentRoute == 'profile') {
      return AppBar(
        centerTitle: false,
        title: Text('Мой профиль', style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 18,
          letterSpacing: 0.3,
          color: Color.fromRGBO(51, 51, 51, 1)
        )),
        backgroundColor: Colors.white,
        elevation: 1,
      );
    }

    if (currentRoute == 'followers') {
      return AppBar(
        centerTitle: true,
        title: Text('Подписчики', style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 18,
          letterSpacing: 0.3,
          color: Color.fromRGBO(51, 51, 51, 1)
        )),
        backgroundColor: Colors.white,
        elevation: 1,
        automaticallyImplyLeading: true,
      );
    }

    if (currentRoute == 'followings') {
      return AppBar(
        centerTitle: true,
        title: Text('Подписки', style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 18,
          letterSpacing: 0.3,
          color: Color.fromRGBO(51, 51, 51, 1)
        )),
        backgroundColor: Colors.white,
        elevation: 1,
        automaticallyImplyLeading: true,
      );
    }

    if (currentRoute == 'Liked') {
      return AppBar(
        centerTitle: true,
        title: Text('Понравилось', style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 18,
          letterSpacing: 0.3,
          color: Color.fromRGBO(51, 51, 51, 1)
        )),
        backgroundColor: Colors.white,
        elevation: 1,
        automaticallyImplyLeading: true,
      );
    }

    if (currentRoute == 'feedEntry') {
      return AppBar(
        centerTitle: true,
        title: Text('Запись', style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 18,
          letterSpacing: 0.3,
          color: Color.fromRGBO(51, 51, 51, 1)
        )),
        backgroundColor: Colors.white,
        elevation: 1,
        automaticallyImplyLeading: true,
      );
    }

    if (currentRoute == 'search' || currentRoute == 'selectedCategory') {
      return AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: true,
      );
    }

    if (currentRoute == 'createEntry') {
      return AppBar(
        centerTitle: true,
        title: Text('Новый пост', style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 18,
          letterSpacing: 0.3,
          color: Color.fromRGBO(51, 51, 51, 1)
        )),
        backgroundColor: Colors.white,
        elevation: 1,
        automaticallyImplyLeading: true,
      );
    }

    if (currentRoute == 'searchResult') {
      return AppBar(
        centerTitle: true,
        title: Text('Поиск', style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 18,
          letterSpacing: 0.3,
          color: Color.fromRGBO(51, 51, 51, 1)
        )),
        backgroundColor: Colors.white,
        elevation: 1,
        automaticallyImplyLeading: true,
      );
    }

    return AppBar(
      centerTitle: true,
      title: Text(currentRoute), 
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }
}