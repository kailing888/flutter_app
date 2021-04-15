import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BasePage extends StatelessWidget {
  String title;

  Widget widget;

  BasePage(this.title, this.widget);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: widget
    );
  }
}
