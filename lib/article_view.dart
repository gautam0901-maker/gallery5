import 'dart:async';

import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';
class ArticleView extends StatefulWidget {
  final String blogUrl;
  ArticleView({this.blogUrl});
  @override
  _ArticleViewState createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  final Completer<WebViewController > _completer = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width ,
        child: WebView(
          initialUrl: widget.blogUrl ,
          onWebViewCreated: ((WebViewController webViewController ){
            _completer.complete(webViewController);
          }),
        ),
      ),
    );
  }
}
