import 'package:e_presence/ui/shared/widgets/button_elevated.dart';
import 'package:e_presence/utils/static.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

connectionError(BuildContext context) {
  showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    enableDrag: false,
    backgroundColor: const Color(0XFFFAFAFA),
    context: context,
    builder: (context) => SizedBox(
      height: 428.h,
      width: double.infinity,
      child: Column(
        children: [
          GestureDetector(
            child: const SizedBox(
              height: 11,
              width: 62,
              child: Padding(
                padding: EdgeInsets.only(top: 11),
                child: Divider(
                  thickness: 4,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 28.7,
          ),
          Image.asset(
            width: 240,
            height: 234.86,
            "assets/image/no_internet1.png",
          ),
          const SizedBox(
            height: 10.14,
          ),
          const Text(
            "Tidak Ada Koneksi Internet",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: colorGreen,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            "Mohon Periksa kembali Koneksi Internet Anda.",
            maxLines: 2,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0XFF646161),
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 19, right: 19),
                  child: WidgetEleBtn(
                    onPres: () {
                      Navigator.pop(context);
                    },
                    minimunSize: Size(double.infinity, 41),
                    textStyle: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Roboto",
                    ),
                    child: const Text("COBA LAGI"),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

connectionErrorHome(BuildContext context) {
  showModalBottomSheet(context: context, builder: (context) => SizedBox(),);
}