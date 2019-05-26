import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class PolicyBuilder {
  static Widget buildWebView(BuildContext context) {
    return WebviewScaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      url: 'https://www.notion.so/furycateur/deb541ab271a4e70bcabe86dc4140bc2',
    );
  }
}