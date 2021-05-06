import 'package:flutter/material.dart';
import 'package:flutter_app/widget/BasePage.dart';

import 'EventBus.dart';

class EventBusPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return EventBusState();
  }
}

class EventBusState extends State<EventBusPage> {
  //注意：Dart中实现单例模式的标准做法就是使用static变量+工厂构造函数的方式，
  // 这样就可以保证new EventBus()始终返回都是同一个实例，读者应该理解并掌握这种方法。

  String content = "原始";

  EventCallback _eventCallback;

  @override
  void initState() {
    super.initState();
    _eventCallback = (arg) {
      if (mounted) {
        setState(() {
          content = arg;
        });
      }
    };
    //监听登录事件
    bus.on("login", _eventCallback);
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
        "EventBus",
        Column(
          children: <Widget>[
            Text(content),
            FlatButton(
              child: Text("发送事件"),
              onPressed: () {
                //登录成功后触发登录事件，页面A中订阅者会被调用
                bus.emit("login", "userInfo");
              },
            )
          ],
        ));
  }

  @override
  void dispose() {
    super.dispose();
    bus.off("login", _eventCallback);
  }
}
