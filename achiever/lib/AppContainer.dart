import 'BLLayer/ApiInterfaces/IAuthApi.dart';
import 'DALayer/BackendApi/AuthApi.dart';

import 'BLLayer/ApiInterfaces/IAchievementApi.dart';
import 'DALayer/BackendApi/AchievementApi.dart';

import 'BLLayer/ApiInterfaces/IFeedApi.dart';
import 'DALayer/BackendApi/FeedApi.dart';

import 'BLLayer/ApiInterfaces/IUserApi.dart';
import 'DALayer/BackendApi/UserApi.dart';

import 'BLLayer/ApiInterfaces/IAllUsersApi.dart';
import 'DALayer/BackendApi/AllUsersApi.dart';

import 'BLLayer/ApiInterfaces/ISocialInteractionsApi.dart';
import 'DALayer/BackendApi/SocialInteractionsApi.dart';

import 'BLLayer/ApiInterfaces/ISearchApi.dart';
import 'DALayer/BackendApi/SearchApi.dart';

import 'package:achiever/BLLayer/ApiInterfaces/IServerTimeApi.dart';
import 'package:achiever/DALayer/BackendApi/ServerTimeApi.dart';

import 'BLLayer/Services/SharedPrefsService.dart';

import 'package:redux/redux.dart';
import 'BLLayer/Redux/AppState.dart';

class AppContainer {
	static final IAuthApi authApi = new AuthApi();
  static final IAchievementApi achievementApi = new AchievementApi();
  static final IFeedApi feedApi = new FeedApi();
  static final IUserApi userApi = new UserApi();
  static final IAllUsersApi allUsersApi = new AllUsersApi();
  static final ISocialIntercationsApi socialIntercationsApi = new SocialInteractionsApi();
  static final ISearchApi searchApi = new SearchApi();
  static final IServerTimeApi serverTimeApi = new ServerTimeApi();

  static final SharedPrefsService sharedPrefsService = new SharedPrefsService();

  static Store<AppState> store;
}