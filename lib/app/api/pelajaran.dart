import 'dart:convert';
import 'package:app_presensi/app/api/config/url.dart';
import 'package:http/http.dart' as http;

Future jadwalMapel(String id) async {
  final response = await http.get(
      Uri.parse("${Url.baseUrl}pelajaran/jadwal-pelajaran.php?id_kelas=$id"),
      headers: Url.headers);
  if (response.statusCode == 200) {
    return jsonDecode(response.body)['data'];
  } else {
    throw Exception("Failed to load data");
  }
}

Future jadwalUjian(String id) async {
  final response = await http.get(
      Uri.parse("${Url.baseUrl}pelajaran/jadwal-ujian.php?id_kelas=$id"),
      headers: Url.headers);
  if (response.statusCode == 200) {
    return jsonDecode(response.body)['data'];
  } else {
    throw Exception("Failed to load data");
  }
}

Future jadwalPresensi(String id) async {
  final response = await http.get(
      Uri.parse("${Url.baseUrl}pelajaran/jadwal-presensi.php?id_kelas=$id"),
      headers: Url.headers);
  if (response.statusCode == 200) {
    return jsonDecode(response.body)['data'];
  } else {
    throw Exception("Failed to load data");
  }
}


Future presensi(Object data) async {
  final response = await http.post(
      Uri.parse("${Url.baseUrl}pelajaran/presensi.php"),
      headers: Url.headers,
      body: data);
  if (response.statusCode == 200) {
    return "200";
  } else {
    throw Exception("Failed to load data");
  }
}