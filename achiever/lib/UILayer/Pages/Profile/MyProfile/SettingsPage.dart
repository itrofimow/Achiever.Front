import 'package:flutter/material.dart';
import 'package:achiever/AppContainer.dart';
import 'package:achiever/BLLayer/Redux/User/UserActions.dart';
import 'package:achiever/BLLayer/Redux/Keys.dart';
import 'package:achiever/UILayer/UIKit/NoOpacityMaterialPageRoute.dart';
import 'package:achiever/UILayer/UXKit/PolicyBuilder.dart';

class SettingsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Настройки'), 
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildFitted(context, _buildLogo(context)),
            _buildDivider(context),
            _buildButtons(context),
            _buildDivider(context)
          ],
        ),
      )
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Container(
      color: Color.fromRGBO(242, 242, 242, 1),
      height: 12,
    );
  }

  Widget _buildLogo(BuildContext context) {
    return Container(
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
            margin: EdgeInsets.only(top: 17),
            child: Text('Achiever', style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 34,
              letterSpacing: -0.41,
              color: Color.fromRGBO(51, 51, 51, 1),
            ), textAlign: TextAlign.center,),
          ),
          Container(
            margin: EdgeInsets.only(top: 4, bottom: 60),
            child: Text('Версия 1.0', style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 17,
              color: Color.fromRGBO(51, 51, 51, 0.7)
            ),),
          )
        ],
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Column(
      children: [
        _buildSingleButton(context, 'assets/logout_icon.png', 'Выйти из аккаунта', () {
          Keys.baseNavigatorKey.currentState.pushNamedAndRemoveUntil('/welcome', (_) => false);
          Future.delayed(Duration(milliseconds: 1000)).then((_) => AppContainer.store.dispatch(logout));
        },),
        _buildFitted(context, Container(
          height: 1,
          color: Color.fromRGBO(242, 242, 242, 1),
        )),
        _buildSingleButton(context, 'assets/policy_icon.png', 'Политика конфиденциальности', () {
          Navigator.of(context).push(NoOpacityMaterialPageRoute(
            builder: (bc) => PolicyBuilder.buildWebView(context),
            settings: RouteSettings(name: 'policy')
          ));
        })
      ],
    );
  }

  Widget _buildSingleButton(BuildContext context, String assetPath, String text, Function onTap) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: _buildFitted(context, Container(
        height: 67,
        child: Row(
          children: [
            Image.asset(assetPath, height: 36, width: 36,),
            Container(
              margin: EdgeInsets.only(left: 12),
              child: Text(text, style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                letterSpacing: 0.22,
                color: Color.fromRGBO(51, 51, 51, 1)
              ),),
            )
          ],  
        ),
      )),
      onTap: onTap,
    );
  }

  Widget _buildFitted(BuildContext context, Widget child) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16),
      child: child,
    );
  }
}