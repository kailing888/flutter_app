import 'package:flutter/material.dart';
import 'package:flutter_app/widget/BasePage.dart';
import 'package:flutter_app/widget/function/provider/provider_consumer.dart';
import 'package:flutter_app/widget/function/provider/provider_selector.dart';

class Provider2Page extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Provider2State();
  }
}

class Provider2State extends State<Provider2Page> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
        "provider",
        Column(
          children: <Widget>[
            FlatButton(
              child: Text("consumer"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ProviderConsumer("ProviderConsumer");
                }));
              },
            ),
            FlatButton(
              child: Text("selector"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ProviderSelectorPage("ProviderSelector");
                }));
              },
            ),
          ],
        ));
  }
}
