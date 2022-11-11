import 'dart:convert';
import 'package:e_presence/core/model/model_mapel.dart';
import 'package:e_presence/core/model/model_presensi.dart';
import 'package:e_presence/core/model/model_ujian.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:ntp/ntp.dart';

class PelajaranProvider with ChangeNotifier {
  final _baseUrl = "https://neko.id.orangeflasher.com/v1/pelajaran/";
  List<ModelPresensi> listPresensi = [];
  List<ModelMapel> listMapel = [];
  List<ModelUjian> listUjian = [];

  loadPresensi(String idKelas) async {
    final Uri url = Uri.parse("${_baseUrl}presensi.php?id_kelas=$idKelas");
    final int offset = await NTP.getNtpOffset(
      localTime: DateTime.now(),
      lookUpAddress: "0.id.pool.ntp.org",
    );
    DateTime internetTime = DateTime.now().add(Duration(milliseconds: offset));
    final response = await http.get(url);
    if (response.statusCode == 200) {
      Iterable iterable = jsonDecode(response.body);
      var pres = iterable.map((e) => ModelPresensi.formJson(e)).toList();
      listPresensi = pres.where((element) {
        return internetTime.isAfter(DateTime.parse(element.jamAwal)) &&
            internetTime.isBefore((DateTime.parse(element.jamAkhir)));
      }).toList();
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

  submitPresensi(Map<String, dynamic> json) async {
    final Uri url = Uri.parse("${_baseUrl}submit-presensi.php");
    var data = Presensi.send(json);
    try {
      final response = await http.post(
        url,
        headers: {
          "accept": "application/json",
        },
        body: data.toJson(),
      );
      if (response.statusCode == 200) {
      } else if (response.statusCode == 401) {
        return "401";
      } else {
        return "gagal";
      }
    } catch (e) {
      return "gagal";
    }
  }
}

class Presensi {
  String nis, status, koordinat, idPresensi, idMapel, idKelas;
  Presensi({
    required this.nis,
    required this.status,
    required this.koordinat,
    required this.idPresensi,
    required this.idMapel,
    required this.idKelas,
  });

  factory Presensi.send(Map<String, dynamic> json) {
    return Presensi(
      nis: json['nis'],
      status: json['status'],
      koordinat: json['koordinat'],
      idPresensi: json['id_presensi'],
      idMapel: json['id_mapel'],
      idKelas: json['id_kelas'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nis': nis,
      'status': status,
      'koordinat': koordinat,
      'id_presensi': idPresensi,
      'id_mapel': idMapel,
      'id_kelas': idKelas,
    };
  }
}
