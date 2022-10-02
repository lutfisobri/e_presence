import 'package:e_presence/controller/User_Location.dart';
import 'package:e_presence/controller/User_image.dart';
import 'package:flutter/material.dart';

class UserAuth with ChangeNotifier {
  getUser(String username, String Password) {
    print(username);
    print(Password);
  }

  verificationPresensi(
      BuildContext context, userImage pickPhoto, UserLocation maps) {
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
      maps.distance == null
          ? ScaffoldMessenger.of(context).showSnackBar(mapsNull)
          : maps.distance!.round() > 10
              ? ScaffoldMessenger.of(context).showSnackBar(jarakLebih)
              : pickPhoto.source == null
                  ? ScaffoldMessenger.of(context).showSnackBar(selfi)
                  : showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        actions: [
                          TextButton(
                            onPressed: () {
                              pickPhoto.reset();
                              Navigator.pop(context);
                            },
                            child: Text("Ok"),
                          ),
                        ],
                      ),
                    );
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
