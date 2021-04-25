import 'package:flutter/material.dart';
import 'package:flutter_app/widget/BasePage.dart';

class AlignPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AlignState();
  }
}

class AlignState extends State<AlignPage> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
        "Align",
        Column(
          children: <Widget>[
            Align(
              widthFactor: 2,
              heightFactor: 2,
              alignment: Alignment.topRight,
              child: FlutterLogo(
                size: 60,
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(color: Colors.red),
              child: Center(
                child: Text("xxx"),
              ),
            ),
          ],
        ));
  }
}
//widthFactor和heightFactor是用于确定Align 组件本身宽高的属性；它们是两个缩放因子，会分别乘以子元素的宽、高，最终的结果就是Align 组件的宽高。如果值为null，则组件的宽高将会占用尽可能多的空间。
//定位参考系统不同；Stack/Positioned定位的的参考系可以是父容器矩形的四个顶点；而Align则需要先通过alignment 参数来确定坐标原点，不同的alignment会对应不同原点，最终的偏移是需要通过alignment的转换公式来计算出。
// Stack可以有多个子元素，并且子元素可以堆叠，而Align只能有一个子元素，不存在堆叠。
