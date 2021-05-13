import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/widget/BasePage.dart';

class ChannelPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ChannelState();
  }
}

class ChannelState extends State<ChannelPage> {
  static const platform = const MethodChannel('samples.flutter.io/battery');
  String _batteryLevel = 'Unknown battery level.';

  @override
  Widget build(BuildContext context) {
    return BasePage(
        "Channel",
        Column(
          children: <Widget>[
            FlatButton(
              onPressed: () {
                _getBatteryLevel();
              },
              child: Text("获取电量"),
            ),
            Text(_batteryLevel)
          ],
        ));
  }

  // Get battery level.

  Future<Null> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }
}
