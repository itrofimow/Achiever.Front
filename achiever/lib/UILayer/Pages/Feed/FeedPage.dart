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

class FeedPage extends StatelessWidget {
  
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

    return RefreshIndicator(
        onRefresh: () {
          return viewModel.resetFeed();
        },
        child: ListView(
          //cacheExtent: MediaQuery.of(context).size.height * 2,
          children: viewModel.entries.map((x){
            return FeedTile(x, true, 
              viewModel.likeOrUnlikeCallback, _navigateFunc,
              viewModel.userId);
          }).toList(),
      )
    );
  }
}