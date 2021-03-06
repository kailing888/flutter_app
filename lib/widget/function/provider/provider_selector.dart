
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

///Seletor ??????
//Selector({
//     Key key,
//     //  Widget Function(BuildContext context, T value, Widget child)
//     // ???????????? Widget
//     @required ValueWidgetBuilder<S> builder,
//     // S Function(BuildContext, A)
//     // ??????????????????????????????????????????????????????
//     @required S Function(BuildContext, A) selector,
//     // bool Function(T previous, T next)
//     // ????????????????????????????????????????????????
//     ShouldRebuild<S> shouldRebuild,
//     Widget child,
//   })
//

///Selector ??? Selector0 ??? Selector6??????????????????????????????????????? 0 ??? 6 ??? ChangeNotifer????????? S???Value?????????????????????????????????????????????????????????????????? S ????????????????????????????????????????????? Tuple ???

