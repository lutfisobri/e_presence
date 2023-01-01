import 'dart:convert';
import 'package:app_presensi/app/api/config/url.dart';
import 'package:http/http.dart' as http;

class User {
  static Future login(Map<String, dynamic> json) async {
    final response = await http.post(Uri.parse("${Url.baseUrl}user/login"),
        headers: Url.headers, body: json);
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    } else if (response.statusCode == 403) {
      return newLogin(json);
    } else {
      throw Exception("Failed to load data");
    }
  }

  static Future newLogin(Map<String, dynamic> json) async {
    final response = await http.post(Uri.parse("${Url.baseUrl}user/new-login"),
        headers: Url.headers, body: json);
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    } else {
      throw Exception("Failed to load data");
    }
  }

  static Future checkIsLogin(Map<String, dynamic> json) async {
    final response = await http.post(Uri.parse("${Url.baseUrl}user/login"),
        headers: Url.headers, body: json);
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    } else {
      return false;
    }
  }

  static Future autoLogin(Map<String, dynamic> json) async {
    final response = await http.post(Uri.parse("${Url.baseUrl}user/login"),
        headers: Url.headers, body: json);
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    } else {
      throw Exception("Failed to load data");
    }
  }

  static Future logout(String username) async {
    final response = await http.post(
      Uri.parse("${Url.baseUrl}user/logout"),
      headers: Url.headers,
      body: {"username": username},
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    } else {
      throw Exception("Failed to logout");
    }
  }

  static Future update(Map<String, dynamic> json) async {
    final url = Uri.parse("${Url.baseUrl}user/update-profile");
    var request = http.MultipartRequest('POST', url);
    if (json['foto'] != null) {
      request.files
          .add(await http.MultipartFile.fromPath('foto', json['foto']));
    }
    request.fields.addAll({
      'username': json['username'],
      'email': json['email'],
      'tanggal_lahir': json['tanggal_lahir'],
    });
    var response = await request.send();
    if (response.statusCode == 200) {
      return jsonDecode(await response.stream.bytesToString())['data'];
    } else if (response.statusCode == 409) {
      return 409;
    } else {
      throw Exception("Failed to load data");
    }
  }

  static Future deleteFoto({required String username}) async {
    final response = await http.post(
        Uri.parse("${Url.baseUrl}user/delete-foto"),
        headers: Url.headers,
        body: jsonEncode({"username": username}));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load data");
    }
  }

  static Future updatePw(Map<String, dynamic> json) async {
    final response = await http.post(
        Uri.parse("${Url.baseUrl}user/change-password"),
        headers: Url.headers,
        body: json);
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    } else {
      throw Exception("Failed to load data");
    }
  }

  static Future changePw(Map<String, dynamic> json) async {
    final response = await http.post(
        Uri.parse("${Url.baseUrl}user/reset-password"),
        headers: Url.headers,
        body: json);
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    } else {
      throw Exception("Failed to load data");
    }
  }

  static Future search({required String username}) async {
    final response = await http.get(
        Uri.parse("${Url.baseUrl}user/search/$username"),
        headers: Url.headers);
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    } else {
      throw Exception("Failed to load data");
    }
  }

  static Future mail(Map<String, dynamic> json) async {
    final response = await http.post(Uri.parse("${Url.baseUrl}mail/send"),
        headers: Url.headers, body: json);
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    } else {
      throw Exception("Failed to load data");
    }
  }

  static Future verifyotp(Map<String, dynamic> json) async {
    final response = await http.post(Uri.parse("${Url.baseUrl}user/verify-otp"),
        headers: Url.headers, body: json);
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['status'];
    } else if (response.statusCode == 401) {
      return jsonDecode(response.body)['status'];
    } else if (response.statusCode == 410) {
      return jsonDecode(response.body)['status'];
    } else {
      throw Exception("Failed to load data");
    }
  }
}
