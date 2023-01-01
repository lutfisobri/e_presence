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
  /// [Decoration.green] [color] adalah warna yang akan digunakan untuk menampilkan pesan
  /// {@endtemplate}
  ///
  /// Example:
  /// ```dart
  /// Log.i("Ini adalah log info");
  ///
  /// Log.v("Ini adalah log verbose", color: Decoration.green);
  /// ```
  /// {@macro output}
  static void i(String message, {Decoration color = Decoration.green}) {
    _handler(message, color, type: "i");
  }

  /// {@macro log}
  ///
  /// Example:
  /// ```dart
  /// Log.d("Ini adalah log debug", "blue");
  ///
  /// Log.v("Ini adalah log verbose", color: Decoration.blue);
  /// ```
  /// {@macro output}
  static void d(String message, {Decoration color = Decoration.blue}) {
    _handler(message, color, type: "d");
  }

  /// {@macro log}
  ///
  /// Example:
  /// ```dart
  /// Log.e("Ini adalah log error");
  ///
  /// Log.v("Ini adalah log verbose", color: Decoration.red);
  /// ```
  ///
  /// {@macro output}
  static void e(String message, {Decoration color = Decoration.red}) {
    _handler(message, color, type: "e");
  }

  /// {@macro log}
  ///
  /// Example:
  /// ```dart
  /// Log.w("Ini adalah log warning");
  ///
  /// Log.v("Ini adalah log verbose", color: Decoration.orange);
  /// ```
  ///
  /// {@macro output}
  static void w(String message, {Decoration color = Decoration.orange}) {
    _handler(message, color, type: "w");
  }

  /// {@macro log}
  ///
  /// Example:
  /// ```dart
  /// Log.v("Ini adalah log verbose");
  ///
  /// Log.v("Ini adalah log verbose", color: Decoration.purple);
  /// ```
  ///
  /// {@macro output}
  static void v(String message, {Decoration color = Decoration.purple}) {
    _handler(message, color, type: "v");
  }

  static _validationColors(Decoration color) {
    switch (color) {
      case Decoration.red:
        return "red";
      case Decoration.green:
        return "green";
      case Decoration.yellow:
        return "yellow";
      case Decoration.blue:
        return "blue";
      case Decoration.magenta:
        return "magenta";
      case Decoration.cyan:
        return "cyan";
      case Decoration.white:
        return "white";
      case Decoration.black:
        return "black";
      case Decoration.orange:
        return "orange";
      case Decoration.purple:
        return "purple";
      default:
        return "red";
    }
  }

  static const _platform = MethodChannel('com.nekoid.presensi');
  static void _handler(String message, Decoration color, {String? type}) {
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
/// Log.i("Ini adalah log info", color: Decoration.green);
/// 
/// Log.d("Ini adalah log debug", color: Decoration.blue);
/// 
/// Log.e("Ini adalah log error", color: Decoration.red);
/// 
/// Log.w("Ini adalah log warning", color: Decoration.orange);
/// 
/// Log.v("Ini adalah log verbose", color: Decoration.purple);
/// 
/// ```
/// {@macro output}
enum Decoration {
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
