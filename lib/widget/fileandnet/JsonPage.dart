import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/widget/BasePage.dart';

class JsonPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return JsonState();
  }
}

class JsonState extends State<JsonPage> {
  @override
  Widget build(BuildContext context) {
    return BasePage("json", Text("json"));
  }

  ///JSON字符串具体内容将其转为List或Map
  void formatJson() {
    //一个JSON格式的用户列表字符串
    String jsonStr = '[{"name":"Jack"},{"name":"Rose"}]';
    //将JSON字符串转为Dart对象(此处是List)
    List items = json.decode(jsonStr);
    //输出第一个用户的姓名
    print(items[0]["name"]);

    ///采用这种新方法，我们可以非常容易地反序列化user.
    ///要序列化一个user，我们只是将该User对象传递给该json.encode方法。我们不需要手动调用toJson这个方法，因为`JSON.encode内部会自动调用。
    Map userMap = json.decode(jsonStr);
    var user = new User.fromJson(userMap);

    print('Howdy, ${user.name}!');
    print('We sent the verification link to ${user.email}.');
  }
}

class User {
  final String name;
  final String email;

  User(this.name, this.email);

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'];

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'email': email,
      };
}
