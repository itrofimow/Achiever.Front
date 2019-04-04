import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:achiever/BLLayer/Redux/AppState.dart';
import 'SelectedCategoryViewModel.dart';
import 'package:achiever/UILayer/UIKit/AchieverNavigationBar.dart';
import 'package:achiever/UILayer/UIKit/Achievement/AchieverAchievement.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:achiever/DALayer/ApiClient.dart';
import 'package:achiever/BLLayer/Redux/Keys.dart';
import 'package:achiever/UILayer/Pages/Achievements/AchievementCreationPage.dart';
import 'package:achiever/UILayer/UIKit/Buttons/AchieverSecondaryButton.dart';
import 'package:achiever/BLLayer/Redux/Keys.dart';
import '../SelectedAchievement/SelectedAchievementPage.dart';

class SelectedCategoryPage extends StatefulWidget {
  final String _categoryId;

  SelectedCategoryPage(this._categoryId);

  @override
  SelectedCategoryPageState createState() => SelectedCategoryPageState();
}

enum _TopNavigationState {
  all,
  my,
  notYet
}

class SelectedCategoryPageState extends State<SelectedCategoryPage> {
  var _topNavState = _TopNavigationState.all;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SelectedCategoryViewModel> (
      onInit: (store) => SelectedCategoryViewModel.fromStore(store, widget._categoryId).fetchByCategoryFunc(),
      converter: (store) => SelectedCategoryViewModel.fromStore(store, widget._categoryId),
      builder: (context, viewModel) => _buildLayout(context, viewModel),
    );
  }

  Widget _buildLayout(BuildContext context, SelectedCategoryViewModel viewModel) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: RefreshIndicator(
        onRefresh: () => viewModel.fetchByCategoryFunc(),
        child: Container(
          //margin: EdgeInsets.only(top: 50),
          child: Column(
            children: [
              _buildFitted(context, _buildHeader(context, viewModel)),
              _buildDivider(context),
              _buildFitted(context, _buildTopNavigation(context)),
              Container(height: 1, color: Color.fromARGB(255, 242, 242, 242),),
              Expanded(child: _buildFitted(context, _buildList(context, viewModel)))
            ]
          ),
        ),
      ),
      bottomNavigationBar: AchieverNavigationBar(
        currentIndex: 1,
        profileImagePath: 'default.png',
        onTap: (index) => {},
      ),
    );
  }

  Widget _buildHeader(BuildContext context, SelectedCategoryViewModel viewModel) {
    final editButton = AchieverSecondaryButton(
      text: 'Добавить',
      onTap: () => Keys.navigatorKey.currentState.push(MaterialPageRoute(
          builder: (_) => AchievementCreationPage())),
    );
    
    return Container(
      margin: EdgeInsets.only(top: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('Игры', style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 40,
            color: Color.fromARGB(255, 51, 51, 51),
            letterSpacing: 0.11
          ),),
          editButton
        ],
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Column(
      children: [
        Container(height: 16,),
        Container(
          height: 12,
          color: Color.fromARGB(255, 242, 242, 242),
        )
      ]
    );
  }

  Widget _buildTopNavigation(BuildContext context) {
    final allButton = AchieverSecondaryButton(
      text: 'Все', onTap: () => setState(() {
        _topNavState = _TopNavigationState.all;
      }), leftRightMargin: 12, 
      makeTransparent: _topNavState != _TopNavigationState.all,
      color: _topNavState != _TopNavigationState.all ? Color.fromRGBO(51, 51, 51, 0.5) : null,
    );

    final myButton = Container(
      margin: EdgeInsets.only(left: 4, right: 4),
      child: AchieverSecondaryButton(
        text: 'Мои', onTap: () => setState(() {
          _topNavState = _TopNavigationState.my;
        }), leftRightMargin: 12,
        makeTransparent: _topNavState != _TopNavigationState.my,
        color: _topNavState != _TopNavigationState.my ? Color.fromRGBO(51, 51, 51, 0.5) : null,
      )
    );

    final notYetButton = AchieverSecondaryButton(
      text: 'Еще не получены', onTap: () => setState(() {
        _topNavState = _TopNavigationState.notYet;
      }), leftRightMargin: 12,
      makeTransparent: _topNavState != _TopNavigationState.notYet,
      color: _topNavState != _TopNavigationState.notYet ? Color.fromRGBO(51, 51, 51, 0.5) : null,
    );

    return Container(
      height: 48,
      child: Row(
        children: <Widget>[
          allButton,
          myButton,
          notYetButton
        ],
      ),
    );
  }

  Widget _buildList(BuildContext context, SelectedCategoryViewModel viewModel) {
    return ListView(
      children: (_topNavState == _TopNavigationState.all ? viewModel.allAchievements : viewModel.myAchievements).map((x) {
        return Container(
          margin: EdgeInsets.only(top: 20),
          child: GestureDetector(
            child: AchieverAchievement(x, 
              MediaQuery.of(context).size.width - 16 * 2,
              CachedNetworkImageProvider('${ApiClient.staticUrl}/${x.backgroundImage.imagePath}'),
              CachedNetworkImageProvider('${ApiClient.staticUrl}/${x.frontImage.imagePath}')
            ),
            onTap: () => Keys.navigatorKey.currentState.push(MaterialPageRoute(
              builder: (_) => SelectedAchievementPage(x.id))),
          ),
        );
      }).toList()
    );
  }

  Widget _buildFitted(BuildContext context, Widget body) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16),
      child: body,
    );
  }
}