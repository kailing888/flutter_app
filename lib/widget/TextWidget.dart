import 'package:flutter/material.dart';
import 'package:flutter_app/widget/BasePage.dart';

class TextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BasePage(
        'Text',
        Column(
          children: <Widget>[
            Text(
              "Hello world",
              textAlign: TextAlign.left,
            ),
            Text(
              "Hello world! I'm Jack. " * 4,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              "Hello world",
              textScaleFactor: 1.5,
            ),

            ///TextStyle用于指定文本显示的样式如颜色、字体、粗细、背景等
            Text(
              "Hello world",
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18.0,
                  height: 1.2,
                  fontFamily: "Courier",
                  background: new Paint()..color = Colors.yellow,
                  decoration: TextDecoration.underline,
                  decorationStyle: TextDecorationStyle.dashed),
            ),

            ///Text内容的不同部分按照不同的样式显示
            Text.rich(TextSpan(children: [
              TextSpan(text: "Home: "),
              TextSpan(
                text: "https://flutterchina.club",
                style: TextStyle(color: Colors.blue),
              ),
            ])),

            ///用于设置默认文本样式
            DefaultTextStyle(
              //1.设置文本默认样式
              style: TextStyle(
                color: Colors.red,
                fontSize: 20.0,
              ),
              textAlign: TextAlign.start,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("hello world"),
                  Text("I am Jack"),
                  Text(
                    "I am Jack",
                    style: TextStyle(
                        inherit: false, //2.不继承默认样式
                        color: Colors.grey),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
