import 'package:flutter/material.dart';

class NoOpacityMaterialPageRoute extends MaterialPageRoute {
  
  NoOpacityMaterialPageRoute({
    @required WidgetBuilder builder,
    RouteSettings settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
  }) : super(builder: builder, settings: settings, maintainState: maintainState, fullscreenDialog: fullscreenDialog);
  
  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    //if (settings.isInitialRoute)
      return child;
    
    //return FadeTransition(opacity: Tween<double>(begin: 0, end: 1).animate(animation), child: child,);
  }
}