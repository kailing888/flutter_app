import 'package:flutter/material.dart';
import 'package:flutter_app/widget/AlignPage.dart';
import 'package:flutter_app/widget/ButtonPage.dart';
import 'package:flutter_app/widget/ColumnPage.dart';
import 'package:flutter_app/widget/ContainerPage.dart';
import 'package:flutter_app/widget/DecorationPage.dart';
import 'package:flutter_app/widget/FlexPage.dart';
import 'package:flutter_app/widget/ImagePage.dart';
import 'package:flutter_app/widget/ProgressIndicatorPage.dart';
import 'package:flutter_app/widget/SizePage.dart';
import 'package:flutter_app/widget/StackPage.dart';
import 'package:flutter_app/widget/SwitchPage.dart';
import 'package:flutter_app/widget/TextFieldPage.dart';
import 'package:flutter_app/widget/TextWidget.dart';
import 'package:flutter_app/widget/TransformPage.dart';
import 'package:flutter_app/widget/WrapPage.dart';
import 'package:flutter_app/widget/scroll/ScrollBarPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildButton('Container', ContainerPage()),
          buildButton('Transform', TransformPage()),
          buildButton('Text', TextPage()),
          buildButton('Button', ButtonPage()),
          buildButton('Image', ImagePage()),
          buildButton('Switch', SwitchPage()),
          buildButton('TextField', TextFieldPage()),
          buildButton('ProgressIndicator', ProgressIndicatorPage()),
          buildButton('Column', ColumnPage()),
          buildButton('Flex', FlexPage()),
          buildButton('Wrap', WrapPage()),
          buildButton('Stack', StackPage()),
          buildButton('Align', AlignPage()),
          buildButton('ScrollBar', ScrollBarPage()),
          buildButton('Size', SizePage()),
          buildButton('Decoration', DecorationPage()),
        ],
      ),
    );
  }

  Widget buildButton(String title, Widget widget) {
    return RaisedButton(
      child: Text(title),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return widget;
        }));
      },
    );
  }
}
