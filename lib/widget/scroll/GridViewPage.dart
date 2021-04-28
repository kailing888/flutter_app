import 'package:flutter/material.dart';
import 'package:flutter_app/widget/BasePage.dart';

class GridViewPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GridViewState();
  }
}

class GridViewState extends State<GridViewPage> {
  List<IconData> _icons = []; //保存Icon数据

  @override
  void initState() {
    super.initState();
    _retrieveIcons();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
        "GridView",
        Column(
          children: <Widget>[
            Container(
              constraints: BoxConstraints(maxHeight: 100),

              ///子元素的大小是通过crossAxisCount和childAspectRatio两个参数共同决定的
              //crossAxisCount：横轴子元素的数量。此属性值确定后子元素在横轴的长度就确定了，即ViewPort横轴长度除以crossAxisCount的商。
              // mainAxisSpacing：主轴方向的间距。
              // crossAxisSpacing：横轴方向子元素的间距。
              // childAspectRatio：子元素在横轴长度和主轴长度的比例。由于crossAxisCount指定后，子元素横轴长度就确定了，然后通过此参数值就可以确定子元素在主轴的长度
              child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, //横轴三个子widget
                      childAspectRatio: 1.0 //宽高比为1时，子widget
                      ),
                  children: <Widget>[
                    Icon(Icons.ac_unit),
                    Icon(Icons.airport_shuttle),
                    Icon(Icons.all_inclusive),
                    Icon(Icons.beach_access),
                    Icon(Icons.cake),
                    Icon(Icons.free_breakfast)
                  ]),
            ),
            Container(
              height: 2,
              color: Colors.red,
            ),
            Container(
              constraints: BoxConstraints(maxHeight: 100),

              ///GridView.count构造函数内部使用了SliverGridDelegateWithFixedCrossAxisCount，我们通过它可以快速的创建横轴固定数量子元素的GridView
              child: GridView.count(
                crossAxisCount: 3,
                childAspectRatio: 1.0,
                children: <Widget>[
                  Icon(Icons.ac_unit),
                  Icon(Icons.airport_shuttle),
                  Icon(Icons.all_inclusive),
                  Icon(Icons.beach_access),
                  Icon(Icons.cake),
                  Icon(Icons.free_breakfast),
                ],
              ),
            ),
            Container(
              height: 2,
              color: Colors.red,
            ),
            Container(
              constraints: BoxConstraints(maxHeight: 100),

              ///一个横轴子元素为固定最大长度的layout算法,通过长度分列
              child: GridView(
                padding: EdgeInsets.zero,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 120.0, childAspectRatio: 2.0 //宽高比为2
                    ),
                children: <Widget>[
                  Icon(Icons.ac_unit),
                  Icon(Icons.airport_shuttle),
                  Icon(Icons.all_inclusive),
                  Icon(Icons.beach_access),
                  Icon(Icons.cake),
                  Icon(Icons.free_breakfast),
                ],
              ),
            ),
            Container(
              height: 2,
              color: Colors.red,
            ),
            Container(
              constraints: BoxConstraints(maxHeight: 100),
              child: GridView.extent(
                maxCrossAxisExtent: 230.0,
                childAspectRatio: 2.0,
                children: <Widget>[
                  Icon(Icons.ac_unit),
                  Icon(Icons.airport_shuttle),
                  Icon(Icons.all_inclusive),
                  Icon(Icons.beach_access),
                  Icon(Icons.cake),
                  Icon(Icons.free_breakfast),
                ],
              ),
            ),
            Container(
              height: 2,
              color: Colors.red,
            ),
            Expanded(
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, //每行三列
                      childAspectRatio: 1.0 //显示区域宽高相等
                      ),
                  itemCount: _icons.length,
                  itemBuilder: (context, index) {
                    //如果显示到最后一个并且Icon总数小于200时继续获取数据
                    if (index == _icons.length - 1 && _icons.length < 200) {
                      _retrieveIcons();
                    }
                    return Icon(_icons[index]);
                  }),
            ),
          ],
        ));
  }

  //模拟异步获取数据
  void _retrieveIcons() {
    Future.delayed(Duration(milliseconds: 200)).then((e) {
      setState(() {
        _icons.addAll([
          Icons.ac_unit,
          Icons.airport_shuttle,
          Icons.all_inclusive,
          Icons.beach_access,
          Icons.cake,
          Icons.free_breakfast
        ]);
      });
    });
  }
}
