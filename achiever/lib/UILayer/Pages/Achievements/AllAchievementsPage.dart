import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:achiever/BLLayer/Redux/AppState.dart';
import 'AllAchievementsViewModel.dart';
import 'package:achiever/UILayer/UIKit/Achievement/AchieverAchievement.dart';
import 'package:achiever/UILayer/Pages/Feed/EntryCreationPage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:achiever/DALayer/ApiClient.dart';
import 'package:achiever/BLLayer/Redux/Achievements/AllAchievementsActions.dart';
import 'dart:async';

class AllAchievementsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AllAchievementsViewModel>(
        onInit: (store) {
          final completer = Completer<Null>();
          store.dispatch(fetchAllAchievementsAction(completer));
        },
        converter: (store) => AllAchievementsViewModel.fromStore(store),
        builder: (context, viewModel) => _buildLayout(context, viewModel)
    );
  }

  Widget _buildLayout(BuildContext context, AllAchievementsViewModel viewModel) {
    return viewModel.isLoading ? Center(
      child: CircularProgressIndicator(),
    ) :
      RefreshIndicator(
        onRefresh: () => viewModel.updateList(),
        child: Container(
          child: ListView(
            children: viewModel.allAchievements.map((x) {
              return new GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => EntryCreationPage(x.id), 
                  settings: RouteSettings(name: 'entryCreation'))),
                child: new Container(
                  //decoration: BoxDecoration(border: Border.all(color: Colors.red, width: 1.0)),
                  margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 25.0, bottom: 25.0),
                  child: AchieverAchievement(x, 
                    MediaQuery.of(context).size.width - 16 * 2,
                    CachedNetworkImageProvider('${ApiClient.staticUrl}/${x.backgroundImage?.imagePath}'),
                    CachedNetworkImageProvider('${ApiClient.staticUrl}/${x.frontImage?.imagePath}')
                  )
                )
              );
            }).toList()
          )
        )
      );
  }
}