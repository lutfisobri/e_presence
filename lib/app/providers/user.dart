import 'dart:convert';

import 'package:app_presensi/app/models/user.dart';
import 'package:app_presensi/app/services/storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class UserProvider with ChangeNotifier {
  final String _baseUrl = "https://kateruriyu.my.id/api/v3/user/";
  bool isLogin = false;
  ModelUser dataUser = ModelUser(
    username: '',
    nama: '',
    kelas: '',
    idKelas: '',
    tglLahir: '',
  );
  Map<String, dynamic> dataOTP = {};

  Future<String> login({
    required String username,
    required String password,
    required String deviceId,
  }) async {
    final Uri url = Uri.parse("${_baseUrl}login.php");
    try {
      final response = await http.post(
        url,
        headers: {
          "accept": "application/json",
        },
        body: {
          "username": username,
          "password": password,
          "deviceId": deviceId,
        },
      );
      if (response.statusCode == 200) {
        final dataResponse = jsonDecode(response.body)['data'];
        Storage.saveLogin(
          username: username,
          password: password,
        );
        dataUser = ModelUser.formJson(dataResponse);
        isLogin = true;
        notifyListeners();
        return "200";
      } else if (response.statusCode == 401) {
        return "401";
      } else {
        return "gagal";
      }
    } catch (e) {
      print(e);
      return "gagal";
    }
  }

  Future<bool> newLogin(
      {required String username,
      required String password,
      required String deviceId}) async {
    final Uri url = Uri.parse("${_baseUrl}login.php");
    try {
      final response = await http.post(
        url,
        headers: {
          "accept": "application/json",
        },
        body: {
          "username": username,
          "password": password,
          "new_device": deviceId,
        },
      );
      if (response.statusCode == 200) {
        final dataResponse = jsonDecode(response.body)['data'];
        Storage.saveLogin(
          username: username,
          password: password,
        );
        dataUser = ModelUser.formJson(dataResponse);
        isLogin = true;
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<int> checkAccount() async {
    final Uri url = Uri.parse("${_baseUrl}login.php");
    final dataLogin = await Storage.isLogin();
    try {
      final response = await http.post(
        url,
        headers: {
          "accept": "application/json",
        },
        body: {
          "username": dataUser.username,
          "password": dataLogin['password'],
          "deviceId": dataUser.deviceId,
        },
      );
      if (response.statusCode == 200) {
        return 200;
      } else if (response.statusCode == 401) {
        isLogin = false;
        notifyListeners();
        return 401;
      } else {
        return 404;
      }
    } catch (e) {
      return 404;
    }
  }

  Future<bool> logout() async {
    final Uri url = Uri.parse("${_baseUrl}logout.php");
    try {
      final response = await http.post(
        url,
        headers: {
          "accept": "application/json",
        },
        body: {
          "username": dataUser.username,
          'deviceId': dataUser.deviceId,
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        dataUser = dataUser.clear();
        isLogin = false;
        notifyListeners();
        return true;
      } else {
        isLogin = true;
        notifyListeners();
        return false;
      }
    } catch (e) {
      print(e);
      isLogin = false;
      dataUser = dataUser.clear();
      notifyListeners();
      return false;
    }
  }

  Future<ModelUser> loadProfile() async {
    final Uri url = Uri.parse("${_baseUrl}login.php");
    final dataLogin = await Storage.isLogin();
    try {
      final response = await http.post(
        url,
        headers: {
          "accept": "application/json",
        },
        body: {
          "username": dataUser.username,
          "password": dataLogin['password'],
          "deviceId": dataUser.deviceId,
        },
      );
      if (response.statusCode == 200) {
        dataUser = ModelUser.formJson(await jsonDecode(response.body)['data']);
        notifyListeners();
        return dataUser;
      } else if (response.statusCode == 401) {
        isLogin = false;
        notifyListeners();
        return dataUser.clear();
      } else {
        isLogin = false;
        return dataUser.clear();
      }
    } catch (e) {
      return dataUser.clear();
    }
  }

  Future<bool> updateProfile(
      String email, String? photo, String tglLahir) async {
    final Uri url = Uri.parse("${_baseUrl}update-profile.php");
    try {
      var request = http.MultipartRequest('POST', url);
      if (photo != null) {
        request.fields.addAll({
          'username': dataUser.username,
          'email': email,
          'tanggal_lahir': tglLahir,
        });
        request.files.add(await http.MultipartFile.fromPath('foto', photo));
      } else {
        request.fields.addAll({
          'username': dataUser.username,
          'email': email,
          'tanggal_lahir': tglLahir,
        });
      }

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        loadProfile();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> deletePhoto(String username) async {
    final Uri url = Uri.parse("${_baseUrl}delete-foto-profile.php");
    try {
      final response = await http.post(
        url,
        headers: {
          "accept": "application/json",
        },
        body: {
          "username": username,
        },
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      isLogin = false;
      return false;
    }
  }

  Future<bool> changePassword({
    required String password,
  }) async {
    final Uri url = Uri.parse("${_baseUrl}update-password.php");
    try {
      final response = await http.post(
        url,
        headers: {
          "accept": "application/json",
        },
        body: {
          "username": dataUser.username,
          "new_password": password,
        },
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> forgotChangePassword({
    required String username,
    required String password,
  }) async {
    final Uri url = Uri.parse("${_baseUrl}reset-password.php");
    try {
      final response = await http.post(
        url,
        headers: {
          "accept": "application/json",
        },
        body: {
          "username": username,
          "new_password": password,
        },
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<Map<String, dynamic>> searchAccount(String username) async {
    Map<String, dynamic> output = {
      "username": "",
      "email": "",
    };
    final Uri url = Uri.parse("${_baseUrl}search-account.php");
    try {
      final response = await http.post(
        url,
        body: {"username": username},
      );
      final dataResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        output = dataResponse;
      }
      return output;
    } catch (e) {
      return output;
    }
  }

  Future<bool> sendMail(String username, String email) async {
    final Uri url = Uri.parse("${_baseUrl}send-mail.php");
    try {
      final response = await http.post(
        url,
        body: {
          "username": username,
          "email": email,
        },
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<int> verificationOTP(String otp) async {
    final Uri url = Uri.parse("${_baseUrl}verif-otp.php");
    try {
      final response = await http.post(
        url,
        body: {
          "otp": otp,
        },
      );
      if (response.statusCode == 200) {
        dataOTP = jsonDecode(response.body);
        notifyListeners();
        return 1;
      } else if (response.statusCode == 400) {
        return 2;
      } else {
        return 0;
      }
    } catch (e) {
      return 0;
    }
  }
}
