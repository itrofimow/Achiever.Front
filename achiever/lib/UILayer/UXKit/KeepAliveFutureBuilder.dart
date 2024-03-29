import 'package:flutter/material.dart';
import 'package:achiever/AppContainer.dart';

class KeepAliveFutureBuilder extends StatefulWidget {
  final Future future;
  final AsyncWidgetBuilder builder;

  KeepAliveFutureBuilder({this.future, this.builder});

  @override
  _KeepAliveFutureBuilderState createState() => _KeepAliveFutureBuilderState();
}

class _KeepAliveFutureBuilderState extends State<KeepAliveFutureBuilder> 
  with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.future,//AppContainer.memoizer.runOnce(() async {return await widget.future;}),
      builder: widget.builder
    );
  }

  @override
  bool get wantKeepAlive => true;
}