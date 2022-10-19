import 'dart:convert';
import 'dart:io';
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../model/model_user.dart';
import '../model/model_jadwal.dart';

class ApiController with ChangeNotifier {
  String baseUrl = "https://6326192b70c3fa390f9464be.mockapi.io/";
  List<ModelUser> listUser = [];
  List<ModelJadwal> listJadwal = [];
  List<ModelUser> login = [];

  get getUser => listUser;
  get getJadwal => listJadwal;

  userLogin(String email, String password, BuildContext context) async {
    final Uri url = Uri.parse("http://10.0.2.2/API/v1/user/index.php");
    try {
      final response = await http.post(
        url,
        headers: {"accept": "application/json"},
        body: {
          "email": email,
          "password": password,
        },
      );
      final status = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final data = status['akun'];
        Iterable iterable = data;
        login = iterable.map((e) => ModelUser.formJson(e)).toList();
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Error"),
            content: Text(status['message']),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Ok"),
              )
            ],
          ),
        );
        print(status['message']);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  postUser() async {
    final Uri endpoint = Uri.parse("${baseUrl}login");
    try {
      final response = await http.get(endpoint);
      Iterable iterable = jsonDecode(response.body);
      listUser = iterable.map((e) => ModelUser.formJson(e)).toList();
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
      print(e);
      return;
    }
  }
}
