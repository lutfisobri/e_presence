import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:e_presence/core/model/model_mapel.dart';
import 'package:e_presence/core/model/model_user.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class UserControlProvider with ChangeNotifier {
  final String _baseUrl = "https://neko.id.orangeflasher.com/v1/user/";
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
  List<ModelMapel> dataMapel = [];

  Future<bool> changePassword(String password) async {
    final Uri url = Uri.parse("${_baseUrl}change_password.php");
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
  }

  Future<int> checkAccount() async {
    final Uri url = Uri.parse("${_baseUrl}login.php");
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
      return 401;
    } else {
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
      return false;
    }
  }

  Future<Map<String, dynamic>> searchAccount(String username) async {
    Map<String, dynamic> output = {
      "username": "tidak ditemukan",
      "email": "",
    };
    final Uri url = Uri.parse("${_baseUrl}search_account.php");
    final response = await http.post(
      url,
      body: {"username": username},
    );
    final dataResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      output = dataResponse;
    }
    return output;
  }

  Future<ModelUser> loadProfile() async {
    final Uri url = Uri.parse("${_baseUrl}login.php");
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
      return dataUser.clear();
    } else {
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
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  userClearData() {
    dataUser = dataUser.clear();
    notifyListeners();
  }

  updateProfile(String email, String? photo, String tglLahir) async {
    final Uri url = Uri.parse("${_baseUrl}update_profile.php");
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

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      loadProfile();
    } else {
      print(response.reasonPhrase);
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

  Future<Position> determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  }

  StreamSubscription<Position> subscription =
      Geolocator.getPositionStream().listen((Position position) async {});

  streamDispose() {
    subscription.cancel();
    notifyListeners();
  }
}
