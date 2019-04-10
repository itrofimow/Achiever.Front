import 'package:flutter/material.dart';
import 'package:achiever/routes.dart';
import 'package:achiever/UILayer/Pages/DebugRoutingPage.dart';
import 'package:flutter/services.dart';

import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'BLLayer/Redux/AppState.dart';
import 'BLLayer/Redux/Store.dart';
import 'BLLayer/Redux/Keys.dart';

import 'BLLayer/Firebase/FirebaseInitializer.dart';
import 'dart:io' show Platform;

import 'AppContainer.dart';

import 'package:achiever/UILayer/Pages/TestPage.dart';
import 'package:achiever/UILayer/Pages/Entrance/WelcomePage.dart';
import 'package:achiever/UILayer/Pages/Feed/FeedPage.dart';
import 'package:achiever/BLLayer/Redux/User/UserActions.dart';
import 'DALayer/ApiClient.dart';
import 'package:achiever/UILayer/Main/MainAppPage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'UILayer/UIKit/ScrollWithoutGlow.dart';

Future<bool> _shouldGoToFeed(Store<AppState> store) async {
  final token = await AppContainer.sharedPrefsService.getToken();
  new ApiClient().setToken(token);

  try {
    final user = await AppContainer.userApi.getCurrentUser().timeout(Duration(seconds: 3));
    store.dispatch(UpdateUserAction(user));
    store.dispatch(UpdateTokenAction(token));

    return true;
  } catch (e) {
    return false;
  }
}

void main() async {
  var store = createStore();
  AppContainer.store = store;

	await SystemChrome.setPreferredOrientations(
		[DeviceOrientation.portraitUp]);

  //await FirebaseInitializer.Init(store);

  final goToFeed = await _shouldGoToFeed(store);

  runApp(new MyApp(store, goToFeed));
}

class MyApp extends StatefulWidget {
  final Store<AppState> store;
  final bool goToFeed;

  MyApp(this.store, this.goToFeed);

  @override
  _AppState createState() => _AppState();
} 

class _AppState extends State<MyApp> {
  final _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();

     _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });

    _firebaseMessaging.getToken().then((token){
      if (token != null)
        widget.store.dispatch(UpdateFirebaseTokenAction(token));
    });
  }
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
	  return StoreProvider<AppState>(
      store: widget.store,
      child: MaterialApp(
        title: 'Achiever',
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
          // counter didn't reset back to zero; the application is not restarted.
          fontFamily: Platform.isAndroid ? 'Lato' : 'SF',
          primarySwatch: Colors.grey,
          scaffoldBackgroundColor: Colors.white
        ),
        //home: new MyHomePage(title: 'Flutter Demo Home Page'),
        navigatorKey: Keys.baseNavigatorKey,
        home: widget.goToFeed ? MainAppPage() : new WelcomePage(),//DebugRoutingPage(),
        routes: routes,
      )
    );
  }
}

