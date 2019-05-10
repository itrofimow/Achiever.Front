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
    if (settings.isInitialRoute)
      return child;
    
    return child;
    /*return SlideTransition(
      position: new Tween<Offset>(
        begin: const Offset(-1.0, 0.0),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );*/
  }

  @override
  Color get barrierColor => Colors.white;

  @override
  Duration get transitionDuration => const Duration();
}