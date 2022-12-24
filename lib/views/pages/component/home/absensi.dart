import 'package:app_presensi/app/providers/pelajaran.dart';
import 'package:app_presensi/resources/utils/static.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ContentPresensi extends StatelessWidget {
  const ContentPresensi({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PelajaranProvider>(
      builder: (context, value, child) {
        return ListView.separated(
          separatorBuilder: (context, index) => Container(
            height: 12.6,
          ),
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.only(
            left: 19,
            right: 19,
          ),
          shrinkWrap: true,
          itemCount: value.listPresensi.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  "/detailPresensi",
                  arguments: value.listPresensi[index].idPresensi,
                );
              },
              child: Container(
                height: 56.6,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0XFF909090).withOpacity(0.20),
                      offset: const Offset(0, 1),
                      blurRadius: 2,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                          top: 10.8, left: 12.6, bottom: 10.8),
                      height: 35,
                      width: 35,
                      child: iconMapel(value, index, jenis: Pelajaran.presensi),
                    ),
                    const SizedBox(
                      width: 12.6,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          value.listPresensi[index].namaMapel!,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Roboto",
                          ),
                        ),
                        Text(
                          "Jam ${DateFormat('hh:mm', 'id_ID').format(
                            DateTime.parse(
                              value.listPresensi[index].mulaiPresensi!,
                            ),
                          )} - ${DateFormat('hh:mm', 'id_ID').format(
                            DateTime.parse(
                              value.listPresensi[index].akhirPresensi!,
                            ),
                          )} WIB",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Roboto",
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      }
    );
  }
}