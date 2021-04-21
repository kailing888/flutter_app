import 'package:flutter/material.dart';
import 'package:flutter_app/widget/BasePage.dart';

class TextFieldPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TextFieldState();
  }
}

class _TextFieldState extends State<TextFieldPage> {
  //定义一个controller
  TextEditingController _unameController = TextEditingController();
  FocusNode focusNode1 = new FocusNode();
  FocusNode focusNode2 = new FocusNode();
  FocusScopeNode focusScopeNode;

  @override
  void initState() {
    super.initState();

    //监听输入改变
    _unameController.addListener(() {
      print(_unameController.text);
    });

    // 监听焦点变化
    focusNode1.addListener(() {
      print(focusNode1.hasFocus);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
        "TextField",
        Column(
          children: <Widget>[
            TextField(
              autofocus: true,
              controller: _unameController,
              focusNode: focusNode1,
              decoration: InputDecoration(
                  labelText: "用户名",
                  hintText: "用户名或邮箱",
                  prefixIcon: Icon(Icons.person)),
            ),
            TextField(
              focusNode: focusNode2,
              decoration: InputDecoration(
                  labelText: "密码",
                  hintText: "您的登录密码",
                  prefixIcon: Icon(Icons.lock)),
              obscureText: true,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "请输入用户名",
                prefixIcon: Icon(Icons.person),
                // 未获得焦点下划线设为灰色
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                //获得焦点下划线设为蓝色
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            FlatButton(
              child: Text("修改文案"),
              onPressed: () {
                //设置默认值，并从第三个字符开始选中后面的字符
                _unameController.text = "hello world!";
                _unameController.selection = TextSelection(
                    baseOffset: 2, extentOffset: _unameController.text.length);
              },
            ),
            FlatButton(
              child: Text("移动光标"),
              onPressed: () {
                if (null == focusScopeNode) {
                  focusScopeNode = FocusScope.of(context);
                }
                focusScopeNode.requestFocus(focusNode2);
              },
            ),
          ],
        ));
  }
}
