import 'package:app_presensi/app/api/pelajaran.dart';
import 'package:flutter/widgets.dart';

class PresensiProvider extends ChangeNotifier {
  Future<bool> presensiHadir({
    required String idPresensi,
    required String nis,
    required String time,
    required String koordinat,
  }) async {
    final bool result = await ApiPelajaran.presensi({
      "idPresensi": idPresensi,
      "nis": nis,
      "timestamp": time,
      "koordinat": koordinat,
      "kehadiran": "1",
    }).catchError((e) {
      return false;
    });
    if (result == true) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> presensiIzin({
    required String idPresensi,
    required String nis,
    required String time,
    required String koordinat,
    required String bukti,
  }) async {
    final bool result = await ApiPelajaran.presensi({
      "idPresensi": idPresensi,
      "nis": nis,
      "timestamp": time,
      "koordinat": koordinat,
      "kehadiran": "2",
      "bukti": bukti,
    }).catchError((e) {
      return false;
    });
    if (result == true) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> presensiSakit({
    required String idPresensi,
    required String nis,
    required String time,
    required String koordinat,
    required String bukti,
  }) async {
    final bool result = await ApiPelajaran.presensi({
      "idPresensi": idPresensi,
      "nis": nis,
      "timestamp": time,
      "koordinat": koordinat,
      "bukti": bukti,
      "kehadiran": "3",
    }).catchError((e) {
      return false;
    });
    if (result == true) {
      return true;
    } else {
      return false;
    }
  }
}
