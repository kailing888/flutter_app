
import 'package:flutter/material.dart';
import 'package:flutter_app/widget/BasePage.dart';

///通知（Notification）是Flutter中一个重要的机制，在widget树中，每一个节点都可以分发通知，通知会沿着当前节点向上传递，
//所有父节点都可以通过NotificationListener来监听通知。
//Flutter中将这种由子向父的传递通知的机制称为通知冒泡（Notification Bubbling）
///
//知冒泡和用户触摸事件冒泡是相似的，但有一点不同：通知冒泡可以中止，但用户触摸事件不行。
///
/// onNotification回调为通知处理回调，其函数签名如下：
//它的返回值类型为布尔值，当返回值为true时，阻止冒泡，其父级Widget将再也收不到该通知；当返回值为false 时继续向上冒泡通知。
//Notification有一个dispatch(context)方法，它是用于分发通知的
class NotificationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NotificationState();
  }
}

class NotificationState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
        "Notification",
        Column(
          children: <Widget>[
            Container(
              constraints: BoxConstraints(maxHeight: 150),
              child: NotificationListener(
                onNotification: (notification) {
                  switch (notification.runtimeType) {
                    case ScrollStartNotification:
                      print("开始滚动");
                      break;
                    case ScrollUpdateNotification:
                      print("正在滚动");
                      break;
                    case ScrollEndNotification:
                      print("滚动停止");
                      break;
                    case OverscrollNotification:
                      print("滚动到边界");
                      break;
                  }
                  return true;
                },
                child: ListView.builder(
                    itemCount: 100,
                    itemBuilder: (context, index) {
                      return ListTile(title: Text("$index"),);
                    }
                ),
              ),
            ),
            Container(
              constraints: BoxConstraints(maxHeight: 150),
              child: NotificationRoute(),
            ),
            Container(
              constraints: BoxConstraints(maxHeight: 150),
            ),
            Container(
              constraints: BoxConstraints(maxHeight: 150),
            ),
          ],
        ));
  }
}
///自定义通知
class NotificationRoute extends StatefulWidget {
  @override
  NotificationRouteState createState() {
    return new NotificationRouteState();
  }
}

class NotificationRouteState extends State<NotificationRoute> {
  String _msg="";
  @override
  Widget build(BuildContext context) {
    //监听通知
    return NotificationListener<MyNotification>(
      onNotification: (notification) {
        setState(() {
          _msg+=notification.msg+"  ";
        });
        return true;
      },
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
//          RaisedButton(
//           onPressed: () => MyNotification("Hi").dispatch(context),
//           child: Text("Send Notification"),
//          ),
            Builder(
              builder: (context) {
                return RaisedButton(
                  //按钮点击时分发通知
                  onPressed: () => MyNotification("Hi").dispatch(context),
                  child: Text("Send Notification"),
                );
              },
            ),
            Text(_msg)
          ],
        ),
      ),
    );
  }
}

class MyNotification extends Notification {
  MyNotification(this.msg);
  final String msg;
}

///通知冒泡原理
//dispatch(context)中调用了当前context的visitAncestorElements方法，该方法会从当前Element开始向上遍历父级元素；
// visitAncestorElements有一个遍历回调参数，在遍历过程中对遍历到的父级元素都会执行该回调。
// 遍历的终止条件是：已经遍历到根Element或某个遍历回调返回false。
