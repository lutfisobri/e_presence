import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../Model/model_user.dart';
import '../Model/model_Jadwal.dart';

class ApiController with ChangeNotifier {
  String baseUrl = "https://6326192b70c3fa390f9464be.mockapi.io/";
  List<ModelUser> listUser = [];
  List<ModelJadwal> listJadwal = [];

  get getUser => listUser;
  get getJadwal => listJadwal;

  postUser() async {
    final Uri endpoint = Uri.parse("${baseUrl}login");
    try {
      final response = await http.get(endpoint);
      Iterable iterable = jsonDecode(response.body);
      listUser = iterable.map((e) => ModelUser.formJson(e)).toList();
      notifyListeners();
    } catch (e) {
      // print(e.toString());
      return;
    }
  }

  loadJadwal() async {
    final Uri endpoint = Uri.parse("${baseUrl}jadwalmapel");
    try {
      final response = await http.get(endpoint);
      Iterable iterable = jsonDecode(response.body);
      listJadwal = iterable.map((e) => ModelJadwal.formJson(e)).toList();
      notifyListeners();
    } catch (e) {
      print(e.toString());
      return;
    }
  }
}
