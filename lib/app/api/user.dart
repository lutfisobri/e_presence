import 'dart:convert';
import 'package:app_presensi/app/api/config/url.dart';
import 'package:http/http.dart' as http;

Future login(Map<String, dynamic> json) async {
  final response = await http.post(Uri.parse("${Url.baseUrl}user/login.php"),
      headers: Url.headers, body: json);
  if (response.statusCode == 200) {
    return jsonDecode(response.body)['data'];
  } else {
    throw Exception("Failed to load data");
  }
}

Future newLogin(Map<String, dynamic> json) async {
  final response = await http.post(
      Uri.parse("${Url.baseUrl}user/new-login.php"),
      headers: Url.headers,
      body: json);
  if (response.statusCode == 200) {
    return jsonDecode(response.body)['data'];
  } else {
    throw Exception("Failed to load data");
  }
}

Future logout() async {
  final response = await http.get(Uri.parse("${Url.baseUrl}user/logout.php"),
      headers: Url.headers);
  if (response.statusCode == 200) {
    return jsonDecode(response.body)['data'];
  } else {
    throw Exception("Failed to logout");
  }
}

Future update(Map<String, dynamic> json) async {
  final response = await http.post(
      Uri.parse("${Url.baseUrl}user/update-profile.php"),
      headers: Url.headers,
      body: json);
  if (response.statusCode == 200) {
    return jsonDecode(response.body)['data'];
  } else {
    throw Exception("Failed to load data");
  }
}

Future deleteFoto({required String username}) async {
  final response = await http.post(
      Uri.parse("${Url.baseUrl}user/delete-foto.php"),
      headers: Url.headers,
      body: jsonEncode({"username": username}));
  if (response.statusCode == 200) {
    return jsonDecode(response.body)['data'];
  } else {
    throw Exception("Failed to load data");
  }
}

Future updatePw(Map<String, dynamic> json) async {
  final response = await http.post(
      Uri.parse("${Url.baseUrl}user/update-password.php"),
      headers: Url.headers,
      body: json);
  if (response.statusCode == 200) {
    return jsonDecode(response.body)['data'];
  } else {
    throw Exception("Failed to load data");
  }
}

Future changePw(Map<String, dynamic> json) async {
  final response = await http.post(
      Uri.parse("${Url.baseUrl}user/reset-password.php"),
      headers: Url.headers,
      body: json);
  if (response.statusCode == 200) {
    return jsonDecode(response.body)['data'];
  } else {
    throw Exception("Failed to load data");
  }
}

Future search(Map<String, dynamic> json) async {
  final response = await http.post(
      Uri.parse("${Url.baseUrl}user/search-account.php"),
      headers: Url.headers,
      body: json);
  if (response.statusCode == 200) {
    return jsonDecode(response.body)['data'];
  } else {
    throw Exception("Failed to load data");
  }
}

Future mail(Map<String, dynamic> json) async {
  final response = await http.post(Uri.parse("${Url.baseUrl}user/send-mail.php"),
      headers: Url.headers, body: json);
  if (response.statusCode == 200) {
    return jsonDecode(response.body)['data'];
  } else {
    throw Exception("Failed to load data");
  }
}

Future verifyotp(Map<String, dynamic> json) async {
  final response = await http.post(Uri.parse("${Url.baseUrl}user/verify-otp.php"),
      headers: Url.headers, body: json);
  if (response.statusCode == 200) {
    return jsonDecode(response.body)['data'];
  } else {
    throw Exception("Failed to load data");
  }
}
