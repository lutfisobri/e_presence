import 'package:app_presensi/app/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopBarMain extends StatelessWidget {
  const TopBarMain({
    Key? key,
  }) : super(key: key);

  String greeting() {
      var hour = DateTime.now().hour;
      if (hour >= 4 && hour < 10) {
        return 'Pagi';
      }
      if (hour >= 10 && hour < 14) {
        return 'Siang';
      }
      if (hour >= 14 && hour < 18) {
        return 'Sore';
      }
      return 'Malam';
    }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, value, child) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 320,
                  child: Text(
                    "Selamat ${greeting()}, ${value.dataUser.nama}",
                    overflow: TextOverflow.visible,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Text(
                  value.dataUser.kelas == ""
                      ? "Loading"
                      : "Kelas ${value.dataUser.kelas}",
                  style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
