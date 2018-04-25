import 'dart:async';

import 'package:adjust_sdk_plugin/adjustConfig.dart';
import 'package:flutter/services.dart';

class AdjustSdkPlugin {
  static const MethodChannel _channel =
      const MethodChannel('adjust_sdk_plugin');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static void onResume() {
    _channel.invokeMethod('onResume');
  }

  static Future<bool> isEnabled() async {
    final bool isEnabled = await _channel.invokeMethod('isEnabled');
    return isEnabled;
  }

  static void onCreate(AdjustConfig config) {
    Map<String, String> configParamsMap = {
      'appToken': config.appToken,
      'environment': config.environmentString,
      'userAgent': 'flutter',
    };
    _channel.invokeMethod('onCreate', configParamsMap);
  }
}
