import 'dart:io';

import 'package:app_presensi/app/providers/pelajaran.dart';
import 'package:app_presensi/app/providers/user.dart';
import 'package:app_presensi/resources/widgets/shared/notification.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:ntp/ntp.dart';
import 'package:provider/provider.dart';

class UtilsPresensi {
  static Future<bool> validationTime(
      DateTime jamAwal, DateTime jamAkhir) async {
    final int offset = await NTP.getNtpOffset(
      localTime: DateTime.now(),
      lookUpAddress: "0.id.pool.ntp.org",
    );
    DateTime internetTime = DateTime.now().add(Duration(milliseconds: offset));
    if (internetTime.isBefore(jamAwal)) return false;
    if (internetTime.isAfter(jamAkhir)) return false;
    return true;
  }

  static void validation(BuildContext context) async {
    final user = Provider.of<UserProvider>(context, listen: false);
    final pelProv = Provider.of<PelajaranProvider>(context, listen: false);
    pelProv.allPresensi(
        idKelasAjaran: user.dataUser.idKelasAjaran!,
        nis: user.dataUser.username);
  }

  static void checkImage(File? image) {
    if (image == null) {
      return;
    }
  }

  static void hasPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    do {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        Geolocator.openLocationSettings();
      }
    } while (!serviceEnabled);
  }

  static dialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const CustomDialog(
          title: "LOKASI",
          subtitle: "Mohon Aktifkan Lokasi",
          image: "assets/icons/gagal.png"),
    );
  }

  static Future<File?> cropImage({required File imageFile}) async {
    try {
      CroppedFile? croppedImage = await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        maxHeight: 1080,
        maxWidth: 1080,
        aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Sunting Foto',
              toolbarColor: Colors.black,
              toolbarWidgetColor: Colors.white,
              backgroundColor: Colors.black,
              statusBarColor: Colors.white,
              dimmedLayerColor: Colors.black,
              cropFrameColor: Colors.white,
              cropGridColor: Colors.white,
              activeControlsWidgetColor: const Color.fromRGBO(104, 187, 97, 1),
              showCropGrid: true,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Sunting Foto',
          ),
        ],
      );
      if (croppedImage != null) {
        return File(croppedImage.path);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}

class ListModelPresensi {
  final String data;
  ListModelPresensi(
    this.data,
  );
}

Widget h20() {
  return const SizedBox(
    height: 20,
  );
}