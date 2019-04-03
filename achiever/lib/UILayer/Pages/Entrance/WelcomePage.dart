import 'package:flutter/material.dart';
import 'package:achiever/UILayer/UIKit/Buttons/AchieverButton.dart';

class WelcomePage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        constraints: BoxConstraints.tightForFinite(),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 0, 202, 255),
              Color.fromARGB(255, 0, 142, 255)
            ]
          )
        ),
        child: Center(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _buildTopPart(context),
            _buildBottomPart(context)
          ],
        ),
      ),
      )
    );
  }

  Widget _buildTopPart(BuildContext context) {
    final logoBox = Container(
      width: 140,
      height: 140,
      //color: Colors.red,
      child: Container(
        margin: EdgeInsets.only(top: 5, bottom: 5),
        child: Image.asset('assets/achiever_logo.png', height: 130, width: 140,),
      ),
    );

    final titleBox = Center(
      child :Container(
      //decoration: BoxDecoration(border: Border.all(color: Colors.red, width: 1)),
      margin: EdgeInsets.only(top: 8.5),
      child: Text('Achiever', style: TextStyle(
        //textBaseline: TextBaseline.alphabetic,
        fontSize: 34,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        letterSpacing: 0.41,
        height: 41.0 / 34
      ),),
      )
    );

    final descBox = Container(
      //margin: EdgeInsets.only(top: 4),
      child: Text('Сделай больше. Сделай лучше.', style: TextStyle(
        fontSize: 17,
        //letterSpacing: -0.41,
        color: Color.fromRGBO(255, 255, 255, 0.7),
        height: 22.0 / 17
      ), textAlign: TextAlign.justify,),
    );

    return Container(
      margin: EdgeInsets.only(top: 158),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          logoBox,
          titleBox,
          descBox
        ],
      ),
    );
  }

  Widget _buildBottomPart(BuildContext context) {
    final button = GestureDetector(
      child: Container(
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(28)),
            color: Colors.white
          ),
          height: 56,
          child: Center(
            widthFactor: 1.0,
            child: Container(
              padding: EdgeInsets.only(left: 36, right: 36),
              child: Text('Зарегистрироваться', style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.20,
                color: Color.fromARGB(255, 51, 51, 51)
              ),),
            )
          ),
        ),
      ),
      onTap: () => Navigator.of(context).pushNamed('/signup'),
    );

    final loginTextAndButton = Container(
      margin: EdgeInsets.only(top: 12),
      //decoration: BoxDecoration(border: Border.all(color: Colors.red, width: 1)),
      child: GestureDetector(
        child: Container(
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Уже есть аккаунт?', style: TextStyle(
                fontSize: 12,
                //letterSpacing: 0,
                color: Color.fromRGBO(255, 255, 255, 0.5)
              ),),
              Text(' Войти', style: TextStyle(
                fontSize: 12,
                //letterSpacing: 0,
                color: Colors.white
              ),)
            ],
          ),
        ),
        onTap: () => Navigator.of(context).pushNamed('/login'),
      )
    );

    return Container(
      margin: EdgeInsets.only(bottom: 60),
      child: Column(
        children: <Widget>[
          button,
          loginTextAndButton
        ],
      ),
    );
  }
}