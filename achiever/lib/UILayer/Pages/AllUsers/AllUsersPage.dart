import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:achiever/BLLayer/Redux/AppState.dart';
import 'package:achiever/BLLayer/Models/User/UserDto.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:achiever/DALayer/ApiClient.dart';
import 'package:achiever/UILayer/UIKit/Buttons/AchieverButton.dart';

import 'AllUsersViewModel.dart';

class AllUsersPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AllUsersViewModel>(
      converter: (store) => AllUsersViewModel.fromStore(store),
      builder: (context, viewModel) => _buildLayout(context, viewModel),
    );
  }

  Widget _buildLayout(BuildContext context, AllUsersViewModel viewModel) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: new Text('all users'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          viewModel.refresh();
        },
        child: ListView(
          children: viewModel.allUsers.map((x){
            return Container(
              height: 80.0,
              margin: EdgeInsets.all(16.0),
              child: UserSmallTile(x, viewModel.follow, viewModel.unfollow, viewModel.isLocked),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1)
              ),
            );
          }).toList()
        ),
      ),
    );
  }
}

class UserSmallTile extends StatelessWidget {
  final UserDto model;
  final Function(String) _follow, _unfollow;
  final bool isLocked;

  UserSmallTile(this.model, 
    this._follow, this._unfollow,
    this.isLocked);

  @override
  Widget build(BuildContext context) {
    final profileImage = new Container(
      height: 36.0,
      width: 36.0,
      child: new CircleAvatar(
        //borderRadius: BorderRadius.circular(50.0),
        child: new CachedNetworkImage(imageUrl: '${ApiClient.staticUrl}/${model.user.profileImagePath}',
          width: 36.0, height: 36.0,)
      ),
    );

    return Container(
      child: Row(
        children: <Widget>[
          profileImage,
          Container(
            margin: EdgeInsets.only(left: 16),
            child: Text(model.user.nickname),
          ),
          Expanded(
            child: Container(),
          ),
          Container(
            margin: EdgeInsets.only(right: 16.0),
            child: AchieverButton(150, 60, Text(model.following ? 'Unfollow' : 'Follow', 
              style: TextStyle(color: Colors.white),), isLocked ? null : (){
                model.following ? 
                  _unfollow(model.user.id) : 
                  _follow(model.user.id);
              })
          )
        ],
      )
    );
  }
}