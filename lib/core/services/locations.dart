import 'dart:async';
import 'package:e_presence/ui/shared/widgets/button_elevated.dart';
import 'package:e_presence/utils/static.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

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

Future<bool> checkPermissionLocation() async {
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    return false;
  } else if (permission == LocationPermission.deniedForever) {
    return false;
  } else {
    return true;
  }
}

class ViewPermissionLocation extends StatelessWidget {
  const ViewPermissionLocation({
    Key? key,
    required this.onTap,
  }) : super(key: key);
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Image.asset("assets/image/location.png"),
          const SizedBox(
            height: 80,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 19, right: 19),
            child: Text(
              "Lokasi",
              textAlign: TextAlign.center,
              style: TextStyle(
                letterSpacing: 2,
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: colorGreen,
              ),
            ),
          ),
          const SizedBox(
            height: 2,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 19, right: 19),
            child: Text(
              "Untuk Pengalaman yang terbaik. Izinkan Aplikasi E-Presensi untuk mengakses lokasi anda.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 19),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: WidgetEleBtn(
                    onPres: onTap,
                    textStyle: const TextStyle(
                      fontSize: 16,
                      letterSpacing: 1.36,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Roboto",
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: const Text("BERIKAN IZIN"),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 61,
          ),
        ],
      ),
    );
  }
}
