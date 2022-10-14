import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BatteryChecker extends StatefulWidget {
  const BatteryChecker({Key? key}) : super(key: key);

  @override
  State<BatteryChecker> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<BatteryChecker> {
  static const platform = MethodChannel('sample.flutter.native/practice');

  String _batteryLevel = 'Unknown Battery Level';

  Future<void> _getBatteryLevel() async {
    debugPrint("Hello World");
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      debugPrint("Hello Battery $result");
      batteryLevel = 'Battery level at $result % .';
      debugPrint("Hello Battery $batteryLevel");
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }
    setState(() {
      _batteryLevel = batteryLevel;
    });
    debugPrint("Hello Battery $_batteryLevel");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Native Battery Checker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _batteryLevel,
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
                onPressed: _getBatteryLevel, child: const Text('Check Battery'))
          ],
        ),
      ),
    );
  }
}
