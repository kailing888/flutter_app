import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/widget/BasePage.dart';

class PointerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PointerState();
  }
}

class PointerState extends State<PointerPage> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
        "Pointer",
        Column(
          children: <Widget>[
            TestListener(
              "Widget1 ",
              Container(
                height: 300,
                width: 300,
                color: Colors.green,
                alignment: Alignment.topLeft,
                child: TestListener(
                    "Widget2",
                    Container(
                      height: 200,
                      width: 200,
                      color: Colors.red,
                      alignment: Alignment.topLeft,
                      child: TestListener(
                          "Widget3",
                          Container(
                            color: Colors.yellow,
                            height: 100,
                            width: 100,
                          )),
                    )),
              ),
            ),
            ///IgnorePointer
            Listener(
              child: AbsorbPointer(
                child: Listener(
                  child: Container(
                    color: Colors.red,
                    width: 200.0,
                    height: 100.0,
                  ),
                  onPointerDown: (event) => print("in"),
                ),
              ),
              onPointerDown: (event) => print("up"),
            )
          ],
        ));
  }
}

class TestListener extends Listener {
  final String tag;
  final Widget _child;

  TestListener(this.tag, this._child)
      : super(
            child: _child,
            onPointerDown: (PointerDownEvent event) {
              print(tag + ": Down----" + event.toString());
            },
            onPointerMove: (PointerMoveEvent event) {
              print(tag + ": Move====" + event.toString());
            },
            onPointerUp: (PointerUpEvent event) {
              print(tag + ": Up----" + event.toString());
            },
            onPointerCancel: (PointerCancelEvent event) {
              print(tag + ": Cancel----" + event.toString());
            },
            behavior: HitTestBehavior.deferToChild);
}

///???????????????????????????PointerEvent???????????????????????????IgnorePointer???AbsorbPointer?????????????????????????????????????????????????????????
///??????????????????AbsorbPointer?????????????????????????????????IgnorePointer?????????????????????
///???????????????AbsorbPointer????????????????????????????????????(??????????????????)??????IgnorePointer????????????
