import 'dart:convert';
import 'package:app_presensi/app/api/config/url.dart';
import 'package:http/http.dart' as http;

class ApiPelajaran {
  static Future jadwalMapel(String idKelasAjaran) async {
    final response = await http.get(
      Uri.parse("${Url.baseUrl}jadwal/pelajaran/$idKelasAjaran"),
      headers: Url.headers,
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    } else {
      throw Exception("Failed to load data");
    }
  }

  static Future jadwalUjian(String idKelasAjaran) async {
    final response = await http.get(
      Uri.parse("${Url.baseUrl}jadwal/ujian/$idKelasAjaran"),
      headers: Url.headers,
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    } else {
      throw Exception("Failed to load data");
    }
  }

  static Future jadwalPresensi(String idKelasAjaran) async {
    final response = await http.get(
      Uri.parse("${Url.baseUrl}jadwal/presensi/$idKelasAjaran"),
      headers: Url.headers,
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    } else {
      throw Exception("Failed to load data");
    }
  }

  static Future logP(String idKelasAjaran) async {
    final response = await http.get(
      Uri.parse("${Url.baseUrl}absensi/log/$idKelasAjaran"),
      headers: Url.headers,
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    } else {
      throw Exception("Failed to load data");
    }
  }

  static Future presensi(Map<String, dynamic> data) async {
    var request = http.MultipartRequest('POST', Uri.parse("${Url.baseUrl}absensi/presensi"));
    if (data['bukti'] != null) {
      request.files
          .add(await http.MultipartFile.fromPath('bukti', data['bukti']));
    }
    request.fields.addAll({
      'idPresensi': data['idPresensi'],
      'nis': data['nis'],
      'timestamp': data['timestamp'],
      'koordinat': data['koordinat'],
      'kehadiran': data['kehadiran'],
    });
    var response = await request.send();
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Failed to load data");
    }
  }
}
