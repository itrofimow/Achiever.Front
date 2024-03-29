import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:achiever/BLLayer/Redux/AppState.dart';
import 'AchievementCategoriesViewModel.dart';
import 'package:achiever/BLLayer/Models/Achievement/Achievement.dart';
import 'package:achiever/UILayer/UIKit/Achievement/AchieverAchievement.dart';
import 'package:achiever/AppContainer.dart';
import 'package:achiever/BLLayer/Models/Search/SearchRequest.dart';
import 'package:achiever/BLLayer/Models/User/UserDto.dart';
import 'package:achiever/UILayer/UIKit/User/UserTile.dart';
import '../SelectedAchievement/SelectedAchievementPage.dart';
import 'package:achiever/BLLayer/Redux/User/UserActions.dart';
import 'package:flutter/services.dart';
import 'package:achiever/UILayer/UIKit/NoOpacityMaterialPageRoute.dart';

class SearchResultPage extends StatefulWidget {

  @override
  SearchResultPageState createState() => SearchResultPageState();
}

class SearchResultPageState extends State<SearchResultPage> {
  final TextEditingController _controller = TextEditingController();

  List<Achievement> _achievements = List<Achievement>();
  List<UserDto> _users = List<UserDto>();

  final _searchFocusNode = FocusNode();
  final _dummyFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AchievementCategoriesViewModel>(
      converter: (store) => AchievementCategoriesViewModel.fromStore(store),
      builder: (context, viewModel) => _buildLayout(context, viewModel),
    );
  }

  Widget _buildLayout(BuildContext context, AchievementCategoriesViewModel viewModel) {
    return Container(
        margin: EdgeInsets.only(left: 16, right: 16),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBox(context, viewModel),
            Expanded(child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAchievement(context),
                  _buildUsers(context),
                  Container(
                    height: 20,
                  )
                ]
              )
            ))
          ]
        )
    );
  }

  Widget _buildSearchBox(BuildContext context, AchievementCategoriesViewModel viewModel) {
    return TextField(
      focusNode: _searchFocusNode,
      controller: _controller,
      textInputAction: TextInputAction.search,
      onSubmitted: (val) => _processSearch(val),
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(Icons.cancel),
          onPressed: () {
            _controller.text = '';
            FocusScope.of(context).requestFocus(_dummyFocusNode);
          }
        ),
      )
    );
  }

  Widget _buildAchievement(BuildContext context) {
    final columnChildren = [
      Container(
        margin: EdgeInsets.only(top: 20),
        height: 32,
        child: Text('ДОСТИЖЕНИЯ', style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 15,
          letterSpacing: 0.95,
          color: Color.fromRGBO(88, 89, 94, 0.5)
        ), textAlign: TextAlign.left,),
      )
    ];

    _achievements.forEach((x) {
      columnChildren.add(
        Container(
          margin: EdgeInsets.only(top: 12),
          child: GestureDetector(
            child: AchieverAchievement(x, key: ValueKey(x.id),),
            onTap: () => Navigator.of(context).push(NoOpacityMaterialPageRoute(
              builder: (_) => SelectedAchievementPage(x.id),
              settings: RouteSettings(name: 'selectedAchievement'))),
          ),
        )
      );
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: columnChildren
    );
  }

  Widget _buildUsers(BuildContext context) {
    final columnChildren = [
      Container(
        margin: EdgeInsets.only(top: 20),
        height: 32,
        child: Text('ЛЮДИ', style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 15,
          letterSpacing: 0.95,
          color: Color.fromRGBO(88, 89, 94, 0.5)
        ), textAlign: TextAlign.left,),
      )
    ];

    int index = 0;
    _users.forEach((x) {
      columnChildren.add(
        Container(
          margin: EdgeInsets.only(top: 12.0 + (index > 0 ? 8 : 0)),
          child: UserTile(x, key: ValueKey(x.user.id),),
        )
      );
      index++;
    });
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: columnChildren
    );
  }

  void _processSearch(String query) {
    AppContainer.searchApi.search(SearchRequest(query)).then((data){
      AppContainer.store.dispatch(AddManyKnownUsersAction(data.users));

      if (mounted)
        setState(() {
          _achievements = data.achievements;
          _users = data.users;
        });
    });
  }
}