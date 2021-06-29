import 'package:flutter/material.dart';
import 'package:flutter_app/widget/function/provider/counter_notifier.dart';
import 'package:provider/provider.dart';

class ProviderConsumer extends StatefulWidget {
  final String title;

  ProviderConsumer(this.title);

  @override
  State<StatefulWidget> createState() {
    return _ProviderConsumerState();
  }
}

///这里使用了两个 Consumer 实现了局部刷新。通过上面的效果图可以看到，
///一个 Consumer 中的按钮点击，除了刷新了当前的 Consumer，另一个 Consumer 也刷新重建了。
class _ProviderConsumerState extends State<ProviderConsumer> {
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
              Consumer<CounterNotifier>(
                builder: (context, v, child) {
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
              Consumer<CounterNotifier>(
                builder: (context, v, child) {
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
