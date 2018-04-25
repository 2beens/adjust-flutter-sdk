enum AdjustLogLevel {
  verbose,
  debug,
  info,
  warn,
  error,
  asrt, // assert log level; assert is a keyword in dart
  suppress,
}

enum AdjustEnvironment { production, sandbox }

class AdjustConfig {
  String appToken;
  String userAgent;
  String defaultTracker;

  bool isDeviceKnown;
  bool sendInBackground;
  bool eventBufferingEnabled;
  bool allowSuppressLogLevel;
  bool launchDeferredDeeplink;

  AdjustLogLevel logLevel;
  AdjustEnvironment environment;

  //  Action<string> deferredDeeplinkDelegate;
  //  Action<AdjustEventSuccess> eventSuccessDelegate;
  //  Action<AdjustEventFailure> eventFailureDelegate;
  //  Action<AdjustSessionSuccess> sessionSuccessDelegate;
  //  Action<AdjustSessionFailure> sessionFailureDelegate;
  //  Action<AdjustAttribution> attributionChangedDelegate;

  num info1;
  num info2;
  num info3;
  num info4;
  num secretId;

  double delayStart;

  // Android specific members
  String processName;
  bool readImei;

  String get environmentString {
    return environment
        .toString()
        .substring(environment.toString().indexOf('.') + 1);
  }
}
