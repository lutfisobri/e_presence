import 'package:app_presensi/utils/bridge.dart';
import 'package:flutter/material.dart';

class DeepLinkObserver extends WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      getUrl();
      // final Uri deepLink = Uri.parse(window.defaultRouteName);
      // final String path = deepLink.path;
      // final Map<String, String> queryParameters = deepLink.queryParameters;
    }
  }

  getUrl() async {
    final url = await Bridge.url;
    final Uri deepLink = Uri.parse(url);
    final String path = deepLink.path;
    final Map<String, String> queryParameters = deepLink.queryParameters;
    print('path: $path');
    print('queryParameters: $queryParameters');
  }
}
