import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_app/widget/BasePage.dart';

class ProviderPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProviderState();
  }
}
///实现一个最小功能的Provider
class ProviderState extends State<ProviderPage> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
        "Provider",
        Center(
          child: ChangeNotifierProvider<CartModel>(
            data: CartModel(),
            child: Builder(builder: (context) {
              return Column(
                children: <Widget>[
                  Builder(builder: (context) {
                    var cart = ChangeNotifierProvider.of<CartModel>(context);
                    return Text("总价: ${cart.totalPrice}");
                  }),
                  Builder(builder: (context) {
                    print("RaisedButton build"); //在后面优化部分会用到
                    return RaisedButton(
                      child: Text("添加商品"),
                      onPressed: () {
                        //给购物车中添加商品，添加后总价会更新
                        ChangeNotifierProvider.of<CartModel>(context)
                            .add(Item(20.0, 1));
                      },
                    );
                  }),
                ],
              );
            }),
          ),
        ));
  }
}

///ChangeNotifier实现了一个Flutter风格的发布者-订阅者模式
class CartModel extends ChangeNotifier {
  // 用于保存购物车中商品列表
  final List<Item> _items = [];

  // 禁止改变购物车里的商品信息
  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  // 购物车中商品的总价
  double get totalPrice =>
      _items.fold(0, (value, item) => value + item.count * item.price);

  // 将 [item] 添加到购物车。这是唯一一种能从外部改变购物车的方法。
  void add(Item item) {
    _items.add(item);
    // 通知监听器（订阅者），重新构建InheritedProvider， 更新状态。
    notifyListeners();
  }
}


class ChangeNotifierProvider<T extends ChangeNotifier> extends StatefulWidget {
  ChangeNotifierProvider({
    Key key,
    this.data,
    this.child,
  });

  final Widget child;
  final T data;

  ///定义一个便捷方法，方便子树中的widget获取共享数据
  static T of<T>(BuildContext context) {
    final provider =  context.dependOnInheritedWidgetOfExactType<InheritedProvider<T>>();
    return provider.data;
  }

  @override
  _ChangeNotifierProviderState<T> createState() => _ChangeNotifierProviderState<T>();
}

class _ChangeNotifierProviderState<T extends ChangeNotifier> extends State<ChangeNotifierProvider<T>> {
  void update() {
    //如果数据发生变化（model类调用了notifyListeners），重新构建InheritedProvider
    setState(() => {});
  }

  @override
  void didUpdateWidget(ChangeNotifierProvider<T> oldWidget) {
    //当Provider更新时，如果新旧数据不"=="，则解绑旧数据监听，同时添加新数据监听
    if (widget.data != oldWidget.data) {
      oldWidget.data.removeListener(update);
      widget.data.addListener(update);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    // 给model添加监听器
    widget.data.addListener(update);
    super.initState();
  }

  @override
  void dispose() {
    // 移除model的监听器
    widget.data.removeListener(update);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InheritedProvider<T>(
      data: widget.data,
      child: widget.child,
    );
  }
}

// 一个通用的InheritedWidget，保存任需要跨组件共享的状态
class InheritedProvider<T> extends InheritedWidget {
  InheritedProvider({@required this.data, Widget child}) : super(child: child);

  //共享状态使用泛型
  final T data;

  @override
  bool updateShouldNotify(InheritedProvider<T> old) {
    //在此简单返回true，则每次更新都会调用依赖其的子孙节点的`didChangeDependencies`。
    return true;
  }
}

class Item {
  Item(this.price, this.count);
  double price; //商品单价
  int count; // 商品份数
//... 省略其它属性
}
