import 'dart:io';
import 'package:path_provider/path_provider.dart';

class Cache {
  void getCache() async {
    final cacheDirectory = (await getTemporaryDirectory()).path;
    final cacheDirectory2 = (await getApplicationDocumentsDirectory()).path;
    final cacheDirectory3 = (await getExternalStorageDirectory())!.path;
    final cacheDirectory4 = (await getApplicationSupportDirectory()).path;

    List<String> cache = [
      cacheDirectory,
      cacheDirectory2,
      cacheDirectory3,
      cacheDirectory4,
    ];

    for (var i = 0; i < cache.length; i++) {
      clear(cache[i]);
    }
    
  }

  void clear(dir) async {
    if (await Directory(dir).exists()) {
      await Directory(dir).delete(recursive: true);
    }
  }
}
