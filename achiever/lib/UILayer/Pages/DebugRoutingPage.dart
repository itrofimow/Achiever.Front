import 'package:flutter/material.dart';
import 'package:achiever/UILayer/UIKit/Buttons/AchieverButton.dart';
import 'package:achiever/AppContainer.dart';
import 'package:achiever/BLLayer/Redux/User/UserActions.dart';

class DebugRoutingPage extends StatefulWidget {
  @override
  DebugRoutingPageState createState() => DebugRoutingPageState();
}

class DebugRoutingPageState extends State<DebugRoutingPage> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

	@override
	Widget build(BuildContext context) {
		return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: new Text('asd'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        fixedColor: Colors.blue,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index == 0) {
            AppContainer.store.dispatch(logout);
          }

          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.exit_to_app),
            title: Text('123'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('223')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.image),
            title: Text('test')
          )
        ],
      ),
			body: new Container(
				padding: EdgeInsets.only(top: 100.0),
				child: new ListView(
					children: <Widget>[
            createButton('/main', context),
            createButton('/test', context),
            createButton('/achievementCategories', context),
            createButton('/notifications', context),
            createButton('/allUsers', context),
            createButton('/allAchievements', context),
            createButton('/createAchievement', context),
						createButton('/login', context),
						createButton('/feed', context),
            createButton('/welcome', context),
            createButton('/signup', context),
            createButton('/myProfile', context),
            createButton('/crop', context),
					]
				)
			)
		);
	}

	Container createButton(String path, BuildContext context) {
		return new Container(
			margin: EdgeInsets.only(top: 25.0),
			padding: EdgeInsets.only(bottom: 10.0, top: 10.0),
      child: AchieverButton(56.0, new Text(path, style: TextStyle(
					color: Colors.white,
					fontSize: 18.0)), () => Navigator.of(context).pushNamed(path))
		);
	}
}