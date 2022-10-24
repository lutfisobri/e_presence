import 'dart:convert';
import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import '../model/model_user.dart';
import '../model/model_jadwal.dart';

class ApiController with ChangeNotifier {
  String baseUrl = "https://6326192b70c3fa390f9464be.mockapi.io/";
  List<ModelUser> dataUserLogin = [];
  List<ModelJadwal> listJadwal = [];

  // get getUser => dataUserLogin;
  get getJadwal => listJadwal;

  userLogin(String username, String password, BuildContext context) async {
    final Uri url = Uri.parse("http://10.0.2.2/API/v1/user/index.php");
    try {
      final response = await http.post(
        url,
        headers: {"accept": "application/json"},
        body: {
          "username": username,
          "password": password,
        },
      );
      final dataResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Iterable iterable = dataResponse['akun'];
        dataUserLogin = iterable.map((e) => ModelUser.formJson(e)).toList();
        notifyListeners();
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Error"),
            content: Text(dataResponse['message']),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Ok"),
              )
            ],
          ),
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // postUser() async {
  //   final Uri endpoint = Uri.parse("${baseUrl}login");
  //   try {
  //     final response = await http.get(endpoint);
  //     Iterable iterable = jsonDecode(response.body);
  //     listUser = iterable.map((e) => ModelUser.formJson(e)).toList();
  //     notifyListeners();
  //   } catch (e) {
  //     print(e.toString());
  //     return;
  //   }
  // }

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
