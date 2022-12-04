import 'dart:async';
import 'package:app_presensi/resources/widgets/shared/button.dart';
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
