import 'package:app_presensi/app/providers/pelajaran.dart';
import 'package:app_presensi/resources/utils/static.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContentMapel extends StatelessWidget {
  ContentMapel({
    Key? key,
    required this.hari,
    required this.tickerProvider,
  }) : super(key: key);

  final String hari;
  final TickerProviderStateMixin tickerProvider;

  @override
  Widget build(BuildContext context) {
    return Consumer<PelajaranProvider>(builder: (_, __, ___) {
      return ListView.builder(
        clipBehavior: Clip.none,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.only(top: 12.6),
        itemCount: validationCount(__),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12.6),
            child: Container(
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
                    child: validationIcon(__, index),
                  ),
                  const SizedBox(
                    width: 12.6,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        validationPelajaran(__, index),
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Roboto",
                        ),
                      ),
                      Text(
                        validationJam(__, index),
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
            ),
          );
        },
      );
    });
  }

  Tab tabItems(String hari) {
    return Tab(
      child: Text(
        hari,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          fontFamily: "Roboto",
        ),
      ),
    );
  }

  validationCount(PelajaranProvider mapel) {
    switch (hari) {
      case "senin":
        return mapel.mapelSenin.length;
      case "selasa":
        return mapel.mapelSelasa.length;
      case "rabu":
        return mapel.mapelRabu.length;
      case "kamis":
        return mapel.mapelKamis.length;
      case "jumat":
        return mapel.mapelJumat.length;
      default:
        return mapel.mapelSenin.length;
    }
  }

  validationIcon(PelajaranProvider mapel, int index) {
    switch (hari) {
      case "senin":
        return icons(nama: mapel.mapelSenin[index].pelajaran!);
      case "selasa":
        return icons(nama: mapel.mapelSelasa[index].pelajaran!);
      case "rabu":
        return icons(nama: mapel.mapelRabu[index].pelajaran!);
      case "kamis":
        return icons(nama: mapel.mapelKamis[index].pelajaran!);
      case "jumat":
        return icons(nama: mapel.mapelJumat[index].pelajaran!);
      default:
        return icons(nama: mapel.mapelSenin[index].pelajaran!);
    }
  }

  validationPelajaran(PelajaranProvider mapel, int index) {
    switch (hari) {
      case "senin":
        return mapel.mapelSenin[index].pelajaran!;
      case "selasa":
        return mapel.mapelSelasa[index].pelajaran!;
      case "rabu":
        return mapel.mapelRabu[index].pelajaran!;
      case "kamis":
        return mapel.mapelKamis[index].pelajaran!;
      case "jumat":
        return mapel.mapelJumat[index].pelajaran!;
      default:
        return mapel.mapelSenin[index].pelajaran!;
    }
  }

  validationJam(PelajaranProvider mapel, int index) {
    switch (hari) {
      case "senin":
        return "Jam ${mapel.mapelSenin[index].jamMulai} - ${mapel.mapelSenin[index].jamSelesai} WIB";
      case "selasa":
        return "Jam ${mapel.mapelSelasa[index].jamMulai} - ${mapel.mapelSelasa[index].jamSelesai} WIB";
      case "rabu":
        return "Jam ${mapel.mapelRabu[index].jamMulai} - ${mapel.mapelRabu[index].jamSelesai} WIB";
      case "kamis":
        return "Jam ${mapel.mapelKamis[index].jamMulai} - ${mapel.mapelKamis[index].jamSelesai} WIB";
      case "jumat":
        return "Jam ${mapel.mapelJumat[index].jamMulai} - ${mapel.mapelJumat[index].jamSelesai} WIB";
      default:
        return "Jam ${mapel.mapelSenin[index].jamMulai} - ${mapel.mapelSenin[index].jamSelesai} WIB";
    }
  }
}
