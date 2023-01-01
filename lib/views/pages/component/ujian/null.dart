import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NullJadwalUjian extends StatelessWidget {
  const NullJadwalUjian({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(
            top: 225,
            left: 85,
            right: 85,
          ),
          child: Image.asset(
            "assets/image/no_ujian.png",
            height: 114.53,
          ),
        ),
        Text(
          "Tidak Ada Ujian",
          style: TextStyle(
            fontSize: 17.sp,
            color: const Color.fromRGBO(114, 182, 108, 1),
            fontWeight: FontWeight.w800,
            fontFamily: "poppins",
          ),
        ),
        Text(
          "Mohon Periksa Secara Berkala Untuk",
          style: TextStyle(
            fontSize: 14.sp,
            color: const Color.fromRGBO(100, 97, 97, 1),
            fontWeight: FontWeight.w600,
            fontFamily: "poppins",
          ),
        ),
        Text(
          "Informasi selanjutnya",
          style: TextStyle(
            fontSize: 14.sp,
            color: const Color.fromRGBO(100, 97, 97, 1),
            fontWeight: FontWeight.w600,
            fontFamily: "poppins",
          ),
        )
      ],
    ));
  }
}
