import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:achiever/AppContainer.dart';
import 'package:achiever/UILayer/Pages/Feed/FeedTile.dart';
import 'package:achiever/UILayer/UXKit/KeepAliveFutureBuilder.dart';
import 'package:achiever/BLLayer/Models/Feed/FeedEntryResponse.dart';

import 'package:achiever/BLLayer/Redux/AppState.dart';
import 'package:achiever/BLLayer/Redux/Feed/FeedActions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'FeedEntry/FeedEntryPage.dart';
import 'FeedViewModel.dart';
import 'package:achiever/DALayer/ApiClient.dart';

import 'package:achiever/UILayer/UIKit/AchieverNavigationBar.dart';
import 'package:achiever/BLLayer/Redux/Keys.dart';
import 'dart:async';

class FeedPage extends StatefulWidget {

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  ScrollController _scrollController;
  bool _isScrollDownLocked = false;

  _scrollListener() async {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent && 
      !_scrollController.position.outOfRange) {
      if (_isScrollDownLocked) return;

      setState(() {
        _isScrollDownLocked = true;
      });

      final completer = Completer<Null>();
      AppContainer.store.dispatch(fetchNewFeedPage(completer));
      await completer.future;

      _isScrollDownLocked = false;
      if (mounted) {
        setState(() {
          
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController()
      ..addListener(_scrollListener);
  }
  
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, FeedViewModel>(
        onInit: (store) {
          final completer = Completer<Null>();
          store.dispatch(ResetFeedAction());
          store.dispatch(fetchNewFeedPage(completer));
        },
        converter: (store) => FeedViewModel.fromStore(store),
        builder: (context, viewModel) => _buildLayout(context, viewModel)
		);
  }

  Widget _buildLayout(BuildContext context, FeedViewModel viewModel) {
    final _navigateFunc = (BuildContext innerContext, FeedEntryResponse innerModel) =>
      Navigator.of(innerContext).push(MaterialPageRoute(
        builder: (context) => FeedEntryPage(innerModel.entry.id),
        settings: RouteSettings(name: 'feedEntry')));

    final listChildren = List<Widget>();
    viewModel.entries.forEach((x){
      listChildren.add(FeedTile(x, true, 
        viewModel.likeOrUnlikeCallback, _navigateFunc,
        viewModel.userId));
    });

    if (_isScrollDownLocked)
      listChildren.add(
        Container(
          height: 36,
          margin: EdgeInsets.only(top: 4, bottom: 4),
          child: Center(
            widthFactor: 1,
            heightFactor: 1,
            child: CircularProgressIndicator(),
          ),
        )
      );

    return RefreshIndicator(
        onRefresh: () {
          return viewModel.resetFeed();
        },
        child: ListView(
          physics: AlwaysScrollableScrollPhysics(),
          controller: _scrollController,
          //cacheExtent: MediaQuery.of(context).size.height * 2,
          children: listChildren,
      )
    );
  }
}