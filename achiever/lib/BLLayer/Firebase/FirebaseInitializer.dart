import 'package:firebase_messaging/firebase_messaging.dart';
import '../Redux/AppState.dart';
import 'package:redux/redux.dart';
import '../Redux/User/UserActions.dart';

class FirebaseInitializer {
  
  static final _firebaseMessaging = FirebaseMessaging();

  static Init(Store<AppState> store) async {
    try {
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

    final token = await _firebaseMessaging.getToken();

    if (token == null) return;
    store.dispatch(UpdateFirebaseTokenAction(token));
    }
    catch (e) {
      print(e.toString());
    }
  }
}