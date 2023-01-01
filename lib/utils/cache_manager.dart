import 'dart:io';
import 'package:app_presensi/utils/message.dart';
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';

class Cache {
  void getCache() async {
    Log.i("Aplikasi Sedang Dimuat", color: Decoration.yellow);
    final cacheDirectory = (await getTemporaryDirectory()).path;
    final cacheDirectory2 = (await getApplicationDocumentsDirectory()).path;

    List<String> cache = [
      cacheDirectory,
      cacheDirectory2,
    ];

    for (var i = 0; i < cache.length; i++) {
      clear(cache[i]);
    }
    Future.delayed(const Duration(seconds: 1), () {
      Log.i("Applikasi Siap digunakan", color: Decoration.green);
    });
  }

  void clear(dir) async {
    if (await Directory(dir).exists()) {
      await Directory(dir).delete(recursive: true);
    }
  }
}
