import 'package:flutter/material.dart';

import 'dart:io' show Platform;

class NoOpacityMaterialPageRoute extends MaterialPageRoute {
  
  NoOpacityMaterialPageRoute({
    @required WidgetBuilder builder,
    RouteSettings settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
  }) : super(builder: builder, settings: settings, maintainState: maintainState, fullscreenDialog: fullscreenDialog);
  
  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return Container(
      color: Colors.white,
      child: super.buildPage(context, animation, secondaryAnimation),
    );
  }

  /*@override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    if (settings.isInitialRoute)
      return child;
    
    return Container(
      color: Colors.white,
      child: super.buildTransitions(context, animation, secondaryAnimation, child),
    );
  }*/

  /*
  @override
  Color get barrierColor => Colors.white;*/

  @override
  Duration get transitionDuration {
    //return super.transitionDuration;
    return Platform.isAndroid 
      ? const Duration(milliseconds: 16)
      : super.transitionDuration;
  }
}