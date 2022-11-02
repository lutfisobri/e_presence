import 'package:flutter/cupertino.dart';

class PelajaranProvider with ChangeNotifier {
  final _baseUrl = "https://neko.id.oreangeflasher.com/v1/pelajaran/";
  loadPresensi(String id_kelas) async {
    final Uri url = Uri.parse("${_baseUrl}presensi.php");
  }
}
