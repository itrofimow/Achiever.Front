import 'package:flutter/material.dart';
import 'package:achiever/UILayer/Pages/Feed/FeedPage.dart';
import 'package:achiever/UILayer/Pages/Entrance/Login/LoginPage.dart';
import 'package:achiever/UILayer/Pages/Entrance/WelcomePage.dart';
import 'package:achiever/UILayer/Pages/Entrance/SignupPage.dart';
import 'package:achiever/UILayer/Pages/Profile/MyProfile/MyProfilePage.dart';
import 'package:achiever/UILayer/Pages/DebugRoutingPage.dart';
import 'package:achiever/UILayer/Pages/Achievements/AllAchievementsPage.dart';
import 'package:achiever/UILayer/Pages/Achievements/AchievementCreationPage.dart';
import 'package:achiever/UILayer/Pages/AllUsers/AllUsersPage.dart';
import 'package:achiever/UILayer/Pages/Notifications/NotificationsPage.dart';
import 'package:achiever/UILayer/Pages/Entrance/Splash/SplashScreenPage.dart';
import 'package:achiever/UILayer/Pages/Achievements/AchievementCategories/AchievementCategoriesPage.dart';
import 'package:achiever/UILayer/Pages/TestPage.dart';

final routes = {
	'/login': (BuildContext context) => new LoginPage(),
  '/feed': (BuildContext context) => new FeedPage(),
  '/welcome': (BuildContext context) => new WelcomePage(),
  '/signup': (BuildContext context) => new SignupPage(),
  '/myProfile' : (BuildContext context) => new MyProfilePage(),
  '/routes': (BuildContext context) => new DebugRoutingPage(),
  '/allAchievements': (BuildContext context) => new AllAchievementsPage(),
  '/createAchievement': (BuildContext context) => new AchievementCreationPage(),
  '/allUsers': (BuildContext context) => new AllUsersPage(),
  '/notifications': (BuildContext context) => new NotificationsPage(),
  '/splash': (BuildContext context) => new SplashScreenPage(),
  '/achievementCategories': (BuildContext context) => new AchievementCategoriesPage(),
  '/test': (BuildContext context) => new TestPage()
};