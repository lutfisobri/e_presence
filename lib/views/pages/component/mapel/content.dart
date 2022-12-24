import 'package:app_presensi/app/models/mapel.dart';
import 'package:app_presensi/app/providers/pelajaran.dart';
import 'package:app_presensi/resources/utils/static.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContentMapel extends StatelessWidget {
  const ContentMapel({
    Key? key,
    required this.data,
    required this.i,
  }) : super(key: key);

  final List<ModelMapel> data;
  final int i;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.6,
      width: double.infinity,
      padding: const EdgeInsets.only(left: 12.6, right: 12.6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0XFF909090).withOpacity(0.20),
            offset: const Offset(0, 1),
            blurRadius: 2,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.15),
            ),
            child:
                Consumer<PelajaranProvider>(builder: (context, pelProv, child) {
              return iconMapel(
                pelProv,
                i,
                jenis: Pelajaran.mapel,
              );
            }),
          ),
          const SizedBox(
            width: 12.6,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data[i].pelajaran!,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Roboto",
                ),
              ),
              Text(
                "Jam ${data[i].jamMulai} - ${data[i].jamSelesai} WIB",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Roboto",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
