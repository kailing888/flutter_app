import 'package:flutter/material.dart';
import 'package:flutter_app/widget/BasePage.dart';

class StatePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StateState();
  }
}

class StateState extends State<StatePage> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      "StateManager",
      Column(children: <Widget>[
        RaisedButton(
          child: Text("StatefulBuilder"),
          onPressed: () async {
            showDeleteConfirmDialog3();
          },
        ),
        RaisedButton(
          child: Text("markNeedsBuild"),
          onPressed: () async {
            showDeleteConfirmDialog4();
          },
        ),
      ],)
    );
  }


  Future<bool> showDeleteConfirmDialog4() {
    bool _withTree = false;
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("提示"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("您确定要删除当前文件吗?"),
              Row(
                children: <Widget>[
                  Text("同时删除子目录？"),
                  Checkbox( // 依然使用Checkbox组件
                    value: _withTree,
                    onChanged: (bool value) {
                      // 此时context为对话框UI的根Element，我们
                      // 直接将对话框UI对应的Element标记为dirty
                      (context as Element).markNeedsBuild();
                      _withTree = !_withTree;
                    },
                  ),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("取消"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            FlatButton(
              child: Text("删除"),
              onPressed: () {
                // 执行删除操作
                Navigator.of(context).pop(_withTree);
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool> showDeleteConfirmDialog3() {
    bool _withTree = false; //记录复选框是否选中
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("提示"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("同时删除子目录？"),
              //使用StatefulBuilder来构建StatefulWidget上下文
              StatefulBuilder(
                builder: (context, _setState) {
                  return Checkbox(
                    value: _withTree, //默认不选中
                    onChanged: (bool value) {
                      //_setState方法实际就是该StatefulWidget的setState方法，
                      //调用后builder方法会重新被调用
                      _setState(() {
                        //更新选中状态
                        _withTree = !_withTree;
                      });
                    },
                  );
                },
              ),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("取消"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            FlatButton(
              child: Text("删除"),
              onPressed: () {
                // 将选中状态返回
                Navigator.of(context).pop(_withTree);
              },
            ),
          ],
        );
      },
    );
  }

}


/// 单独封装一个内部管理选中状态的复选框组件
class DialogCheckbox extends StatefulWidget {
  DialogCheckbox({
    Key key,
    this.value,
    @required this.onChanged,
  });

  final ValueChanged<bool> onChanged;
  final bool value;

  @override
  _DialogCheckboxState createState() => _DialogCheckboxState();
}

class _DialogCheckboxState extends State<DialogCheckbox> {
  bool value;

  @override
  void initState() {
    value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      onChanged: (v) {
        //将选中状态通过事件的形式抛出
        widget.onChanged(v);
        setState(() {
          //更新自身选中状态
          value = v;
        });
      },
    );
  }
}

///StatefulBuilder
class StatefulBuilder extends StatefulWidget {
  const StatefulBuilder({
    Key key,
    @required this.builder,
  })  : assert(builder != null),
        super(key: key);

  final StatefulWidgetBuilder builder;

  @override
  _StatefulBuilderState createState() => _StatefulBuilderState();
}

class _StatefulBuilderState extends State<StatefulBuilder> {
  @override
  Widget build(BuildContext context) => widget.builder(context, setState);
}
