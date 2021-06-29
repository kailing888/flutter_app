
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'counter_notifier.dart';

class ProviderSelectorPage extends StatefulWidget{

  final String title;

  ProviderSelectorPage(this.title);

  @override
  State<StatefulWidget> createState() {
    return _ProviderSelectorState();
  }
}


class _ProviderSelectorState extends State<ProviderSelectorPage> {
  CounterNotifier _counter = CounterNotifier();

  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ChangeNotifierProvider.value(
          value: _counter,
          child: Column(
            children: <Widget>[
              Selector<CounterNotifier, int>(
                selector: (_, notifier) => notifier.count,
//                shouldRebuild:(previous,next)=> false,
                builder: (context, value, child) {
                  return Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Increment1 build ${_counter.count1}  count => You have pushed the button this many times:',
                        ),
                        Text(
                          '${_counter.count}',
                          style: Theme.of(context).textTheme.display1,
                        ),
                        FlatButton(
                            onPressed: () {
                              _counter.increment();
                            },
                            child: Text('Increment'))
                      ],
                    ),
                  );
                },
              ),
              Selector<CounterNotifier, int>(
                selector: (_, notifier) => notifier.count1,
                builder: (context, value, child) {
                  return Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Increment build ${_counter.count}  count => You have pushed the button this many times:',
                        ),
                        Text(
                          '${_counter.count1}',
                          style: Theme.of(context).textTheme.display1,
                        ),
                        FlatButton(
                            onPressed: () {
                              _counter.increment1();
                            },
                            child: Text('Increment1'))
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

///Seletor 介绍
//Selector({
//     Key key,
//     //  Widget Function(BuildContext context, T value, Widget child)
//     // 用于构建 Widget
//     @required ValueWidgetBuilder<S> builder,
//     // S Function(BuildContext, A)
//     // 用于指定使用哪个值作为重重建判断依据
//     @required S Function(BuildContext, A) selector,
//     // bool Function(T previous, T next)
//     // 是否重建，一般情况下不用我们实现
//     ShouldRebuild<S> shouldRebuild,
//     Widget child,
//   })
//

///Selector 有 Selector0 ～ Selector6，具体使用大同小异，可以传 0 ～ 6 个 ChangeNotifer，但是 S（Value）泛型只有一个，如果需要多个个值同时判断返回 S 怎么办呢？这个时候可以使用元祖 Tuple 。

