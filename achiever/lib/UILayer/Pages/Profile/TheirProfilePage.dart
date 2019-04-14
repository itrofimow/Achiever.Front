import 'package:flutter/material.dart';
import 'package:achiever/AppContainer.dart';
import 'package:achiever/BLLayer/Models/User/User.dart';
import './ProfileBuilder.dart';
import 'MyProfile/MyProfilePage.dart';
import 'package:achiever/BLLayer/Redux/AppState.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import '../PersonalFeed/PersonalFeedPage.dart';

class TheirProfilePage extends StatefulWidget {
  final String userId;

  TheirProfilePage(this.userId);

  @override
  _TheirProfilePageState createState() => _TheirProfilePageState();
}

class _TheirProfilePageState extends State<TheirProfilePage> {
  final _userApi = AppContainer.userApi;
  ScrollController _scrollController = ScrollController();

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
    if (_isLoading) return Container(color: Colors.black,);
    return StoreBuilder<AppState>(
       builder: (innerContext, store) => _buildLayout(innerContext, store)
    );
  }

  Widget _buildLayout(BuildContext context, Store<AppState> store) {
    final header = MyProfilePageState.buildHeader(context, model, false, false);

    return RefreshIndicator(
      onRefresh: () => Future.delayed(Duration(milliseconds: 700)),//fetchEntriesCount(viewModel.user.id),
      child: ListView(
        controller: _scrollController,
        children: <Widget>[
          _buildFitted(context, header),
          _buildPersonalFeed(context, widget.userId)
        ],
      )
    );
  }

  Widget _buildPersonalFeed(BuildContext context, String authorId) {
    return PersonalFeedPage(authorId, _scrollController);
  }

  Widget _buildFitted(BuildContext context, Widget body) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16),
      child: body,
    );
  }
}