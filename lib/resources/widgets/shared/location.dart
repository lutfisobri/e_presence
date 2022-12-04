import 'package:app_presensi/resources/utils/static.dart';
import 'package:app_presensi/resources/widgets/shared/button.dart';
import 'package:flutter/material.dart';

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
                  child: Button(
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