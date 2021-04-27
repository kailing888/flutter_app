import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/widget/BasePage.dart';

class ScrollBarPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ScrollBarState();
  }
}

class ScrollBarState extends State<ScrollBarPage> {
  double _alignmentY = 0;
  @override
  Widget build(BuildContext context) {
    print('build _alignmentY:$_alignmentY');
    return BasePage(
        "ScrollBar",
        Container(
          constraints: BoxConstraints(
            maxHeight: 400,
          ),
          child: NotificationListener<ScrollNotification>(
            onNotification: _handleScrollNotification,
            child: Stack(
              children: <Widget>[
                ListView.builder(
                  reverse: false,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: Container(
                        height: 45,
                        alignment: Alignment.center,
                        child: Text('$index'),
                      ),
                    );
                  },
                  itemCount: 30,
                  itemExtent: 50,
                ),
                //滚动条
                Container(
                  alignment: Alignment(1, _alignmentY),
                  padding: EdgeInsets.only(right: 5),
                  child: Container(
                    height: 100,
                    width: 20,
                    color: Colors.red,
                  ),
                )
              ],
            ),
          ),
        )
    );
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    final ScrollMetrics metrics = notification.metrics;
    print('滚动组件最大滚动距离:${metrics.maxScrollExtent}');
    print('当前滚动位置:${metrics.pixels}');
    if(mounted){
      setState(() {
        _alignmentY = -1 + (metrics.pixels / metrics.maxScrollExtent) * 2;
        print('_alignmentY:$_alignmentY');
      });
    }

    return true;
  }
}
