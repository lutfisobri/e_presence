import 'dart:convert';
import 'package:e_presence/Model/model_Jadwal.dart';
import 'package:e_presence/Model/model_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class API_controller with ChangeNotifier {
  String baseUrl = "https://6326192b70c3fa390f9464be.mockapi.io/";
  List<modelUser> listUser = [];
  List<ModelJadwal> listJadwal = [];

  get user => listUser;
  get jadwal => listJadwal;

  clearJadwal() {
    listJadwal.clear();
    notifyListeners();
  }

  postUser() async {
    final Uri endpoint = Uri.parse("${baseUrl}login");
    try {
      final response = await http.get(endpoint);
      Iterable iterable = jsonDecode(response.body);
      listUser = iterable.map((e) => modelUser.formJson(e)).toList();
      notifyListeners();
    } catch (e) {
      print(e.toString());
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
    }
  }
}
