import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:e_presence/core/model/model_user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserControlProvider with ChangeNotifier {
  final String _baseUrl = "https://neko.id.orangeflasher.com/v1/user/";
  bool isLogin = false;
  ModelUser dataUser = ModelUser(
    username: "",
    password: "",
    email: "",
    foto: "",
    idKelas: "",
    nis: "",
    nama: "",
    kelamin: "",
    kelas: "",
    tglLahir: "",
    isLogin: "",
    deviceId: "",
  );
  Map<String, dynamic> dataOTP = {};

  Future<bool> forgotChangePassword(String username, String password) async {
    final Uri url = Uri.parse("${_baseUrl}change_password.php");
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
      if (response.statusCode == 202) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> changePassword(String password) async {
    final Uri url = Uri.parse("${_baseUrl}change_password.php");
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
      if (response.statusCode == 202) {
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
    try {
      final response = await http.post(
        url,
        headers: {
          "accept": "application/json",
        },
        body: {
          "username": dataUser.username,
          "password": dataUser.password,
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

  Future<bool> deletePhoto(String nis) async {
    final Uri url = Uri.parse("${_baseUrl}deleteFoto.php");
    try {
      final response = await http.post(
        url,
        headers: {
          "accept": "application/json",
        },
        body: {
          "nis": nis,
        },
      );
      if (response.statusCode == 202) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      isLogin = false;
      return false;
    }
  }

  Future<bool> sendMail(String nis, String otp, String email) async {
    final Uri url = Uri.parse("${_baseUrl}send_email.php");
    try {
      final response = await http.post(
        url,
        body: {
          "nis": nis,
          "otp": otp,
          "email": email,
        },
      );
      if (response.statusCode == 202) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<int> verificationOTP(String otp) async {
    final Uri url = Uri.parse("${_baseUrl}verif_otp.php");
    try {
      final response = await http.post(
        url,
        body: {
          "otp": otp,
        },
      );
      if (response.statusCode == 202) {
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

  Future<Map<String, dynamic>> searchAccount(String username) async {
    Map<String, dynamic> output = {
      "username": "",
      "email": "",
    };
    final Uri url = Uri.parse("${_baseUrl}search_account.php");
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

  Future<ModelUser> loadProfile() async {
    final Uri url = Uri.parse("${_baseUrl}login.php");
    try {
      final response = await http.post(
        url,
        headers: {
          "accept": "application/json",
        },
        body: {
          "username": dataUser.username,
          "password": dataUser.password,
          "deviceId": dataUser.deviceId,
        },
      );
      if (response.statusCode == 200) {
        dataUser = ModelUser.formJson(await jsonDecode(response.body));
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

  Future<String> userLogin(
    String username,
    String password,
    String deviceId,
  ) async {
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
        final dataResponse = jsonDecode(response.body);
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
      return "gagal";
    }
  }

  Future<bool> userLoginNewDevice(
      String username, String password, String deviceId) async {
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
        final dataResponse = jsonDecode(response.body);
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

  Future<bool> userLogout() async {
    final Uri url = Uri.parse("${_baseUrl}logout.php");
    try {
      final response = await http.post(
        url,
        headers: {
          "accept": "application/json",
        },
        body: {
          "nis": dataUser.nis,
        },
      );
      if (response.statusCode == 202) {
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
      isLogin = false;
      dataUser = dataUser.clear();
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateProfile(
      String email, String? photo, String tglLahir) async {
    final Uri url = Uri.parse("${_baseUrl}update_profile.php");
    try {
      var request = http.MultipartRequest('POST', url);
      if (photo != null) {
        request.fields.addAll({
          'nis': dataUser.nis,
          'email': email,
          'tanggal_lahir': tglLahir,
        });
        request.files.add(await http.MultipartFile.fromPath('foto', photo));
      } else {
        request.fields.addAll({
          'nis': dataUser.nis,
          'email': email,
          'tanggal_lahir': tglLahir,
        });
      }

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 202) {
        loadProfile();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  // verificationPresensi(
  //   BuildContext context,
  //   double jarak,
  //   ModelPresensi mdl,
  //   List<ModelPresensi> items,
  // ) {
  //   const selfi = SnackBar(
  //     content: Text("Silahkan lakukan foto selfi untuk verifikasi"),
  //   );
  //   const jarakLebih = SnackBar(
  //     content: Text("Lakukan presensi dengan minimal jarak 5 meter"),
  //   );
  //   const mapsNull = SnackBar(
  //     content: Text("Nyalakan GPS untuk melakukan presensi"),
  //   );
  //   try {
  //     jarak == null
  //         ? ScaffoldMessenger.of(context).showSnackBar(mapsNull)
  //         : jarak.round() > 10
  //             ? ScaffoldMessenger.of(context).showSnackBar(jarakLebih)
  //             : source == null
  //                 ? ScaffoldMessenger.of(context).showSnackBar(selfi)
  //                 : showDialog(
  //                     context: context,
  //                     builder: (context) => AlertDialog(
  //                       actions: [
  //                         TextButton(
  //                           onPressed: () {
  //                             // mdl.data = items[0].data;
  //                             source = null;
  //                             Navigator.pop(context);
  //                           },
  //                           child: const Text("Ok"),
  //                         ),
  //                       ],
  //                     ),
  //                   );
  //     notifyListeners();
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  File? source;
}
