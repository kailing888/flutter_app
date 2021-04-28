import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/widget/BasePage.dart';

class ListViewPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ListViewState();
  }
}

class ListViewState extends State<ListViewPage> {
  Widget divider1 = Divider(
    color: Colors.blue,
  );
  Widget divider2 = Divider(color: Colors.green);

  @override
  Widget build(BuildContext context) {
    return BasePage(
        "ListView",
        Column(
          children: <Widget>[
            Container(
              constraints: BoxConstraints(maxHeight: 200),

              ///ListView.builder适合列表项比较多（或者无限）的情况，因为只有当子组件真正显示的时候才会被创建
              //通过该构造函数创建的ListView是支持基于Sliver的懒加载模型的
              //itemBuilder：它是列表项的构建器，类型为IndexedWidgetBuilder，返回值为一个widget。当列表滚动到具体的index位置时，会调用该构建器构建列表项。
              //itemCount：列表项的数量，如果为null，则为无限列表。
              child: ListView.builder(
                  itemCount: 200,
                  itemExtent: 50.0, //强制高度为50.0
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(title: Text("$index"));
                  }),
            ),

            ///ListView.separated可以在生成的列表项之间添加一个分割组件
            Container(
              constraints: BoxConstraints(maxHeight: 200),
              child: ListView.separated(
                itemCount: 200,
                //列表项构造器
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(title: Text("$index"));
                },
                //分割器构造器
                separatorBuilder: (BuildContext context, int index) {
                  return index % 2 == 0 ? divider1 : divider2;
                },
              ),
            ),
            Expanded(
              ///添加固定列表头
              child: Column(children: <Widget>[
                ListTile(title: Text("商品列表")),
                Expanded(
                  child: ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                    return ListTile(title: Text("$index"));
                  }),
                ),
              ]),
            )
          ],
        ));
  }
}

///itemExtent：该参数如果不为null，则会强制children的“长度”为itemExtent的值；
//这里的“长度”是指滚动方向上子组件的长度，也就是说如果滚动方向是垂直方向，则itemExtent代表子组件的高度；
// 如果滚动方向为水平方向，则itemExtent就代表子组件的宽度。
///shrinkWrap：该属性表示是否根据子组件的总长度来设置ListView的长度，默认值为false 。
//默认情况下，ListView的会在滚动方向尽可能多的占用空间。当ListView在一个无边界(滚动方向上)的容器中时，shrinkWrap必须为true
///addAutomaticKeepAlives：该属性表示是否将列表项（子组件）包裹在AutomaticKeepAlive 组件中；
//典型地，在一个懒加载列表中，如果将列表项包裹在AutomaticKeepAlive中，在该列表项滑出视口时它也不会被GC（垃圾回收），它会使用KeepAliveNotification来保存其状态。
//如果列表项自己维护其KeepAlive状态，那么此参数必须置为false
///addRepaintBoundaries：该属性表示是否将列表项（子组件）包裹在RepaintBoundary组件中。
//当可滚动组件滚动时，将列表项包裹在RepaintBoundary中可以避免列表项重绘，但是当列表项重绘的开销非常小（如一个颜色块，或者一个较短的文本）时，不添加RepaintBoundary反而会更高效。
// 和addAutomaticKeepAlive一样，如果列表项自己维护其KeepAlive状态，那么此参数必须置为false

///默认构造函数有一个children参数，它接受一个Widget列表（List）。
//这种方式适合只有少量的子组件的情况，因为这种方式需要将所有children都提前创建好（这需要做大量工作），而不是等到子widget真正显示的时候再创建
