import 'package:app_presensi/app/models/ujian.dart';
import 'package:app_presensi/resources/utils/static.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ContentUjian extends StatelessWidget {
  const ContentUjian({
    Key? key,
    required this.data,
  }) : super(key: key);

  final List<ModelUjian> data;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(left: 19, right: 19),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) => Container(
          height: 12.6,
        ),
        itemCount: data.length,
        itemBuilder: (context, i) {
          return Container(
            height: 106,
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
                  height: 85,
                  width: 85,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3.15),
                  ),
                  child: icons(nama: data[i].name ?? ""),
                ),
                const SizedBox(
                  width: 12.6,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data[i].name ?? "",
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Roboto",
                      ),
                    ),
                    Text(
                      "Jam ${DateFormat("HH:mm").format(DateTime.parse(data[i].date ?? DateTime.now().toString()))} WIB",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Roboto",
                      ),
                    ),
                    Text(
                      "Tanggal ${DateFormat("yyyy - MM - dd").format(DateTime.parse(data[i].date ?? DateTime.now().toString()))}",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Roboto",
                      ),
                    ),
                    Text(
                      data[i].type ?? "UTS",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Roboto",
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
