import 'package:flutter/material.dart';
import '../UIKit/AchieverNavigationBar.dart';

//import 'FirstPage1.dart';

import 'Routes.dart';

class NavigatorKeys {
  static final navigators = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>()
  ];
}

class NavigationTestPage extends StatefulWidget {

  @override
  NavigationTestPageState createState() => NavigationTestPageState();
}

class NavigationTestPageState extends State<NavigationTestPage> {
  int _currentIndex = 0;


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => 
        !await NavigatorKeys.navigators[_currentIndex].currentState.maybePop(),
      child: Scaffold(
        body: _buildStackWithOffstages(context),
        bottomNavigationBar: BottomNavigationBar(/*AchieverNavigationBar(
          currentIndex: _currentIndex,
          profileImagePath: 'default.png',*/
          items: [
            BottomNavigationBarItem(
              icon: Container(),//Icon(Icons.home),
              title: Text('FIRST', style: TextStyle(
                color: _currentIndex == 0 ? Colors.black : Color.fromRGBO(51, 51, 51, 1),
                fontWeight: _currentIndex == 0 ? FontWeight.w800 : FontWeight.w400
              ),)
            ),
            BottomNavigationBarItem(
              icon: Container(),//Icon(Icons.home),
              title: Text('SECOND', style: TextStyle(
                color: _currentIndex == 1 ? Colors.black : Color.fromRGBO(51, 51, 51, 1),
                fontWeight: _currentIndex == 1 ? FontWeight.w800 : FontWeight.w400
              ),),
              backgroundColor: Color.fromRGBO(0, 0, 0, 0)
            ),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      )
    );
  }

  Widget _buildStackWithOffstages(BuildContext context) {
    return Stack(
      children: <Widget>[
        _buildOffstageNavigator(context, 0, 'first'),
        _buildOffstageNavigator(context, 1, 'second')
      ],
    );
  }

  Widget _buildOffstageNavigator(BuildContext context, int index, String route) {
    return Offstage(
      offstage: index != _currentIndex,
      child: Navigator(
        key: NavigatorKeys.navigators[index],
        initialRoute: route,
        onGenerateRoute: (settings) {
          return MaterialPageRoute(builder: 
            (context) => TestNavigationRoutes.routes[settings.name](context));
        },
      )
    );
  }
}