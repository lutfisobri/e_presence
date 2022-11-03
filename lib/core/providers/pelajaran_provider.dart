import 'dart:convert';
import 'package:e_presence/core/model/model_mapel.dart';
import 'package:e_presence/core/model/model_presensi.dart';
import 'package:e_presence/core/model/model_ujian.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class PelajaranProvider with ChangeNotifier {
  final _baseUrl = "https://neko.id.orangeflasher.com/v1/pelajaran/";
  List<ModelPresensi> listPresensi = [];
  List<ModelMapel> listMapel = [];
  List<ModelUjian> listUjian = [];

  loadPresensi(String idKelas) async {
    final Uri url = Uri.parse("${_baseUrl}presensi.php?id_kelas=$idKelas");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      Iterable iterable = jsonDecode(response.body);
      listPresensi = iterable.map((e) => ModelPresensi.formJson(e)).toList();
      notifyListeners();
    }
  }

  loadMapel(String idKelas) async {
    final Uri url = Uri.parse("${_baseUrl}mapel.php?id_kelas=$idKelas");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      Iterable iterable = jsonDecode(response.body);
      listMapel = iterable.map((e) => ModelMapel.formJson(e)).toList();
      notifyListeners();
    }
  }

  loadUjian(String idKelas) async {
    final Uri url = Uri.parse("${_baseUrl}ujian.php?id_kelas=$idKelas");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      Iterable iterable = jsonDecode(response.body);
      listUjian = iterable.map((e) => ModelUjian.formJson(e)).toList();
      notifyListeners();
    }
  }
}
