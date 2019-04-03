import 'package:flutter/material.dart';

class AchieverAchievementV2 extends StatelessWidget {
  var _title = "Палач рока";
  var _subTitle = "Полностью пройдите сюжет игры Doom 2016";


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        //color: Colors.red,
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(51, 51, 51, 0.8),
            Color.fromRGBO(51, 51, 51, 0)
          ]
        ),
      ),
      height: 100,
      child: _buildTextAndMaskedImage(context, _title, _subTitle),
    );
  }

  Widget _buildTextAndMaskedImage(BuildContext context, String title, String subTitle) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(child: _buildText(context, title, subTitle)),
          _buildMaskedImage(context)
        ],
      )
    );
  }

  Widget _buildMaskedImage(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16),
      height: 56,
      width: 56,
      color: Colors.blue,
    );
  }

  Widget _buildText(BuildContext context, String title, String subTitle) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 14,
            color: Colors.white,
            letterSpacing: 0.24,
          )),
          Container(
            margin: EdgeInsets.only(top: 4), 
            child: Text(subTitle, style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: Color.fromRGBO(255, 255, 255, 0.7),
              letterSpacing: 0.21
            ))
          )
        ],
      )
    );
  }
}