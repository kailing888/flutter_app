import 'package:flutter/material.dart';
import 'package:flutter_app/widget/BasePage.dart';

class ClipPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ClipState();
  }
}

class ClipState extends State<ClipPage> {
  Widget avatar = Image.asset("images/profile_header.png", width: 60.0);

  @override
  Widget build(BuildContext context) {
    return BasePage(
        "Clip",
        Center(
          child: Column(
            children: <Widget>[
              avatar, ///不剪裁
              ClipOval(child: avatar), ///剪裁为圆形
              ClipRRect(
                ///剪裁为圆角矩形
                borderRadius: BorderRadius.circular(5.0),
                child: avatar,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    widthFactor: .5, ///宽度设为原来宽度一半，另一半会溢出
                    child: avatar,
                  ),
                  Text(
                    "你好世界",
                    style: TextStyle(color: Colors.green),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ClipRect(
                    ///将溢出部分剪裁
                    child: Align(
                      alignment: Alignment.topLeft,
                      widthFactor: .5, ///宽度设为原来宽度一半
                      child: avatar,
                    ),
                  ),
                  Text("你好世界", style: TextStyle(color: Colors.green))
                ],
              ),
              DecoratedBox(
                decoration: BoxDecoration(color: Colors.red),
                child: ClipRect(
                    clipper: MyClipper(), ///使用自定义的clipper
                    child: avatar),
              )
            ],
          ),
        ));
  }
}

///图片所占用的空间大小仍然是60×60（红色区域），这是因为剪裁是在layout完成后的绘制阶段进行的，所以不会影响组件的大小
class MyClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) => Rect.fromLTWH(10.0, 15.0, 40.0, 30.0);

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) => false;
}
//getClip()是用于获取剪裁区域的接口，由于图片大小是60×60，我们返回剪裁区域为Rect.fromLTWH(10.0, 15.0, 40.0, 30.0)，即图片中部40×30像素的范围。
// shouldReclip() 接口决定是否重新剪裁。如果在应用中，剪裁区域始终不会发生变化时应该返回false，这样就不会触发重新剪裁，避免不必要的性能开销。如果剪裁区域会发生变化（比如在对剪裁区域执行一个动画），那么变化后应该返回true来重新执行剪裁。
