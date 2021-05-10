import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/widget/BasePage.dart';

///dio是一个强大的Dart Http请求库，支持Restful API、FormData、拦截器、请求取消、Cookie管理、文件上传/下载、超时等。
///dio的使用方式随着其版本升级可能会发生变化，
///dio内部仍然使用HttpClient发起的请求，所以代理、请求认证、证书校验等和HttpClient是相同的
class DioPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DioState();
  }
}

class DioState extends State<DioPage> {
  @override
  Widget build(BuildContext context) {
    return BasePage("Dio", _FutureBuilderRoute());
  }
}

class _FutureBuilderRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FutureBuilderRouteState();
  }
}

///注意，一个dio实例可以发起多个http请求，一般来说，APP只有一个http数据源时，dio应该使用单例模式。
class _FutureBuilderRouteState extends State<_FutureBuilderRoute> {
  Dio _dio = new Dio();

  @override
  Widget build(BuildContext context) {
    return new Container(
      alignment: Alignment.center,
      child: FutureBuilder(
          future: _dio.get("https://api.github.com/orgs/flutterchina/repos"),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            //请求完成
            if (snapshot.connectionState == ConnectionState.done) {
              Response response = snapshot.data;
              //发生错误
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              //请求成功，通过项目信息构建用于显示项目名称的ListView
              return ListView(
                children: response.data
                    .map<Widget>((e) => ListTile(title: Text(e["full_name"])))
                    .toList(),
              );
            }
            //请求未完成时弹出loading
            return CircularProgressIndicator();
          }),
    );
  }
}

///注意，onHttpClientCreate会在当前dio实例内部需要创建HttpClient时调用，
///所以通过此回调配置HttpClient会对整个dio实例生效，如果你想针对某个应用请求单独的代理或证书校验策略，可以创建一个新的dio实例即可。
//(dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
//     //设置代理
//     client.findProxy = (uri) {
//       return "PROXY 192.168.1.2:8888";
//     };
//     //校验证书
//     httpClient.badCertificateCallback=(X509Certificate cert, String host, int port){
//       if(cert.pem==PEM){
//       return true; //证书一致，则允许发送数据
//      }
//      return false;
//     };
//   };
