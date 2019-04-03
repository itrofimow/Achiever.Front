import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:achiever/BLLayer/Redux/AppState.dart';
import 'AchievementCategoriesViewModel.dart';
import 'package:achiever/BLLayer/Models/AchievementCategories/AchievementCategory.dart';
import 'dart:math';
import 'package:achiever/UILayer/UIKit/AchieverNavigationBar.dart';
import '../SelectedCategory/SelectedCategoryPage.dart';
import 'SearchResultPage.dart';

class AchievementCategoriesPage extends StatelessWidget {
  final _random = new Random();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AchievementCategoriesViewModel>(
      onInit: (store) => AchievementCategoriesViewModel.fromStore(store).fetchAll(),
      converter: (store) => AchievementCategoriesViewModel.fromStore(store),
      builder: (context, viewModel) => _buildLayout(context, viewModel),
    );
  }

  Widget _buildLayout(BuildContext context, AchievementCategoriesViewModel viewModel) {
    return _buildCategoriesLayout(context, viewModel);
  }

  Widget _buildCategoriesLayout(BuildContext context, AchievementCategoriesViewModel viewModel) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => viewModel.fetchAll(),
        child: Container(
          margin: EdgeInsets.only(top: 52, left: 16, right: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildHeader(context, viewModel),
              Expanded(
                child: _buildCategoriesList(context, viewModel)
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: AchieverNavigationBar(
        currentIndex: 1, profileImagePath: viewModel.userProfileImagePath, onTap: (_) => {},),
    );
  }

  Widget _buildHeader(BuildContext context, AchievementCategoriesViewModel viewModel) {
    final searchBox = GestureDetector(
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Color.fromARGB(255, 242, 242, 242),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 6),
              child: Text('Поиск', style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 17,
                letterSpacing: -0.41,
                color: Color.fromRGBO(51, 51, 51, 0.7),
                height: 14.0 / 12
              )),
            ),
            Container(
              margin: EdgeInsets.only(right: 16),
              child: Opacity(
                opacity: 0.5,
                child: Icon(Icons.search),
              )
            )
          ],
        ),
      ),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => SearchResultPage())),
    );

    final bigTitle = Container(
      margin: EdgeInsets.only(top: 20),
      child: Text('Достижения', style: TextStyle(
        fontWeight: FontWeight.w900,
        fontSize: 40,
        letterSpacing: 0.11,
        color: Color.fromARGB(255, 51, 51, 51)
      ),),
    );

    final subTitle = Container(
      margin: EdgeInsets.only(top: 2),
      child: Text('В жизни всегда можно сделать что-то еще', style: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 14,
        letterSpacing: 0.24,
        color: Color.fromRGBO(51, 51, 51, 0.7),
        height: 20.0 / 14
      )),
    );

    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          searchBox,
          bigTitle,
          subTitle
        ],
      ),
    );
  }

  Widget _buildCategoriesList(BuildContext context, AchievementCategoriesViewModel viewModel) {
    final list = viewModel.achievementCategories.map((x) => _buildCategory(context, x)).toList();
    list.add(Container(height: 28,));

    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ScrollConfiguration(
        behavior: NoScrollGlowBehavior(),
        child: ListView(
          children: list
        )
      )
    );
  }

  Widget _buildCategory(BuildContext context, AchievementCategory category) {
    final List colors = [Colors.red, Colors.green, Colors.yellow, 
      Colors.purple, Colors.red, Colors.pink];

    final image = Container(
      width: 40,
      height: 40,
      margin: EdgeInsets.only(left: 16, right: 16, top: 16),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colors[_random.nextInt(colors.length)],
      ),
    );

    final titleAndSubtitle = Container(
      margin: EdgeInsets.only(top: 18, left: 16, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(category.title, style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 24,
            letterSpacing: 0.29,
            color: Color.fromRGBO(51, 51, 51, 1),
            //height: 28.0 / 24
          ),),
          Container(
            margin: EdgeInsets.only(top: 2),
            child: Text(category.subtitle, style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              letterSpacing: 0.24,
              color: Color.fromRGBO(51, 51, 51, 0.5),
              height: 20.0 / 14
            ),)
          )
        ],
      )
    );

    return Container(
      margin: EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color.fromARGB(255, 242, 242, 242)
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        child:  Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: titleAndSubtitle),
            image
          ],
        ),
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SelectedCategoryPage(category.id))),
      )
    );
  }
}

class NoScrollGlowBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}