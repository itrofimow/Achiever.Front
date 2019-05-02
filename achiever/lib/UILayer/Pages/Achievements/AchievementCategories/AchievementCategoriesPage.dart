import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:achiever/BLLayer/Redux/AppState.dart';
import 'AchievementCategoriesViewModel.dart';
import 'package:achiever/BLLayer/Models/AchievementCategories/AchievementCategory.dart';
import 'dart:math';
import 'package:achiever/UILayer/UIKit/AchieverNavigationBar.dart';
import '../SelectedCategory/SelectedCategoryPage.dart';
import 'SearchResultPage.dart';
import 'package:achiever/DALayer/ApiClient.dart';

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
    return RefreshIndicator(
      onRefresh: () => viewModel.fetchAll(),
      child: Container(
        margin: EdgeInsets.only(left: 16, right: 16),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildHeader(context, viewModel),
              _buildCategoriesList(context, viewModel)
            ],
          ),
        ),
      )
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 12),
              child: Opacity(
                opacity: 0.5,
                child: Icon(Icons.search),
              )
            ),
            Container(
              margin: EdgeInsets.only(left: 12),
              child: Text('Достижения, люди', style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 17,
                letterSpacing: -0.41,
                color: Color.fromRGBO(51, 51, 51, 0.5),
                height: 22.0 / 17
              )),
            ),
          ],
        ),
      ),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => SearchResultPage(), 
        settings: RouteSettings(name: 'searchResult'))),
    );

    final bigTitle = Container(
      margin: EdgeInsets.only(top: 24),
      child: Text('Достижения', style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 24,
        letterSpacing: 0.29,
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
        child: Column(
          children: list
        )
    );
  }

  Widget _buildCategory(BuildContext context, AchievementCategory category) {
    final image = Container(
      width: 88,
      height: 88,
      margin: EdgeInsets.only(left: 16),
      /*decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colors[_random.nextInt(colors.length)],
      ),*/
      child: ClipRRect(
        borderRadius: BorderRadius.only(topRight: Radius.circular(15), bottomRight: Radius.circular(15)),
        child: OverflowBox(
          alignment: Alignment.centerLeft,
          minWidth: 112,
          maxWidth: 112,
            child: Image.network('${ApiClient.staticUrl}/${category.niceImagePath}',
            fit: BoxFit.fitWidth,),
        )
      )
    );

    final titleAndSubtitle = Container(
      margin: EdgeInsets.only(top: 22, left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(category.title, style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 14,
            letterSpacing: 0.24,
            color: Color.fromRGBO(51, 51, 51, 1),
            //height: 28.0 / 24
          ),),
          Container(
            margin: EdgeInsets.only(top: 4),
            child: Text(category.subtitle, style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12,
              letterSpacing: 0.21,
              color: Color.fromRGBO(51, 51, 51, 0.5),
              height: 20.0 / 12
            ),)
          )
        ],
      )
    );

    return Container(
      height: 88,
      margin: EdgeInsets.only(top: 16),
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
          builder: (context) => SelectedCategoryPage(category.id),
          settings: RouteSettings(name: 'selectedCategory'))),
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