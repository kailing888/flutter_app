import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/widget/BasePage.dart';

class ButtonPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BasePage(
        'button',
        Column(
          children: <Widget>[
            RaisedButton(
              child: Text("RaisedButton"),
              onPressed: () {},
            ),
            FlatButton(
              child: Text("FlatButton"),
              onPressed: () {},
            ),
            OutlineButton(
              child: Text("OutlineButton"),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.thumb_up),
              onPressed: () {},
            ),
            FlatButton(
              color: Colors.blue,
              highlightColor: Colors.blue[700],
              colorBrightness: Brightness.dark,
              splashColor: Colors.grey,
              child: Text("Submit"),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              onPressed: () {},
            )
          ],
        ));
  }

// const FlatButton
//
// ({
// ...
// @required this.onPressed, //按钮点击回调
// this.textColor, //按钮文字颜色
// this.disabledTextColor, //按钮禁用时的文字颜色
// this.color, //按钮背景颜色
// this.disabledColor,//按钮禁用时的背景颜色
// this.highlightColor, //按钮按下时的背景颜色
// this.splashColor, //点击时，水波动画中水波的颜色
// this.colorBrightness,//按钮主题，默认是浅色主题
// this.padding, //按钮的填充
// this.shape, //外形
// @required this.child, //按钮的内容
// })
}
