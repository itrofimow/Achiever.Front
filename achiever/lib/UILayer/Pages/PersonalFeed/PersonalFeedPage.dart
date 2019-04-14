import 'PersonalFeedViewModel.dart';
import 'package:achiever/BLLayer/Redux/AppState.dart';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:achiever/BLLayer/Redux/PersonalFeed/PersonalFeedActions.dart';

import 'dart:async';
import 'package:achiever/AppContainer.dart';
import '../Feed/FeedTile.dart';

class PersonalFeedPage extends StatefulWidget {
  final String authorId;
  final ScrollController scrollController;

  PersonalFeedPage(this.authorId, this.scrollController);

  @override
  _PersonalFeedPageState createState() => _PersonalFeedPageState();
}

class _PersonalFeedPageState extends State<PersonalFeedPage> {


  _scrollListener() async {
    int a = 5;
    if (widget.scrollController.offset >= widget.scrollController.position.maxScrollExtent && 
      !widget.scrollController.position.outOfRange) {

      final viewModel = PersonalFeedViewModel.fromStore(AppContainer.store, widget.authorId);
      if (viewModel.isLocked) return;

      final completer = Completer<Null>();
      AppContainer.store.dispatch(fetchNewPersonalFeedPage(widget.authorId, completer));
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
        store.dispatch(ResetPersonalFeedAction(widget.authorId));

        store.dispatch(fetchNewPersonalFeedPage(widget.authorId, Completer<Null>()));
      },
      converter: (store) => PersonalFeedViewModel.fromStore(store, widget.authorId),
      builder: (innerContext, viewModel) => _buildLayout(innerContext, viewModel),
    );
  }

  Widget _buildLayout(BuildContext context, PersonalFeedViewModel viewModel) {
    if (viewModel.entries.length == 0) return Container();

    final listChildren = List<Widget>();
    viewModel.entries.forEach((x){
      listChildren.add(FeedTile(x, false, (_) => {}, (_, __) => {}, widget.authorId));
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
      //controller: _scrollController,
      
      children: listChildren
    );
  }
}