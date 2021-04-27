import 'package:flutter/material.dart';
import 'package:flutter_app/widget/BasePage.dart';
import 'dart:math';

class TransformPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TransformState();
  }
}

class TransformState extends State<TransformPage> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
        "Transform",
        Column(
          children: <Widget>[
            ///Transform可以在其子组件绘制时对其应用一些矩阵变换来实现一些特效
            ///Transform的变换是应用在绘制阶段，而并不是应用在布局(layout)阶段
            ///其占用空间的大小和在屏幕上的位置都是固定不变的
            Container(
              color: Colors.black,
              child: new Transform(
                alignment: Alignment.topRight, //相对于坐标系原点的对齐方式
                transform: new Matrix4.skewY(0.3), //沿Y轴倾斜0.3弧度
                child: new Container(
                  padding: const EdgeInsets.all(8.0),
                  color: Colors.deepOrange,
                  child: const Text('Apartment for rent!'),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
            ),

            ///平移
            DecoratedBox(
              decoration: BoxDecoration(color: Colors.red),
              //默认原点为左上角，左移20像素，向上平移5像素
              child: Transform.translate(
                offset: Offset(-20.0, -5.0),
                child: Text("Hello world"),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
            ),

            ///旋转
            DecoratedBox(
              decoration: BoxDecoration(color: Colors.red),
              child: Transform.rotate(
                //旋转90度
                angle: 3.14 / 2,
                child: Text("Hello world"),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
            ),

            ///缩放
            DecoratedBox(
                decoration: BoxDecoration(color: Colors.red),
                child: Transform.scale(
                    scale: 1.5, //放大到1.5倍
                    child: Text("Hello world"))),
            Padding(
              padding: EdgeInsets.only(top: 20),
            ),

            ///RotatedBox的变换是在layout阶段
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                DecoratedBox(
                  decoration: BoxDecoration(color: Colors.red),
                  //将Transform.rotate换成RotatedBox
                  child: RotatedBox(
                    quarterTurns: 1, //旋转90度(1/4圈)
                    child: Text("Hello world"),
                  ),
                ),
                Text(
                  "你好",
                  style: TextStyle(color: Colors.green, fontSize: 18.0),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
            ),
          ],
        ));
  }
}
