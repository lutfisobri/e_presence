import 'package:app_presensi/app/api/pelajaran.dart';
import 'package:app_presensi/app/models/log_presensi.dart';
import 'package:app_presensi/app/models/mapel.dart';
import 'package:app_presensi/app/models/presensi.dart';
import 'package:app_presensi/app/models/ujian.dart';
import 'package:app_presensi/resources/utils/static.dart';
import 'package:flutter/cupertino.dart';
import 'package:ntp/ntp.dart';

class PelajaranProvider with ChangeNotifier {
  List<ModelPresensi> listPresensi = [];
  List<ModelMapel> listMapel = [];
  List<ModelUjian> listUjian = [];
  List<LogPresensi> log = [];

  allMapel({required String idKelasAjaran}) async {
    Iterable iterable = await ApiPelajaran.jadwalMapel(idKelasAjaran);
    listMapel = iterable.map((e) => ModelMapel.formJson(e)).toList();
    notifyListeners();
  }

  allUjian({required String idKelasAjaran}) async {
    Iterable iterable = await ApiPelajaran.jadwalUjian(idKelasAjaran);
    listUjian = iterable.map((e) => ModelUjian.formJson(e)).toList();
    notifyListeners();
  }

  allPresensi({required String idKelasAjaran, required String nis}) async {
    Iterable iterable = await ApiPelajaran.jadwalPresensi(idKelasAjaran);
    final int offset = await NTP.getNtpOffset(
      localTime: DateTime.now(),
      lookUpAddress: "0.id.pool.ntp.org",
    );

    DateTime internetTime = DateTime.now().add(Duration(milliseconds: offset));
    listPresensi = iterable
        .map((e) => ModelPresensi.formJson(e))
        .toList()
        .where((element) {
      return internetTime.isAfter(DateTime.parse(element.mulaiPresensi!)) &&
          internetTime.isBefore((DateTime.parse(element.akhirPresensi!)));
    }).toList();

    await logPresensi(nis: nis);

    for (var i = 0; i < log.length; i++) {
      for (var j = 0; j < listPresensi.length; j++) {
        if (log[i].idPresensi == listPresensi[j].idPresensi) {
          listPresensi.removeAt(j);
        }
      }
    }

    notifyListeners();
  }

  findPresensi({required String id}) {
    return listPresensi.firstWhere((element) => element.idPresensi == id);
  }

  submitPresensi(Map<String, dynamic> json) async {
    await ApiPelajaran.presensi({
      "id": json['id'],
      "nis": json['username'],
      "nama": json['nama'],
      "time": json['time'],
      "mapel": json['mapel'],
      "kelas": json['kelas'],
      "status": json['status'],
      "koordinat": json['koordinat'],
      "bukti": json['bukti'],
      "id_semester": json['id_semester'],
    });
  }

  logPresensi({required String nis}) async {
    Iterable iterable = await ApiPelajaran.logP(nis);
    log = iterable.map((e) => LogPresensi.fromJson(e)).toList();
    notifyListeners();
  }
}
