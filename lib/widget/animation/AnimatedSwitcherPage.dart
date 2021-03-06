import 'package:flutter/material.dart';
import 'package:flutter_app/widget/BasePage.dart';

class AnimatedSwitcherPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AnimatedSwitcherState();
  }
}

class AnimatedSwitcherState extends State<AnimatedSwitcherPage> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
        "AnimatedSwitcher",
        Column(
          children: <Widget>[
            AnimatedSwitcherCounterRoute(),
          ],
        ));
  }
}

///  @required this.duration, // 新child显示动画时长
//   this.reverseDuration,// 旧child隐藏的动画时长
//   this.switchInCurve = Curves.linear, // 新child显示的动画曲线
//   this.switchOutCurve = Curves.linear,// 旧child隐藏的动画曲线
//   this.transitionBuilder = AnimatedSwitcher.defaultTransitionBuilder, // 动画构建器
//   this.layoutBuilder = AnimatedSwitcher.defaultLayoutBuilder, //布局构建器

///当AnimatedSwitcher的child发生变化时（类型或Key不同），旧child会执行隐藏动画，新child会执行执行显示动画
///该builder在AnimatedSwitcher的child切换时会分别对新、旧child绑定动画：
// 对旧child，绑定的动画会反向执行（reverse）
// 对新child，绑定的动画会正向指向（forward）

class AnimatedSwitcherCounterRoute extends StatefulWidget {
  const AnimatedSwitcherCounterRoute({Key key}) : super(key: key);

  @override
  _AnimatedSwitcherCounterRouteState createState() =>
      _AnimatedSwitcherCounterRouteState();
}

class _AnimatedSwitcherCounterRouteState
    extends State<AnimatedSwitcherCounterRoute> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (Widget child, Animation<double> animation) {
              //执行缩放动画
              return ScaleTransition(child: child, scale: animation);
            },
            child: Text(
              '$_count',
              //显示指定key，不同的key会被认为是不同的Text，这样才能执行动画
              key: ValueKey<int>(_count),
              style: Theme
                  .of(context)
                  .textTheme
                  .headline4,
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 50),),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (Widget child, Animation<double> animation) {
              //执行缩放动画
              return SlideTransitionX(
                child: child,
                direction: AxisDirection.down, //上入下出
                position: animation,
              );
            },
            child: Text(
              '$_count',
              //显示指定key，不同的key会被认为是不同的Text，这样才能执行动画
              key: ValueKey<int>(_count),
              style: Theme
                  .of(context)
                  .textTheme
                  .headline4,
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 50),),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (Widget child, Animation<double> animation) {
              var tween = Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0));
              return MySlideTransition(
                child: child,
                position: tween.animate(animation),
              );
            },
            child: Text(
              '$_count',
              //显示指定key，不同的key会被认为是不同的Text，这样才能执行动画
              key: ValueKey<int>(_count),
              style: Theme
                  .of(context)
                  .textTheme
                  .headline4,
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 50),),
          RaisedButton(
            child: const Text(
              '+1',
            ),
            onPressed: () {
              setState(() {
                _count += 1;
              });
            },
          ),
        ],
      ),
    );
  }
}

///具体做法是在didUpdateWidget 回调中判断其新旧child是否发生变化，如果发生变化，
///则对旧child执行反向退场（reverse）动画，对新child执行正向（forward）入场动画即可。

///因为同一个Animation正向（forward）和反向（reverse）是对称的。所以如果我们可以打破这种对称性
class MySlideTransition extends AnimatedWidget {
  MySlideTransition({
    Key key,
    @required Animation<Offset> position,
    this.transformHitTests = true,
    this.child,
  })
      : assert(position != null),
        super(key: key, listenable: position);

  Animation<Offset> get position => listenable;
  final bool transformHitTests;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    Offset offset = position.value;
    //动画反向执行时，调整x偏移，实现“从左边滑出隐藏”
    if (position.status == AnimationStatus.reverse) {
      offset = Offset(-offset.dx, offset.dy);
    }
    return FractionalTranslation(
      translation: offset,
      transformHitTests: transformHitTests,
      child: child,
    );
  }
}

///出入滑动动画
class SlideTransitionX extends AnimatedWidget {
  SlideTransitionX({
    Key key,
    @required Animation<double> position,
    this.transformHitTests = true,
    this.direction = AxisDirection.down,
    this.child,
  })
      : assert(position != null),
        super(key: key, listenable: position) {
    // 偏移在内部处理
    switch (direction) {
      case AxisDirection.up:
        _tween = Tween(begin: Offset(0, 1), end: Offset(0, 0));
        break;
      case AxisDirection.right:
        _tween = Tween(begin: Offset(-1, 0), end: Offset(0, 0));
        break;
      case AxisDirection.down:
        _tween = Tween(begin: Offset(0, -1), end: Offset(0, 0));
        break;
      case AxisDirection.left:
        _tween = Tween(begin: Offset(1, 0), end: Offset(0, 0));
        break;
    }
  }

  Animation<double> get position => listenable;

  final bool transformHitTests;

  final Widget child;

  //退场（出）方向
  final AxisDirection direction;

  Tween<Offset> _tween;

  @override
  Widget build(BuildContext context) {
    Offset offset = _tween.evaluate(position);
    if (position.status == AnimationStatus.reverse) {
      switch (direction) {
        case AxisDirection.up:
          offset = Offset(offset.dx, -offset.dy);
          break;
        case AxisDirection.right:
          offset = Offset(-offset.dx, offset.dy);
          break;
        case AxisDirection.down:
          offset = Offset(offset.dx, -offset.dy);
          break;
        case AxisDirection.left:
          offset = Offset(-offset.dx, offset.dy);
          break;
      }
    }
    return FractionalTranslation(
      translation: offset,
      transformHitTests: transformHitTests,
      child: child,
    );
  }
}
