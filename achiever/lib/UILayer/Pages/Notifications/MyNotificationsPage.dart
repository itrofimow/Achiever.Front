import 'package:flutter/material.dart';

class MyNotificationsPage extends StatefulWidget {
  @override
  MyNotificationsPageState createState() => MyNotificationsPageState();
}

class MyNotificationsPageState extends State<MyNotificationsPage> {
  List<int> _list = List<int>();
  bool _locked = false;
  ScrollController _scrollController;

  MyNotificationsPageState() {
    for (var i = 0; i < 10; i++) {
      _list.add(i);
    }
  }

  _scrollListener() async {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent && 
      !_scrollController.position.outOfRange) {
        if (!_locked) {
          _locked = true;
          await Future.delayed(Duration(milliseconds: 500));
          for (var i = 0; i < 10; i++) {
            _list.add(i);
          }
          if (mounted)
            setState(() {
              
            });
          _locked = false;
        }
      }
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('test'),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 16, right: 16, top: 10),
        child: ListView(
          controller: _scrollController,
          children: _list.map((i){
            return Container(
              margin: EdgeInsets.only(bottom: 12.0),
              color: Colors.red,
              height: 100,
              child: Center(
                child: Text('$i', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
              )
            );
          }).toList(),
        ),
      ),
    );
  }
}