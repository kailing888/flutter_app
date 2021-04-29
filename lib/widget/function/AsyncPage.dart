import 'package:flutter/material.dart';
import 'package:flutter_app/widget/BasePage.dart';

class AsyncPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AsyncState();
  }
}

class AsyncState extends State<AsyncPage> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
        "Async",
        Column(
          children: <Widget>[
            Container(
              constraints: BoxConstraints(maxHeight: 150),
              child: Center(
                ///FutureBuilder
                child: FutureBuilder<String>(
                  future: mockNetworkData(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    // 请求已结束
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        // 请求失败，显示错误
                        return Text("Error: ${snapshot.error}");
                      } else {
                        // 请求成功，显示数据
                        return Text("Contents: ${snapshot.data}");
                      }
                    } else {
                      // 请求未结束，显示loading
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ),
            ),

            ///接收多个异步操作的结果
            Expanded(
              child: StreamBuilder<int>(
                stream: counter(), //
                //initialData: ,// a Stream<int> or null
                builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                  if (snapshot.hasError)
                    return Text('Error: ${snapshot.error}');
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return Text('没有Stream');
                    case ConnectionState.waiting:
                      return Text('等待数据...');
                    case ConnectionState.active:
                      return Text('active: ${snapshot.data}');
                    case ConnectionState.done:
                      return Text('Stream已关闭');
                  }
                  return null; // unreachable
                },
              ),
            ),
          ],
        ));
  }

  ///模拟一下这个过程，隔3秒后返回一个字符串
  Future<String> mockNetworkData() async {
    return Future.delayed(Duration(seconds: 2), () => "我是从互联网上获取的数据");
  }

  ///使用Stream来实现每隔一秒生成一个数字:
  Stream<int> counter() {
    return Stream.periodic(Duration(seconds: 1), (i) {
      return i;
    });
  }

  ///future：FutureBuilder依赖的Future，通常是一个异步耗时任务。
  ///initialData：初始数据，用户设置默认数据。
  ///builder：Widget构建器；该构建器会在Future执行的不同阶段被多次调用，构建器签名如下：
  ///snapshot会包含当前异步任务的状态信息及结果信息 ，比如我们可以通过snapshot.connectionState获取异步任务的状态信息、通过snapshot.hasError判断异步任务是否有错误等等，完整的定义读者可以查看AsyncSnapshot类定义。
}

//ConnectionState {
//   /// 当前没有异步任务，比如[FutureBuilder]的[future]为null时
//   none,
//
//   /// 异步任务处于等待状态
//   waiting,
//
//   /// Stream处于激活状态（流上已经有数据传递了），对于FutureBuilder没有该状态。
//   active,
//
//   /// 异步任务已经终止.
//   done,
// }
