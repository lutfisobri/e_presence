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

  static Future presensi(Object data) async {
    final response = await http.post(
        Uri.parse("${Url.baseUrl}pelajaran/presensi.php"),
        headers: Url.headers,
        body: data);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Failed to load data");
    }
  }
}
