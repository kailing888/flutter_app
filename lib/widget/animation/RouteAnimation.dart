import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/widget/animation/RouteB.dart';

import '../BasePage.dart';

class RouteAnimationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RouteAnimationState();
  }
}

class RouteAnimationState extends State<RouteAnimationPage> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
        "RouteB",
        Column(
          children: <Widget>[
            RaisedButton(
              child: Text("CupertinoPageRoute"),
              onPressed: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => RouteB(),
                    ));
              },
            ),

            ///PageRouteBuilder来自定义路由切换动画
            RaisedButton(
              child: Text("PageRouteBuilder"),
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: Duration(milliseconds: 500),
                    //动画时间为500毫秒
                    pageBuilder: (BuildContext context, Animation animation,
                        Animation secondaryAnimation) {
                      return new FadeTransition(
                        //使用渐隐渐入过渡,
                        opacity: animation,
                        child: RouteB(), //路由B
                      );
                    },
                  ),
                );
              },
            ),
            RaisedButton(
              child: Text("PageRoute"),
              onPressed: () {
                Navigator.push(context, FadeRoute(builder: (context) {
                  return RouteB();
                }));
              },
            ),
          ],
        ));
  }
}

///看到pageBuilder 有一个animation参数，这是Flutter路由管理器提供的，
///在路由切换时pageBuilder在每个动画帧都会被回调，因此我们可以通过animation对象来自定义过渡动画。

///无论是MaterialPageRoute、CupertinoPageRoute，还是PageRouteBuilder，它们都继承自PageRoute类，
///而PageRouteBuilder其实只是PageRoute的一个包装
class FadeRoute extends PageRoute {
  FadeRoute({
    @required this.builder,
    this.transitionDuration = const Duration(milliseconds: 300),
    this.opaque = true,
    this.barrierDismissible = false,
    this.barrierColor,
    this.barrierLabel,
    this.maintainState = true,
  });

  final WidgetBuilder builder;

  @override
  final Duration transitionDuration;

  @override
  final bool opaque;

  @override
  final bool barrierDismissible;

  @override
  final Color barrierColor;

  @override
  final String barrierLabel;

  @override
  final bool maintainState;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) =>
      builder(context);

  ///只想在打开新路由时应用动画，而在返回时不使用动画
  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    //当前路由被激活，是打开新路由
    if (isActive) {
      return FadeTransition(
        opacity: animation,
        child: builder(context),
      );
    } else {
      //是返回，则不应用过渡动画
      return Padding(padding: EdgeInsets.zero);
    }
  }
}
