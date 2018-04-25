import 'package:adjust_sdk_plugin/adjustConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:adjust_sdk_plugin/adjust_sdk_plugin.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  String _platformVersion = 'Unknown';
  AppLifecycleState _lastLifecycleState;

  @override
  initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    initPlatformState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      switch (state) {
        case AppLifecycleState.inactive:
          //TODO:
          break;
        case AppLifecycleState.resumed:
          AdjustSdkPlugin.onResume();
          break;
        case AppLifecycleState.paused:
          //TODO:
          break;
        case AppLifecycleState.suspending:
          //TODO:
          break;
      }

      _lastLifecycleState = state;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  initPlatformState() async {
    AdjustConfig config = new AdjustConfig();
    config.appToken = "2fm9gkqubvpc";
    config.environment = AdjustEnvironment.sandbox;
    config.logLevel = AdjustLogLevel.VERBOSE;
    config.isDeviceKnown = false;
    //config.defaultTracker = "";

    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await AdjustSdkPlugin.platformVersion;

      // initialize the Adjust SDK
      print('Calling Adjust onCreate...');
      AdjustSdkPlugin.onCreate(config);
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;

      // start the Adjust SDK
      AdjustSdkPlugin.onResume();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Plugin example app'),
        ),
        body: new Column(
          children: <Widget>[
            new Text('Running on: $_platformVersion\n'),
            _lastLifecycleState == null
                ? const Text(
                    'This widget has not observed any lifecycle changes.')
                : new Text(
                    'The most recent lifecycle state this widget observed was: $_lastLifecycleState.'),
            _buildActionButton1(),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton1() {
    return new Align(
      alignment: const Alignment(0.0, -0.2),
      child: new FloatingActionButton(
        child: const Icon(Icons.add_circle),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        onPressed: () {
          print('action button 3 (ADJUST) pressed');

          try {
            AdjustSdkPlugin.isEnabled().then((isEnabled) {
              print('Adjust is enabled = $isEnabled');
            });
          } on PlatformException {
            print('no such method found im plugin: fireAndForget1');
          }
        },
      ),
    );
  }
}
