import 'PersonalFeedViewModel.dart';
import 'package:achiever/BLLayer/Redux/AppState.dart';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:achiever/BLLayer/Redux/PersonalFeed/PersonalFeedActions.dart';
import 'package:achiever/BLLayer/Models/Feed/FeedEntryResponse.dart';
import 'package:achiever/UILayer/UIKit/NoOpacityMaterialPageRoute.dart';
import '../Feed/FeedEntry/FeedEntryPage.dart';

import 'dart:async';
import 'package:achiever/AppContainer.dart';
import '../Feed/FeedTile.dart';

class PersonalFeedPage extends StatefulWidget {
  final bool isAchievementFeedPage;
  final String authorId;
  final ScrollController scrollController;

  PersonalFeedPage(this.isAchievementFeedPage, this.authorId, this.scrollController);

  @override
  _PersonalFeedPageState createState() => _PersonalFeedPageState();
}

class _PersonalFeedPageState extends State<PersonalFeedPage> {
  _scrollListener() async {
    if (widget.scrollController.offset >= widget.scrollController.position.maxScrollExtent && 
      !widget.scrollController.position.outOfRange) {

      final viewModel = PersonalFeedViewModel.fromStore(AppContainer.store, widget.authorId, widget.isAchievementFeedPage);
      if (viewModel.isLocked) return;

      final completer = Completer<Null>();
      AppContainer.store.dispatch(fetchNewPersonalFeedPage(widget.authorId, completer, widget.isAchievementFeedPage));
      await completer.future;
      
    }
  }

  @override
  void initState() {
    super.initState();

    widget.scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_scrollListener);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PersonalFeedViewModel>(
      onInit: (store) {
        store.dispatch(ResetPersonalFeedAction(widget.authorId, widget.isAchievementFeedPage));

        store.dispatch(fetchNewPersonalFeedPage(widget.authorId, Completer<Null>(), widget.isAchievementFeedPage));
      },
      converter: (store) => PersonalFeedViewModel.fromStore(store, widget.authorId, widget.isAchievementFeedPage),
      builder: (innerContext, viewModel) => _buildLayout(innerContext, viewModel),
    );
  }

  Widget _buildLayout(BuildContext context, PersonalFeedViewModel viewModel) {
    if (viewModel.entries.length == 0) return Container();

    final _navigateFunc = (BuildContext innerContext, FeedEntryResponse innerModel) =>
      Navigator.of(innerContext).push(NoOpacityMaterialPageRoute(
        builder: (context) => FeedEntryPage(innerModel.entry.id),
        settings: RouteSettings(name: 'feedEntry')));

    final listChildren = List<Widget>();
    viewModel.entries.forEach((x){
      listChildren.add(
        FeedTile(x, viewModel.isAchievementViewModel, viewModel.likeOrUnlikeCallback, _navigateFunc, viewModel.userId,
          allowAchievementNavigation: !viewModel.isAchievementViewModel,));
    });

    if (viewModel.isLocked)
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

    //Scroll

    return ListView(
      shrinkWrap: true,
      primary: false,
      padding: EdgeInsets.zero,
      //controller: _scrollController,
      
      children: listChildren
    );
  }
}