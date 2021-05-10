import 'package:flutter/material.dart';
import 'package:flutter_app/widget/AlignPage.dart';
import 'package:flutter_app/widget/ButtonPage.dart';
import 'package:flutter_app/widget/ClipPage.dart';
import 'package:flutter_app/widget/ColumnPage.dart';
import 'package:flutter_app/widget/ContainerPage.dart';
import 'package:flutter_app/widget/DecorationPage.dart';
import 'package:flutter_app/widget/FlexPage.dart';
import 'package:flutter_app/widget/ImagePage.dart';
import 'package:flutter_app/widget/ProgressIndicatorPage.dart';
import 'package:flutter_app/widget/ScaffoldPage.dart';
import 'package:flutter_app/widget/SizePage.dart';
import 'package:flutter_app/widget/StackPage.dart';
import 'package:flutter_app/widget/SwitchPage.dart';
import 'package:flutter_app/widget/TextFieldPage.dart';
import 'package:flutter_app/widget/TextWidget.dart';
import 'package:flutter_app/widget/TransformPage.dart';
import 'package:flutter_app/widget/WrapPage.dart';
import 'package:flutter_app/widget/animation/AnimatedSwitcherPage.dart';
import 'package:flutter_app/widget/animation/AnimationPage.dart';
import 'package:flutter_app/widget/animation/HeroAnimationPage.dart';
import 'package:flutter_app/widget/animation/RouteAnimation.dart';
import 'package:flutter_app/widget/animation/StaggerPage.dart';
import 'package:flutter_app/widget/animation/TransitionAnimationPage.dart';
import 'package:flutter_app/widget/custom/AssemblePage.dart';
import 'package:flutter_app/widget/custom/CustomPaintAndCanvasPage.dart';
import 'package:flutter_app/widget/custom/GradientCircularProgressPage.dart';
import 'package:flutter_app/widget/custom/TurnPage.dart';
import 'package:flutter_app/widget/fileandnet/FilePage.dart';
import 'package:flutter_app/widget/fileandnet/OriginHttpPage.dart';
import 'package:flutter_app/widget/function/AsyncPage.dart';
import 'package:flutter_app/widget/function/ColorThemePage.dart';
import 'package:flutter_app/widget/function/DialogPage.dart';
import 'package:flutter_app/widget/function/InheritedPage.dart';
import 'package:flutter_app/widget/function/ProviderPage.dart';
import 'package:flutter_app/widget/function/StatePage.dart';
import 'package:flutter_app/widget/function/WillPopPage.dart';
import 'package:flutter_app/widget/pointer/EventBusPage.dart';
import 'package:flutter_app/widget/pointer/GesturePage.dart';
import 'package:flutter_app/widget/pointer/NotificationPage.dart';
import 'package:flutter_app/widget/pointer/PointerPage.dart';
import 'package:flutter_app/widget/scroll/CustomScrollPage.dart';
import 'package:flutter_app/widget/scroll/GridViewPage.dart';
import 'package:flutter_app/widget/scroll/ListViewPage.dart';
import 'package:flutter_app/widget/scroll/NotificationListenerPage.dart';
import 'package:flutter_app/widget/scroll/ScrollBarPage.dart';
import 'package:flutter_app/widget/scroll/ScrollControllerPage.dart';

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
      body: GridView.count(
        crossAxisCount: 3,
        childAspectRatio: 2.5,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        children: <Widget>[
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
          buildButton('Transform', TransformPage()),
          buildButton('Container', ContainerPage()),
          buildButton('Scaffold', ScaffoldPage()),
          buildButton('Clip', ClipPage()),
          buildButton('ListView', ListViewPage()),
          buildButton('GridView', GridViewPage()),
          buildButton('Sliver', CustomScrollPage()),
          buildButton('ScrollController', ScrollControllerPage()),
          buildButton('NotificationListener', NotificationListenerPage()),
          buildButton('WillPop', WillPopPage()),
          buildButton('Inherited', InheritedPage()),
          buildButton('Provider', ProviderPage()),
          buildButton('ColorTheme', ColorThemePage()),
          buildButton('Async', AsyncPage()),
          buildButton('DialogPage', DialogPage()),
          buildButton('StatePage', StatePage()),
          buildButton('Pointer', PointerPage()),
          buildButton('Gesture', GesturePage()),
          buildButton('EventBus', EventBusPage()),
          buildButton('Notification', NotificationPage()),
          buildButton('Animation', AnimationPage()),
          buildButton('RouteAnimation', RouteAnimationPage()),
          buildButton('Hero', HeroAnimationPage()),
          buildButton('Stagger', StaggerPage()),
          buildButton('AnimatedSwitcher', AnimatedSwitcherPage()),
          buildButton('TransitionAnimation', TransitionAnimationPage()),
          buildButton('Assemble', AssemblePage()),
          buildButton('Turn', TurnPage()),
          buildButton('CustomPaintAndCanvas', CustomPaintAndCanvasPage()),
          buildButton(
              'GradientCircularProgress', GradientCircularProgressPage()),
          buildButton('file', FileOperationRoute()),
          buildButton('OriginHttp', OriginHttpPage()),
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
