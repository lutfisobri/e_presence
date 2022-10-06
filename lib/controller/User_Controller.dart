import 'dart:async';
import 'dart:io';
import 'package:e_presence/Model/model_presensi.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

class UserControlProvider with ChangeNotifier {
  getUser(String username, String password) {
    // print(username);
    // print(Password);
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
  XFile? photo;

  File? source;

  pickImage() async {
    // image = await _picker.pickImage(source: ImageSource.gallery);
    try {
      photo = await _picker.pickImage(source: ImageSource.camera);
      if (photo != null) {
        source = File(photo!.path);
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  reset() {
    photo = null;
    source = null;
    notifyListeners();
  }

  get path => source;

  // bool serviceEnabled = false;
  // LocationPermission? permission;

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

  double latitude = 0;

  StreamSubscription<Position> subscription =
      Geolocator.getPositionStream().listen((Position position) async {});

  streamDispose() {
    subscription.cancel();
    notifyListeners();
  }
}
