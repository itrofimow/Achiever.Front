import 'package:flutter/material.dart';
import 'package:achiever/AppContainer.dart';
import 'package:achiever/BLLayer/Models/User/User.dart';
import './ProfileBuilder.dart';
import 'package:achiever/BLLayer/Redux/AppState.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import '../PersonalFeed/PersonalFeedPage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:achiever/DALayer/ApiClient.dart';
import 'package:achiever/BLLayer/Models/User/UserDto.dart';
import 'ExtendedStatsPage.dart';
import 'package:achiever/BLLayer/Redux/User/UserActions.dart';
import 'dart:async';

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

  Future<List<UserDto>> _getFollowingsFuture;
  Future<List<UserDto>> _getFollowersFuture;

  bool loadingEntriesCount = true;
  int entriesCount = 0;

  Future fetchEntries(String userId) async {
    final count = await AppContainer.userApi.countFeedEntries(userId);

    setState(() {
      loadingEntriesCount = false;
      entriesCount = count;
      _getFollowingsFuture = AppContainer.userApi.getFollowings(userId);
      _getFollowersFuture = AppContainer.userApi.getFollowers(userId);
    });

    return Future.wait([_getFollowingsFuture, _getFollowersFuture]);
  }


  @override
  void initState() {
      _updateData();

      fetchEntries(widget.userId);

      super.initState();
    }

  void _updateData() {
    setState(() {
          _isLoading = true;
        });
    _userApi.getById(widget.userId).then((data){
      model = data;
      AppContainer.store.dispatch(AddKnownUserAction(
        UserDto(
          model, 
          AppContainer.store.state.userState.followings.contains(model.id))
        )
      );

      if (mounted)
        setState(() {
          _isLoading = false;
        });
    })
    .catchError((e) {

    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
    return StoreBuilder<AppState>(
       builder: (innerContext, store) => _buildLayout(innerContext, store)
    );
  }

  Widget _buildLayout(BuildContext context, Store<AppState> store) {
    return RefreshIndicator(
      onRefresh: () => fetchEntries(widget.userId),
      child: ListView(
        controller: _scrollController,
        children: <Widget>[
          _buildFitted(context, _buildHeader(context, model, store)),
          _buildFitted(context, _buildAbout(context, model)),
          _buildFitted(context, _buildStats(context, model)),
          ProfileBuilder.buildDivider(context),
          _buildPersonalFeed(context, widget.userId)
        ],
      )
    );
  }

  Widget _buildAbout(BuildContext context, User user) {
    return ProfileBuilder.buildAbout(context, user);
  }

  Widget _buildPersonalFeed(BuildContext context, String authorId) {
    return PersonalFeedPage(false, authorId, _scrollController);
  }

  Widget _buildHeader(BuildContext context, User user, Store<AppState> store) {
    final profileImage = new Container(
      height: 56.0,
      width: 56.0,
      child: new ClipRRect(
        borderRadius: BorderRadius.circular(50.0),
        child: new CachedNetworkImage(imageUrl: '${ApiClient.staticUrl}/${user.profileImagePath}',
          width: 36.0, height: 36.0,)
      ),
    );

    final subUnsubButton = store.state.userState.followings.contains(model.id)
      ? _buildSubbedButton(context, store)
      : _buildSubButton(context, store);

    return Container(
      margin: EdgeInsets.only(top: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          profileImage,
          Expanded(child: Container(),),
          subUnsubButton
        ],
      ),
    );
  }

  Widget _buildSubbedButton(BuildContext context, Store<AppState> store) {
    return GestureDetector(
      child: Container(
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            color: Color.fromARGB(255, 242, 242, 242)
          ),
          height: 36,
          child: Center(
            widthFactor: 1,
            child: Container(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Text('Вы подписаны', style: TextStyle(
                fontSize: 13,
                letterSpacing: 0.22,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 51, 51, 51)
              )),
            ),
          ),
        ),
      ),
      onTap: () => store.dispatch(unfollowAndReload(model.id, Completer<bool>())),
    );
  }

  Widget _buildSubButton(BuildContext context, Store<AppState> store) {
    return GestureDetector(
      child: Container(
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            //color: Color.fromARGB(255, 242, 242, 242)
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(0, 202, 255, 1),
                Color.fromRGBO(0, 142, 255, 1)
              ]
            )
          ),
          height: 36,
          child: Center(
            widthFactor: 1,
            child: Container(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Text('Подписаться', style: TextStyle(
                fontSize: 13,
                letterSpacing: 0.22,
                fontWeight: FontWeight.w500,
                color: Colors.white
              )),
            ),
          ),
        ),
      ),
      onTap: () => store.dispatch(followAndReload(model.id, Completer<bool>())),
    );
  }

  Widget _buildStats(BuildContext context, User user) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileBuilder.buildStatsBlock(context, loadingEntriesCount ? 0 : entriesCount, 'Записей'),
          Container(
            margin: EdgeInsets.only(left: 36),
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              child: ProfileBuilder.buildStatsBlock(context, user.stats.followers, 'Подписчиков'),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (innerContext) => ExtendedStatsPage(_getFollowersFuture, key: ObjectKey(_getFollowersFuture),),
                settings: RouteSettings(name: 'followers')
              )),
            )
          ),
          Container(
            margin: EdgeInsets.only(left: 36),
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              child: ProfileBuilder.buildStatsBlock(context, user.stats.following, 'Подписок'),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => ExtendedStatsPage(_getFollowingsFuture, key: ObjectKey(_getFollowingsFuture),),
                settings: RouteSettings(name: 'followings')
              )),
            )
          )
        ]
      ),
    );
  }

  Widget _buildFitted(BuildContext context, Widget body) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16),
      child: body,
    );
  }
}