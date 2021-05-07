import 'package:flutter/material.dart';
import 'package:flutter_app/widget/BasePage.dart';

class TransitionAnimationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TransitionAnimationState();
  }
}

class TransitionAnimationState extends State<TransitionAnimationPage> {
  Color _decorationColor = Colors.blue;
  var duration = Duration(seconds: 1);


  @override
  Widget build(BuildContext context) {
    return BasePage(
        "Transition",
        Column(
          children: <Widget>[
            ///自定义动画过渡组件
            AnimatedDecoratedBox1(
              duration: duration,
              decoration: BoxDecoration(color: _decorationColor),
              child: FlatButton(
                onPressed: () {
                  setState(() {
                    _decorationColor = Colors.red;
                  });
                },
                child: Text(
                  "AnimatedDecoratedBox",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            AnimatedDecoratedBox(
              duration: Duration( milliseconds: 400),
              decoration: BoxDecoration(color: _decorationColor),
              child: Builder(builder: (context) {
                return FlatButton(
                  onPressed: () {
                    if (_decorationColor == Colors.red) {
                      ImplicitlyAnimatedWidgetState _state =
                      context.findAncestorStateOfType<ImplicitlyAnimatedWidgetState>();
                      // 通过controller来启动反向动画
                      _state.controller.reverse().then((e) {
                        // 经验证必须调用setState来触发rebuild，否则状态同步会有问题
                        setState(() {
                          _decorationColor = Colors.blue;
                        });
                      });
                    } else {
                      setState(() {
                        _decorationColor = Colors.red;
                      });
                    }
                  },
                  child: Text(
                    "AnimatedDecoratedBox toggle",
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }),
            ),
            AnimatedWidgetsTest()
          ],
        ));
  }
}

///Flutter提供了一个ImplicitlyAnimatedWidget抽象类
///只需要分别继承ImplicitlyAnimatedWidget和ImplicitlyAnimatedWidgetState类即可
class AnimatedDecoratedBox extends ImplicitlyAnimatedWidget {
  AnimatedDecoratedBox({
    Key key,
    @required this.decoration,
    this.child,
    Curve curve = Curves.linear, //动画曲线
    @required Duration duration, // 正向动画执行时长
  }) : super(
    key: key,
    curve: curve,
    duration: duration,
  );
  final BoxDecoration decoration;
  final Widget child;

  @override
  _AnimatedDecoratedBoxState createState() {
    return _AnimatedDecoratedBoxState();
  }
}
class _AnimatedDecoratedBoxState
    extends AnimatedWidgetBaseState<AnimatedDecoratedBox> {
  DecorationTween _decoration; //定义一个Tween

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: _decoration.evaluate(animation),
      child: widget.child,
    );
  }

  @override
  void forEachTween(visitor) {
    // 在需要更新Tween时，基类会调用此方法
    _decoration = visitor(_decoration, widget.decoration,
            (value) => DecorationTween(begin: value));
  }
}

///组件名	功能
// AnimatedPadding	在padding发生变化时会执行过渡动画到新状态
// AnimatedPositioned	配合Stack一起使用，当定位状态发生变化时会执行过渡动画到新的状态。
// AnimatedOpacity	在透明度opacity发生变化时执行过渡动画到新状态
// AnimatedAlign	当alignment发生变化时会执行过渡动画到新的状态。
// AnimatedContainer	当Container属性发生变化时会执行过渡动画到新的状态。
// AnimatedDefaultTextStyle	当字体样式发生变化时，子组件中继承了该样式的文本组件会动态过渡到新样式。


///自定义动画过渡组件
class AnimatedDecoratedBox1 extends StatefulWidget {
  AnimatedDecoratedBox1({
    Key key,
    @required this.decoration,
    this.child,
    this.curve = Curves.linear,
    @required this.duration,
    this.reverseDuration,
  });

  final BoxDecoration decoration;
  final Widget child;
  final Duration duration;
  final Curve curve;
  final Duration reverseDuration;

  @override
  _AnimatedDecoratedBox1State createState() => _AnimatedDecoratedBox1State();
}

class _AnimatedDecoratedBox1State extends State<AnimatedDecoratedBox1>
    with SingleTickerProviderStateMixin {
  @protected
  AnimationController get controller => _controller;
  AnimationController _controller;

  Animation<double> get animation => _animation;
  Animation<double> _animation;

  DecorationTween _tween;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return DecoratedBox(
          decoration: _tween.animate(_animation).value,
          child: child,
        );
      },
      child: widget.child,
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      reverseDuration: widget.reverseDuration,
      vsync: this,
    );
    _tween = DecorationTween(begin: widget.decoration);
    _updateCurve();
  }

  void _updateCurve() {
    if (widget.curve != null)
      _animation = CurvedAnimation(parent: _controller, curve: widget.curve);
    else
      _animation = _controller;
  }

  @override
  void didUpdateWidget(AnimatedDecoratedBox1 oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.curve != oldWidget.curve) _updateCurve();
    _controller.duration = widget.duration;
    _controller.reverseDuration = widget.reverseDuration;
    if (widget.decoration != (_tween.end ?? _tween.begin)) {
      _tween
        ..begin = _tween.evaluate(_animation)
        ..end = widget.decoration;
      _controller
        ..value = 0.0
        ..forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}



class AnimatedWidgetsTest extends StatefulWidget {
  @override
  _AnimatedWidgetsTestState createState() => _AnimatedWidgetsTestState();
}

class _AnimatedWidgetsTestState extends State<AnimatedWidgetsTest> {
  double _padding = 10;
  var _align = Alignment.topRight;
  double _height = 100;
  double _left = 0;
  Color _color = Colors.red;
  TextStyle _style = TextStyle(color: Colors.black);
  Color _decorationColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    var duration = Duration(seconds: 5);
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              setState(() {
                _padding = 20;
              });
            },
            child: AnimatedPadding(
              duration: duration,
              padding: EdgeInsets.all(_padding),
              child: Text("AnimatedPadding"),
            ),
          ),
          SizedBox(
            height: 50,
            child: Stack(
              children: <Widget>[
                AnimatedPositioned(
                  duration: duration,
                  left: _left,
                  child: RaisedButton(
                    onPressed: () {
                      setState(() {
                        _left = 100;
                      });
                    },
                    child: Text("AnimatedPositioned"),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 100,
            color: Colors.grey,
            child: AnimatedAlign(
              duration: duration,
              alignment: _align,
              child: RaisedButton(
                onPressed: () {
                  setState(() {
                    _align = Alignment.center;
                  });
                },
                child: Text("AnimatedAlign"),
              ),
            ),
          ),
          AnimatedContainer(
            duration: duration,
            height: _height,
            color: _color,
            child: FlatButton(
              onPressed: () {
                setState(() {
                  _height = 150;
                  _color = Colors.blue;
                });
              },
              child: Text(
                "AnimatedContainer",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          AnimatedDefaultTextStyle(
            child: GestureDetector(
              child: Text("hello world"),
              onTap: () {
                setState(() {
                  _style = TextStyle(
                    color: Colors.blue,
                    decorationStyle: TextDecorationStyle.solid,
                    decorationColor: Colors.blue,
                  );
                });
              },
            ),
            style: _style,
            duration: duration,
          ),
          AnimatedDecoratedBox(
            duration: duration,
            decoration: BoxDecoration(color: _decorationColor),
            child: FlatButton(
              onPressed: () {
                setState(() {
                  _decorationColor = Colors.red;
                });
              },
              child: Text(
                "AnimatedDecoratedBox",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ].map((e) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: e,
          );
        }).toList(),
      ),
    );
  }
}