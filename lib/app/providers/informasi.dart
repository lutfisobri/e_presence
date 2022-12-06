import 'package:app_presensi/app/api/informasi.dart';
import 'package:app_presensi/app/models/informasi.dart';
import 'package:flutter/widgets.dart';

class InformasiProvider extends ChangeNotifier {
  List<ModelInformasi> informasi = [];

  getData() async {
    Iterable iterable = await getInformasi();
    informasi = iterable.map((e) => ModelInformasi.formJson(e)).toList();
    notifyListeners();
  }

  ModelInformasi find(String id) {
    return informasi.firstWhere((element) => element.id == id);
  }
}
