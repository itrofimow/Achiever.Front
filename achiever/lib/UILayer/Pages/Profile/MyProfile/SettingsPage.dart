import 'package:flutter/material.dart';
import 'package:achiever/AppContainer.dart';
import 'package:achiever/BLLayer/Redux/User/UserActions.dart';
import 'package:achiever/BLLayer/Redux/Keys.dart';

class SettingsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: Text('Настройки'), 
         backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: Container(
          height: 100, 
          color: Colors.black,
          child: Center(
            child: Text('ВЫЙТИ', style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 30
          )),),
        ),
        onTap: () {
          Keys.baseNavigatorKey.currentState.pushNamedAndRemoveUntil('/welcome', (_) => false);
          Future.delayed(Duration(milliseconds: 1000)).then((_) => AppContainer.store.dispatch(logout));
        },
      )
    );
  }
}