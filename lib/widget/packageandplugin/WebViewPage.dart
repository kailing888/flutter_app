
import 'package:flutter/material.dart';
import 'package:flutter_app/widget/BasePage.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return WebViewState();
  }

}

class WebViewState extends State<WebViewPage>{
  @override
  Widget build(BuildContext context) {
   return BasePage("WebView",PlatformViewRoute());
  }

}

class PlatformViewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: "https://flutterchina.club",
      javascriptMode: JavascriptMode.unrestricted,
    );
  }
}