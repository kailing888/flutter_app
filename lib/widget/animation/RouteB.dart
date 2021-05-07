import 'package:flutter/material.dart';
import 'package:flutter_app/widget/BasePage.dart';

class RouteB extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RouteBState();
  }
}

class RouteBState extends State<RouteB> {
  @override
  Widget build(BuildContext context) {
    return BasePage("RouteB", Text("RouteB"));
  }
}

