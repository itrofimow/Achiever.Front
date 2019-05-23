import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:achiever/BLLayer/Redux/AppState.dart';
import 'SelectedCategoryViewModel.dart';
import 'package:achiever/UILayer/UIKit/AchieverNavigationBar.dart';
import 'package:achiever/UILayer/UIKit/Achievement/AchieverAchievement.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:achiever/DALayer/ApiClient.dart';
import 'package:achiever/BLLayer/Redux/Keys.dart';
import 'package:achiever/UILayer/Pages/Achievements/AchievementCreationPageV2.dart';
import 'package:achiever/UILayer/UIKit/Buttons/AchieverSecondaryButton.dart';
import 'package:achiever/UILayer/UIKit/NoOpacityMaterialPageRoute.dart';
import 'package:achiever/BLLayer/Models/Achievement/Achievement.dart';
import '../SelectedAchievement/SelectedAchievementPage.dart';
import 'package:achiever/UILayer/UIKit/Buttons/AchieverButton.dart';

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
    return /*Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: */RefreshIndicator(
        onRefresh: () => viewModel.fetchByCategoryFunc(),
        child: Container(
          //margin: EdgeInsets.only(top: 50),
          child: Column(
            children: [
              _buildFitted(context, _buildHeader(context, viewModel)),
              _buildDivider(context),
              _buildFitted(context, _buildTopNavigation(context)),
              Container(height: 1, color: Color.fromARGB(255, 242, 242, 242),),
                _topNavState == _TopNavigationState.all 
                ? _buildAllAchievementsList(context, viewModel)
                : _buildMyAchievementsList(context, viewModel)
            ]
          ),
        ),
      //)
    );
  }

  Widget _buildHeader(BuildContext context, SelectedCategoryViewModel viewModel) {
    final editButton = AchieverSecondaryButton(
      text: 'Добавить',
      onTap: () => Keys.baseNavigatorKey.currentState.push(NoOpacityMaterialPageRoute(
          builder: (_) => AchievementCreationPageV2(viewModel.category),
          settings: RouteSettings(name: 'createAchievement'))),
    );
    
    return Container(
      margin: EdgeInsets.only(top: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(viewModel.name, style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 20,
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

  Widget _buildList(BuildContext context, List<Achievement> achievements) {
    return ListView(
      children: achievements.map((x) {
        return Container(
          margin: EdgeInsets.only(top: 20),
          child: GestureDetector(
            child: AchieverAchievement(x, key: ValueKey(x.id),),
            onTap: () => Navigator.of(context).push(NoOpacityMaterialPageRoute(
              builder: (_) => SelectedAchievementPage(x.id), 
              settings: RouteSettings(name: 'selectedAchievement'))),
          ),
        );
      }).toList()
    );
  }

  Widget _buildAllAchievementsList(BuildContext context, SelectedCategoryViewModel viewModel) {
    return Expanded(child: _buildFitted(context, _buildList(context, viewModel.allAchievements)));
  }

  Widget _buildMyAchievementsList(BuildContext context, SelectedCategoryViewModel viewModel) {
    if (viewModel.myAchievements.length > 0)
      return Expanded(child: _buildFitted(context, _buildList(context, viewModel.myAchievements)));

    final content = Container(
      margin: EdgeInsets.only(top: 53),
      child: Column(
        children: <Widget>[
          Container(
            width: 130,
            height: 140,
            //color: Colors.black,
            child: Image.asset('assets/achiever_logo.png', 
              color: Color.fromRGBO(51, 51, 51, 1), 
              colorBlendMode: BlendMode.srcIn,),
          ),
          Container(
            margin: EdgeInsets.only(top: 25),
            child: Text('В этой категории пока нет\nполученных достижений.\nНайдите то, что вам по душе!', style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 17,
              color: Color.fromRGBO(51, 51, 51, 1),
              letterSpacing: -0.41
            ), textAlign: TextAlign.center,),
          ),
          Container(
            margin: EdgeInsets.only(top: 32),
            child: AchieverButton.createDefault(Text('Все достижения в категории', style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: Colors.white,
              letterSpacing: 0.26
            )), () => setState((){
              _topNavState = _TopNavigationState.all;
            })),
          )
        ],
      ),
    );

    return _buildFitted(context, content);
  }

  Widget _buildFitted(BuildContext context, Widget body) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16),
      child: body,
    );
  }
}