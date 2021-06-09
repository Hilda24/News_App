import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatefulWidget {
  final String blogUrl;
  const ArticleView({ Key? key, required this.blogUrl }) : super(key: key);
  
  @override
  _ArticleViewState createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  final Completer<WebViewController> _completer = Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Dangfanq Lemon News", style: TextStyle(color: Colors.red),)
          ],
        ),
        //⬇⬇⬇⬇⬇⬇⬇⬇
        actions: [Opacity(
          opacity: 0,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Icon(Icons.sd_card_alert_rounded),
          ),
        )],
        //Useless
        elevation: 0.0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: WebView(
          initialUrl: widget.blogUrl,
          onWebViewCreated: ((WebViewController webViewController){
            _completer.complete(webViewController);
            // for ios add in info.plist
            // for android search -> minSDKversion change to 18
          }),
        ),
      ),
    );
  }
}