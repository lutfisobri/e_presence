import 'dart:ui';

import 'package:flutter/material.dart';

class DeepLinkObserver extends WidgetsBindingObserver {
  @override
  void didReceiveLocalBroadcast(Object args) {
    print(args);
    // final String url = args;
    // Tambahkan kode untuk menangani deep link di sini
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      final Uri deepLink = Uri.parse(window.defaultRouteName);
      final String path = deepLink.path;
      final Map<String, String> queryParameters = deepLink.queryParameters;
    }
  }
}
