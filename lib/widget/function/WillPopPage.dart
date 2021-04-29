import 'package:flutter/material.dart';
import 'package:flutter_app/widget/BasePage.dart';

class WillPopPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return WillPopState();
  }
}

class WillPopState extends State<WillPopPage> {

  DateTime _lastPressedAt;

  @override
  Widget build(BuildContext context) {
    return BasePage(
        "WillPopScope",
        new WillPopScope(
            onWillPop: () async {
              if (_lastPressedAt == null ||
                  DateTime.now().difference(_lastPressedAt) >
                      Duration(seconds: 1)) {
                //两次点击间隔超过1秒则重新计时
                _lastPressedAt = DateTime.now();
                return false;
              }
              return true;
            },
            child: Container(
              alignment: Alignment.center,
              child: Text("1秒内连续按两次返回键退出"),
            )));
  }
}
