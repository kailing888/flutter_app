import 'package:flutter/material.dart';
import 'package:flutter_app/widget/BasePage.dart';

class AnimationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AnimationState();
  }
}

class AnimationState extends State<AnimationPage> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
        "Animation",
        Column(
          children: <Widget>[
            Container(
              constraints: BoxConstraints(maxHeight: 150),
              ///原始
              child: ScaleAnimationRoute(),
            ),
            Container(
              constraints: BoxConstraints(maxHeight: 150),
              ///AnimatedBuilder
              child: ScaleAnimationRoute1(),
            ),
            Container(
              constraints: BoxConstraints(maxHeight: 150),
            ),
          ],
        ));
  }
}

///AnimatedWidget类封装了调用setState()的细节，并允许我们将widget分离出来
//用AnimatedWidget可以从动画中分离出widget


class GrowTransition extends StatelessWidget {
  GrowTransition({this.child, this.animation});

  final Widget child;
  final Animation<double> animation;

  Widget build(BuildContext context) {
    return new Center(
      child: new AnimatedBuilder(
          animation: animation,
          builder: (BuildContext context, Widget child) {
            return new Container(
                height: animation.value,
                width: animation.value,
                child: child
            );
          },
          child: child
      ),
    );
  }
}
///dismissed	动画在起始点停止
// forward	动画正在正向执行
// reverse	动画正在反向执行
// completed	动画在终点停止

class ScaleAnimationRoute1 extends StatefulWidget {
  @override
  _ScaleAnimationRouteState1 createState() => new _ScaleAnimationRouteState1();
}

class _ScaleAnimationRouteState1 extends State<ScaleAnimationRoute1>
    with SingleTickerProviderStateMixin {

  Animation<double> animation;
  AnimationController controller;

  initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(seconds: 3), vsync: this);
    //图片宽高从0变到300
    animation = new Tween(begin: 0.0, end: 300.0).animate(controller);
    ///动画状态监听
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        //动画执行结束时反向执行动画
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        //动画恢复到初始状态时执行动画（正向）
        controller.forward();
      }
    });
    //启动动画
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return GrowTransition(
      child: Image.asset("images/profile_header.png"),
      animation: animation,
    );  }

  dispose() {
    //路由销毁时需要释放动画资源
    controller.dispose();
    super.dispose();
  }
}

///addListener()函数调用了setState()，所以每次动画生成一个新的数字时，当前帧被标记为脏(dirty)，
///这会导致widget的build()方法再次被调用，而在build()中，改变Image的宽高，
///因为它的高度和宽度现在使用的是animation.value ，所以就会逐渐放大。
///值得注意的是动画完成时要释放控制器(调用dispose()方法)以防止内存泄漏。
class ScaleAnimationRoute extends StatefulWidget {
  @override
  _ScaleAnimationRouteState createState() => new _ScaleAnimationRouteState();
}

//需要继承TickerProvider，如果有多个AnimationController，则应该使用TickerProviderStateMixin。
class _ScaleAnimationRouteState extends State<ScaleAnimationRoute>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(seconds: 3), vsync: this);
    //使用弹性曲线
    animation = CurvedAnimation(parent: controller, curve: Curves.bounceIn);
    //图片宽高从0变到300
    animation = new Tween(begin: 0.0, end: 300.0).animate(controller)
      ..addListener(() {
        setState(() => {});
      });
    //启动动画(正向执行)
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: Image.asset("images/profile_header.png",
          width: animation.value, height: animation.value),
    );
  }

  dispose() {
    //路由销毁时需要释放动画资源
    controller.dispose();
    super.dispose();
  }
}
