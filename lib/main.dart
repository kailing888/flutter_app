import 'package:flutter/material.dart';
import 'package:flutter_app/widget/ButtonPage.dart';
import 'package:flutter_app/widget/ColumnPage.dart';
import 'package:flutter_app/widget/FlexPage.dart';
import 'package:flutter_app/widget/ImagePage.dart';
import 'package:flutter_app/widget/ProgressIndicatorPage.dart';
import 'package:flutter_app/widget/SwitchPage.dart';
import 'package:flutter_app/widget/TextFieldPage.dart';
import 'package:flutter_app/widget/TextWidget.dart';

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
          buildButton('Text', TextPage()),
          buildButton('Button', ButtonPage()),
          buildButton('Image', ImagePage()),
          buildButton('Switch', SwitchPage()),
          buildButton('TextField', TextFieldPage()),
          buildButton('ProgressIndicator', ProgressIndicatorPage()),
          buildButton('Column', ColumnPage()),
          buildButton('Flex', FlexPage()),
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
