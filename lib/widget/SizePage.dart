import 'package:flutter/material.dart';
import 'package:flutter_app/widget/BasePage.dart';

class SizePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SizeState();
  }
}

class SizeState extends State<SizePage> {
  Widget redBox = DecoratedBox(
    decoration: BoxDecoration(color: Colors.red),
  );

  @override
  Widget build(BuildContext context) {
    return BasePage(
        "Size",
        Column(
          children: <Widget>[
            ///ConstrainedBox用于对子组件添加额外的约束
            ///有多重限制时，对于minWidth和minHeight来说，是取父子中相应数值较大的。实际上，只有这样才能保证父限制与子限制不冲突。
            ConstrainedBox(
              constraints: BoxConstraints(
                  minWidth: double.infinity, //宽度尽可能大
                  minHeight: 50.0 //最小高度为50像素
                  ),
              child: Container(height: 5.0, child: redBox),
            ),
            Padding(padding: EdgeInsets.only(top: 20),),

            ///SizedBox用于给子元素指定固定的宽
            SizedBox(width: 80.0, height: 80.0, child: redBox),
            //ConstrainedBox(
            //   constraints: BoxConstraints.tightFor(width: 80.0,height: 80.0),
            //   child: redBox,
            // )
            Padding(padding: EdgeInsets.only(top: 20),),

            ///UnconstrainedBox不会对子组件产生任何限制
            ///在"去除"多重限制的时候也许会有帮助
            ConstrainedBox(
                constraints: BoxConstraints(minWidth: 60.0, minHeight: 100.0),
                //父
                child: UnconstrainedBox(
                  //“去除”父级限制
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minWidth: 90.0, minHeight: 20.0), //子
                    child: redBox,
                  ),
                ))
          ],
        ));
  }
}
