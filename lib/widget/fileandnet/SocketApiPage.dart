
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/widget/BasePage.dart';

class SocketApiPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _SocketApiState();
  }

}

class _SocketApiState extends State<SocketApiPage>{

  String _response = "请求中";

  @override
  void initState() {
    super.initState();
    _request();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage("Socket",Text(_response));
  }

  ///使用Socket需要我们自己实现Http协议（需要自己实现和服务器的通信过程），本例只是一个简单示例，没有处理重定向、cookie等。
  _request() async{
    //建立连接
    var socket=await Socket.connect("baidu.com", 80);
    //根据http协议，发送请求头
    socket.writeln("GET / HTTP/1.1");
    socket.writeln("Host:baidu.com");
    socket.writeln("Connection:close");
    socket.writeln();
    await socket.flush(); //发送
    //读取返回内容
    _response = await socket.join();
    await socket.close();
    if (mounted) {
      setState(() {});
    }
  }
}