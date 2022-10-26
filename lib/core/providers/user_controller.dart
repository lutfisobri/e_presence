import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:e_presence/core/model/model_mapel.dart';
import 'package:e_presence/core/model/model_presensi.dart';
import 'package:e_presence/core/model/model_user.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class UserControlProvider with ChangeNotifier {
  final String _baseUrl = "https://neko.id.orangeflasher.com/v1/";
  late ModelUser dataUser;
  late List<ModelMapel> dataMapel;

  Future<List<Map<String, dynamic>>> searchAccount(String username) async {
    List<Map<String, dynamic>> output = [
      {
        "username": "tidak ditemukan",
        "email": "",
      }
    ];
    final Uri url = Uri.parse("${_baseUrl}user/index.php");
    final response = await http.post(
      url,
      body: {"username": username, "lupa_password": "iya"},
    );
    final dataResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      output = [dataResponse];
    }
    return output;
  }

  Future<ModelUser> loadProfile() async {
    final Uri url = Uri.parse("${_baseUrl}user/index.php");
    final response = await http.post(
      url,
      headers: {
        "accept": "application/json",
      },
      body: {
        "username": dataUser.username,
        "password": dataUser.password,
        "login": "false",
      },
    );
    final dataResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      dataUser = ModelUser.formJson(dataResponse);
      getMapel(dataUser.idKelas);
      notifyListeners();
    }
    return ModelUser.formJson(dataResponse);
  }

  userLogin(String username, String password, BuildContext context) async {
    final Uri url = Uri.parse("${_baseUrl}user/index.php");
    try {
      final response = await http.post(
        url,
        headers: {
          "accept": "application/json",
        },
        body: {
          "username": username,
          "password": password,
          "login": "true",
        },
      );
      final dataResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        dataUser = ModelUser.formJson(dataResponse);
        getMapel(dataUser.idKelas);
        Navigator.pushReplacementNamed(context, "/home");
        notifyListeners();
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(dataResponse['message']),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Ok"),
                )
              ],
            );
          },
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }

  userClearData() {
    dataUser = dataUser.clear();
    notifyListeners();
  }

  getMapel(String idKelas) async {
    final Uri url = Uri.parse("${_baseUrl}mapel/index.php?id_kelas=1");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        Iterable iterable = jsonDecode(response.body);
        dataMapel = iterable.map((e) => ModelMapel.formJson(e)).toList();
        notifyListeners();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  updateProfile(String email, String? photo) async {
    final Uri url = Uri.parse("${_baseUrl}user/index.php");
    var request =
        http.MultipartRequest('POST', Uri.parse('${_baseUrl}user/index.php'));
    if (photo != null) {
      request.fields.addAll({'nis': dataUser.nis, 'email': email});
      request.files.add(await http.MultipartFile.fromPath('foto', photo));
    } else {
      request.fields
          .addAll({'nis': dataUser.nis, 'email': email, 'foto': "ya"});
    }

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      loadProfile();
    } else {
      print(response.reasonPhrase);
    }
  }

  verificationPresensi(
    BuildContext context,
    double jarak,
    ModelPresensi mdl,
    List<ModelPresensi> items,
  ) {
    const selfi = SnackBar(
      content: Text("Silahkan lakukan foto selfi untuk verifikasi"),
    );
    const jarakLebih = SnackBar(
      content: Text("Lakukan presensi dengan minimal jarak 5 meter"),
    );
    const mapsNull = SnackBar(
      content: Text("Nyalakan GPS untuk melakukan presensi"),
    );
    try {
      jarak == null
          ? ScaffoldMessenger.of(context).showSnackBar(mapsNull)
          : jarak.round() > 10
              ? ScaffoldMessenger.of(context).showSnackBar(jarakLebih)
              : source == null
                  ? ScaffoldMessenger.of(context).showSnackBar(selfi)
                  : showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        actions: [
                          TextButton(
                            onPressed: () {
                              // mdl.data = items[0].data;
                              source = null;
                              Navigator.pop(context);
                            },
                            child: const Text("Ok"),
                          ),
                        ],
                      ),
                    );
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  final ImagePicker _picker = ImagePicker();
  // XFile? image;
  XFile? _photo;

  File? source;

  pickImage() async {
    // image = await _picker.pickImage(source: ImageSource.gallery);
    try {
      _photo = await _picker.pickImage(source: ImageSource.camera);
      if (_photo != null) {
        source = File(_photo!.path);
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  reset() {
    _photo = null;
    source = null;
    notifyListeners();
  }

  get path => source;

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
