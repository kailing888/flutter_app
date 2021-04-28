
import 'package:flutter/material.dart';
import 'package:flutter_app/widget/BasePage.dart';

class NotificationListenerPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return NotificationListenerState();
  }
}

class NotificationListenerState extends State<NotificationListenerPage>{
  String _progress = "0%"; //保存进度百分比
  @override
  Widget build(BuildContext context) {
   return BasePage("NotificationListener",Scrollbar( //进度条
     // 监听滚动通知
     child: NotificationListener<ScrollNotification>(
       onNotification: (ScrollNotification notification) {
         double progress = notification.metrics.pixels /
             notification.metrics.maxScrollExtent;
         //重新构建
         setState(() {
           _progress = "${(progress * 100).toInt()}%";
         });
         print("BottomEdge: ${notification.metrics.extentAfter == 0}");
         return true;
       },
       child: Stack(
         alignment: Alignment.center,
         children: <Widget>[
           ListView.builder(
               itemCount: 100,
               itemExtent: 50.0,
               itemBuilder: (context, index) {
                 return ListTile(title: Text("$index"));
               }
           ),
           CircleAvatar(  //显示进度百分比
             radius: 30.0,
             child: Text(_progress),
             backgroundColor: Colors.black54,
           )
         ],
       ),
     ),
   ));
  }
}
///在接收到滚动事件时，参数类型为ScrollNotification，它包括一个metrics属性，它的类型是ScrollMetrics，
//该属性包含当前ViewPort及滚动位置等信息：
// pixels：当前滚动位置。
// maxScrollExtent：最大可滚动长度。
// extentBefore：滑出ViewPort顶部的长度；此示例中相当于顶部滑出屏幕上方的列表长度。
// extentInside：ViewPort内部长度；此示例中屏幕显示的列表部分的长度。
// extentAfter：列表中未滑入ViewPort部分的长度；此示例中列表底部未显示到屏幕范围部分的长度。
// atEdge：是否滑到了可滚动组件的边界（此示例中相当于列表顶或底部）。


///可滚动组件在滚动时会发送ScrollNotification类型的通知，
///ScrollBar正是通过监听滚动通知来实现的。
///通过NotificationListener监听滚动事件和通过ScrollController有两个主要的不同：
// 通过NotificationListener可以在从可滚动组件到widget树根之间任意位置都能监听。而ScrollController只能和具体的可滚动组件关联后才可以。
// 收到滚动事件后获得的信息不同；NotificationListener在收到滚动事件时，通知中会携带当前滚动位置和ViewPort的一些信息，而ScrollController只能获取当前滚动位置。