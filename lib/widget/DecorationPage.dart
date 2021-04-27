import 'package:flutter/material.dart';
import 'package:flutter_app/widget/BasePage.dart';

class DecorationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DecorationState();
  }
}

//BoxDecoration({
//   Color color, //颜色
//   DecorationImage image,//图片
//   BoxBorder border, //边框
//   BorderRadiusGeometry borderRadius, //圆角
//   List<BoxShadow> boxShadow, //阴影,可以指定多个
//   Gradient gradient, //渐变
//   BlendMode backgroundBlendMode, //背景混合模式
//   BoxShape shape = BoxShape.rectangle, //形状
// })
class DecorationState extends State<DecorationPage> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
        "DecorationState",
        DecoratedBox(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.red, Colors.orange[700]]), //背景渐变
                borderRadius: BorderRadius.circular(3.0), //3像素圆角
                boxShadow: [
                  //阴影
                  BoxShadow(
                      color: Colors.black54,
                      offset: Offset(2.0, 2.0),
                      blurRadius: 4.0)
                ]),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 18.0),
              child: Text(
                "Login",
                style: TextStyle(color: Colors.white),
              ),
            )));
  }
}
