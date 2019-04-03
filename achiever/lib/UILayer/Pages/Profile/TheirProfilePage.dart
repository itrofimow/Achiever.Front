import 'package:flutter/material.dart';
import 'package:achiever/AppContainer.dart';
import 'package:achiever/BLLayer/Models/User/User.dart';
import './ProfileBuilder.dart';

class TheirProfilePage extends StatefulWidget {
  final String userId;

  TheirProfilePage(this.userId);

  @override
  _TheirProfilePageState createState() => _TheirProfilePageState();
}

class _TheirProfilePageState extends State<TheirProfilePage> {
  final _userApi = AppContainer.userApi;

  bool _isLoading = true;
  User model;

  @override
  void initState() {
      _updateData();
      super.initState();
    }

  void _updateData() {
    setState(() {
          _isLoading = true;
        });
    _userApi.getById(widget.userId).then((data){
      model = data;
      setState(() {
              _isLoading = false;
            });
    })
    .catchError((e) {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          ProfileBuilder.buildProfileHeader(_isLoading, model)
      ]
    ));
  }
}