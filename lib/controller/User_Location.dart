import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class UserLocation with ChangeNotifier {
  bool serviceEnabled = false;
  LocationPermission? permission;
  Future<Position> determinePosition() async {
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
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
    notifyListeners();
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  }

  Position position = Position(
    longitude: 1,
    latitude: 1,
    timestamp: DateTime(5),
    accuracy: 1,
    altitude: 1,
    heading: 1,
    speed: 1,
    speedAccuracy: 1,
  );

  List<Placemark> placemarks = [];
  String value = '';
  double latitude = 1;
  double longitude = 1;

  double? distance;

  setPosition() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    StreamSubscription<Position> subscription =
        Geolocator.getPositionStream().listen((Position position) async {
      latitude = position.latitude;
      longitude = position.longitude;
      placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      distance = Geolocator.distanceBetween(
          -8.124655, 113.336256, position.latitude, position.longitude);
      notifyListeners();
    });
    // subscription.cancel();
    notifyListeners();
    // distance = Geolocator.getPositionStream().listen((Position position) {
    //   Geolocator.distanceBetween(
    //       -8.124655, 113.336256, position.latitude, position.longitude);
    // });
  }

  get jarak => distance;
}
