import 'dart:async';
import 'package:app_presensi/utils/message.dart';
import 'package:geolocator/geolocator.dart';

Future<bool> determinePosition() async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    Geolocator.openLocationSettings();
    do {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      Geolocator.openLocationSettings();
    } while (!serviceEnabled);
  }
  LocationPermission permission = await Geolocator.requestPermission();
  if (permission == LocationPermission.denied) {
    return true;
  } else if (permission == LocationPermission.deniedForever) {
    return true;
  } else {
    return true;
  }
}

StreamSubscription<Position> subscription =
    Geolocator.getPositionStream().listen((Position position) async {});

Future<bool> checkPermissionLocation() async {
  LocationPermission permission = await Geolocator.checkPermission();
  Log.i("permission: $permission");
  if (permission == LocationPermission.denied) {
    return false;
  } else if (permission == LocationPermission.deniedForever) {
    return true;
  } else {
    return true;
  }
}
