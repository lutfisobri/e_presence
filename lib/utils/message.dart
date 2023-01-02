import 'package:flutter/services.dart';

/// Log class
///
/// Class ini digunakan untuk menampilkan log pada aplikasi
///
/// Contoh penggunaan:
///
/// ```dart
/// Log.i("Ini adalah log info");
/// ```
///
/// ```dart
/// Log.d("Ini adalah log debug");
/// ```
///
/// ```dart
/// Log.e("Ini adalah log error");
/// ```
///
/// ```dart
/// Log.w("Ini adalah log warning");
/// ```
///
/// ```dart
/// Log.v("Ini adalah log verbose");
/// ```
///
/// {@template output}
/// Output akan muncul di debug console
/// {@endtemplate}
class Log {
  /// {@template log}
  /// String [message] adalah pesan yang akan ditampilkan
  ///
  /// [Warna.green] [color] adalah warna yang akan digunakan untuk menampilkan pesan
  /// {@endtemplate}
  ///
  /// Example:
  /// ```dart
  /// Log.i("Ini adalah log info");
  ///
  /// Log.v("Ini adalah log verbose", color: Warna.green);
  /// ```
  /// {@macro output}
  static void i(String message, {Warna color = Warna.green}) {
    _handler(message, color, type: "i");
  }

  /// {@macro log}
  ///
  /// Example:
  /// ```dart
  /// Log.d("Ini adalah log debug", "blue");
  ///
  /// Log.v("Ini adalah log verbose", color: Warna.blue);
  /// ```
  /// {@macro output}
  static void d(String message, {Warna color = Warna.blue}) {
    _handler(message, color, type: "d");
  }

  /// {@macro log}
  ///
  /// Example:
  /// ```dart
  /// Log.e("Ini adalah log error");
  ///
  /// Log.v("Ini adalah log verbose", color: Warna.red);
  /// ```
  ///
  /// {@macro output}
  static void e(String message, {Warna color = Warna.red}) {
    _handler(message, color, type: "e");
  }

  /// {@macro log}
  ///
  /// Example:
  /// ```dart
  /// Log.w("Ini adalah log warning");
  ///
  /// Log.v("Ini adalah log verbose", color: Warna.orange);
  /// ```
  ///
  /// {@macro output}
  static void w(String message, {Warna color = Warna.orange}) {
    _handler(message, color, type: "w");
  }

  /// {@macro log}
  ///
  /// Example:
  /// ```dart
  /// Log.v("Ini adalah log verbose");
  ///
  /// Log.v("Ini adalah log verbose", color: Warna.purple);
  /// ```
  ///
  /// {@macro output}
  static void v(String message, {Warna color = Warna.purple}) {
    _handler(message, color, type: "v");
  }

  static _validationColors(Warna color) {
    switch (color) {
      case Warna.red:
        return "red";
      case Warna.green:
        return "green";
      case Warna.yellow:
        return "yellow";
      case Warna.blue:
        return "blue";
      case Warna.magenta:
        return "magenta";
      case Warna.cyan:
        return "cyan";
      case Warna.white:
        return "white";
      case Warna.black:
        return "black";
      case Warna.orange:
        return "orange";
      case Warna.purple:
        return "purple";
      default:
        return "red";
    }
  }

  static const _platform = MethodChannel('com.nekoid.presensi');
  static void _handler(String message, Warna color, {String? type}) {
    String colors = _validationColors(color);
    try {
      _platform.invokeMethod('log', <String, dynamic>{
        "tag": "Application",
        "color": colors,
        "message": message,
        "type": type,
      });
    } on PlatformException catch (e) {
      _platform.invokeMethod('log', <String, dynamic>{
        "tag": "Riyu",
        "color": "red",
        "message": e.toString(),
      });
    } catch (e) {
      _platform.invokeMethod('log', <String, dynamic>{
        "tag": "Riyu",
        "color": "red",
        "message": e.toString(),
      });
    }
  }
}

/// Enum untuk menentukan warna pada log
/// 
/// Warna yang tersedia:
/// - red
/// - green
/// - yellow
/// - blue
/// - magenta
/// - cyan
/// - white
/// - black
/// - orange
/// - purple
/// 
/// Contoh penggunaan:
/// ```dart
/// Log.i("Ini adalah log info", color: Warna.green);
/// 
/// Log.d("Ini adalah log debug", color: Warna.blue);
/// 
/// Log.e("Ini adalah log error", color: Warna.red);
/// 
/// Log.w("Ini adalah log warning", color: Warna.orange);
/// 
/// Log.v("Ini adalah log verbose", color: Warna.purple);
/// 
/// ```
/// {@macro output}
enum Warna {
  red,
  green,
  yellow,
  blue,
  magenta,
  cyan,
  white,
  black,
  orange,
  purple,
}
