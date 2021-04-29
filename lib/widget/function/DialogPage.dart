import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/widget/BasePage.dart';

class DialogPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DialogState();
  }
}

///AlertDialog和SimpleDialog都使用了Dialog类
///showDialog方法，它是Material组件库中提供的一个打开Material风格对话框的方法
///直接调用Navigator的push方法打开了一个新的对话框路由_DialogRoute，然后返回了push的返回值。
///setState方法只会针对当前context的子树重新build
///将对话框的状态置于一个StatefulWidget的上下文中
///StatefulBuilder获取了StatefulWidget的上下文，并代理了其构建过程。下面我们就可以通过StatefulBuilder来重构上面的代码了
class DialogState extends State<DialogPage> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
        "Dialog",
        Column(
          children: <Widget>[
            //点击该按钮后弹出对话框
            RaisedButton(
              child: Text("对话框1"),
              onPressed: () async {
                ///弹出对话框并等待其关闭
                ///获取返回数据
                bool delete = await showDeleteConfirmDialog1();
                if (delete == null) {
                  print("取消删除");
                } else {
                  print("已确认删除");
                  //... 删除文件
                }
              },
            ),
            RaisedButton(
              child: Text("列表对话框"),
              onPressed: () async {
                changeLanguage();
              },
            ),
            RaisedButton(
              child: Text("ListDialog"),
              onPressed: () async {
                _showListDialog();
              },
            ),
            RaisedButton(
              child: Text("showGeneralDialog"),
              onPressed: () async {
                showCustom();
              },
            ),
            RaisedButton(
              child: Text("showModalBottomSheet"),
              onPressed: () async {
                int type = await _showModalBottomSheet();
                print(type);
              },
            ),
            RaisedButton(
              child: Text("showLoadingDialog"),
              onPressed: () async {
                showLoadingDialog();
              },
            ),

            RaisedButton(
              child: Text("Material风格的日历"),
              onPressed: () async {
                _showDatePicker1();
              },
            ),
            RaisedButton(
              child: Text("iOS风格的日历"),
              onPressed: () async {
                _showDatePicker2();
              },
            ),
          ],
        ));
  }

  ///iOS风格的日历选择器
  Future<DateTime> _showDatePicker2() {
    var date = DateTime.now();
    return showCupertinoModalPopup(
      context: context,
      builder: (ctx) {
        return SizedBox(
          height: 200,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.dateAndTime,
            minimumDate: date,
            maximumDate: date.add(
              Duration(days: 30),
            ),
            maximumYear: date.year + 1,
            onDateTimeChanged: (DateTime value) {
              print(value);
            },
          ),
        );
      },
    );
  }

  ///Material风格的日历选择器
  Future<DateTime> _showDatePicker1() {
    var date = DateTime.now();
    return showDatePicker(
      context: context,
      initialDate: date,
      firstDate: date,
      lastDate: date.add(
        //未来30天可选
        Duration(days: 30),
      ),
    );
  }

  ///LoadingDialog
  showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, //点击遮罩不关闭对话框
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircularProgressIndicator(),
              Padding(
                padding: const EdgeInsets.only(top: 26.0),
                child: Text("正在加载，请稍后..."),
              )
            ],
          ),
        );
      },
    );
  }

  /// 弹出底部菜单列表模态对话框
  Future<int> _showModalBottomSheet() {
    return showModalBottomSheet<int>(
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
          itemCount: 30,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text("$index"),
              onTap: () => Navigator.of(context).pop(index),
            );
          },
        );
      },
    );
  }

  ///showGeneralDialog
  Future<T> showCustom<T>() {
    showCustomDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("提示"),
          content: Text("您确定要删除当前文件吗?"),
          actions: <Widget>[
            FlatButton(
              child: Text("取消"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            FlatButton(
              child: Text("删除"),
              onPressed: () {
                // 执行删除操作
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  Future<T> showCustomDialog<T>({
    @required BuildContext context,
    bool barrierDismissible = true,
    WidgetBuilder builder,
  }) {
    final ThemeData theme = Theme.of(context, shadowThemeOnly: true);
    return showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        final Widget pageChild = Builder(builder: builder);
        return SafeArea(
          child: Builder(builder: (BuildContext context) {
            return theme != null
                ? Theme(data: theme, child: pageChild)
                : pageChild;
          }),
        );
      },
      barrierDismissible: barrierDismissible,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black87,
      // 自定义遮罩颜色
      transitionDuration: const Duration(milliseconds: 150),
      transitionBuilder: _buildMaterialDialogTransitions,
    );
  }

  Widget _buildMaterialDialogTransitions(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    // 使用缩放动画
    return ScaleTransition(
      scale: CurvedAnimation(
        parent: animation,
        curve: Curves.easeOut,
      ),
      child: child,
    );
  }

  ///Dialog
  Future<void> _showListDialog() async {
    int index = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        var child = Column(
          children: <Widget>[
            ListTile(title: Text("请选择")),
            Expanded(
                child: ListView.builder(
              itemCount: 30,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text("$index"),
                  onTap: () => Navigator.of(context).pop(index),
                );
              },
            )),
          ],
        );
        //使用AlertDialog会报错
        //return AlertDialog(content: child);
        return Dialog(child: child);
      },
    );
    if (index != null) {
      print("点击了：$index");
    }
  }

  /// 弹出对话框 AlertDialog
  Future<bool> showDeleteConfirmDialog1() {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("提示"),
          content: Text("您确定要删除当前文件吗?"),
          actions: <Widget>[
            FlatButton(
              child: Text("取消"),
              onPressed: () => Navigator.of(context).pop(), // 关闭对话框
            ),
            FlatButton(
              child: Text("删除"),
              onPressed: () {
                //关闭对话框并返回true
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  ///列表对话框  SimpleDialog
  Future<void> changeLanguage() async {
    int i = await showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('请选择语言'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  // 返回1
                  Navigator.pop(context, 1);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: const Text('中文简体'),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  // 返回2
                  Navigator.pop(context, 2);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: const Text('美国英语'),
                ),
              ),
            ],
          );
        });

    if (i != null) {
      print("选择了：${i == 1 ? "中文简体" : "美国英语"}");
    }
  }
}

///
// Future<T> showGeneralDialog<T>({
//   @required BuildContext context,
//   @required RoutePageBuilder pageBuilder, //构建对话框内部UI
//   bool barrierDismissible, //点击遮罩是否关闭对话框
//   String barrierLabel, // 语义化标签(用于读屏软件)
//   Color barrierColor, // 遮罩颜色
//   Duration transitionDuration, // 对话框打开/关闭的动画时长
//   RouteTransitionsBuilder transitionBuilder, // 对话框打开/关闭的动画
// })
