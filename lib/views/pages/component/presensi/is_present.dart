import 'package:app_presensi/resources/utils/static.dart';
import 'package:app_presensi/views/pages/component/presensi/utils.dart';
import 'package:flutter/material.dart';

class IsPresent extends StatelessWidget {
  const IsPresent({
    Key? key,
    required ListModelPresensi? chose,
  }) : _chose = chose, super(key: key);

  final ListModelPresensi? _chose;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 200,
        width: double.infinity,
        child: Padding(
          padding:
              const EdgeInsets.only(
                  top: 20, bottom: 30),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment
                    .center,
            children: [
              Image.asset(
                "assets/image/imagePresensi.png",
                width: 70,
                height: 70,
              ),
              const Text(
                "Ambil bukti foto",
                style: TextStyle(
                  color: colorGreen,
                  fontSize: 18,
                  fontWeight:
                      FontWeight.w600,
                ),
              ),
              if (_chose!.data ==
                  "Sakit")
                const Text(
                  "*bukti berbentuk surat dokter",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight:
                        FontWeight.w300,
                    color: colorGreen,
                  ),
                )
            ],
          ),
        ),
      );
  }
}
