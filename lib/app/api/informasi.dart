import 'dart:convert';
import 'package:app_presensi/app/api/config/url.dart';
import 'package:http/http.dart' as http;

Future getInformasi() async {
  final response = await http.get(
      Uri.parse("${Url.baseUrl}informasi/informasi.php"),
      headers: Url.headers);
  if (response.statusCode == 200) {
    return jsonDecode(response.body)['data'];
  } else {
    throw Exception("Failed to load data");
  }
}
