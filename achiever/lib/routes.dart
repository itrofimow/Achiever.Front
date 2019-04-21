import 'package:flutter/material.dart';
import 'package:achiever/UILayer/Pages/Feed/FeedPage.dart';
import 'package:achiever/UILayer/Pages/Entrance/Login/LoginPage.dart';
import 'package:achiever/UILayer/Pages/Entrance/WelcomePage.dart';
import 'package:achiever/UILayer/Pages/Entrance/SignupPage.dart';
import 'package:achiever/UILayer/Pages/Profile/MyProfile/MyProfilePage.dart';
import 'package:achiever/UILayer/Pages/DebugRoutingPage.dart';
import 'package:achiever/UILayer/Pages/Achievements/AllAchievementsPage.dart';
import 'package:achiever/UILayer/Pages/Achievements/AchievementCreationPage.dart';
import 'package:achiever/UILayer/Pages/Notifications/NotificationsPage.dart';
import 'package:achiever/UILayer/Pages/Achievements/AchievementCategories/AchievementCategoriesPage.dart';
import 'package:achiever/UILayer/Pages/TestPage.dart';
import 'package:achiever/UILayer/NavigationTest/NavigationTestPage.dart';
import 'package:achiever/UILayer/Main/MainAppPage.dart';

final routes = {
	'/login': (BuildContext context) => new LoginPage(),
  '/feed': (BuildContext context) => new FeedPage(),
  '/welcome': (BuildContext context) => new WelcomePage(),
  '/signup': (BuildContext context) => new SignupPage(),
  '/myProfile' : (BuildContext context) => new MyProfilePage(),
  '/routes': (BuildContext context) => new DebugRoutingPage(),
  '/allAchievements': (BuildContext context) => new AllAchievementsPage(),
  '/createAchievement': (BuildContext context) => new AchievementCreationPage(),
  '/notifications': (BuildContext context) => new NotificationsPage(),
  '/achievementCategories': (BuildContext context) => new AchievementCategoriesPage(),
  '/test': (BuildContext context) => new NavigationTestPage(),
  '/main': (BuildContext context) => new MainAppPage()
};