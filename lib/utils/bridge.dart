import 'package:flutter/services.dart';

class Bridge {
  static const MethodChannel _channel = MethodChannel('com.nekoid.presensi');
  static Future get url async {
    final  version = await _channel.invokeMethod('getDeelink');
    return version;
  }
  
}