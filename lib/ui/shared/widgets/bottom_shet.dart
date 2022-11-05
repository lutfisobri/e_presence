import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:e_presence/ui/shared/widgets/button_elevated.dart';
import 'package:e_presence/utils/static.dart';

Future<dynamic> updatePhoto(
  BuildContext context, {
  required void Function() kamera,
  required void Function() galeri,
  required void Function() hapus,
}) {
  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return SizedBox(
        height: 174,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 15, left: 25),
              child: Text(
                "Foto Profil",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Row(
                children: [
                  const SizedBox(
                    width: 25,
                  ),
                  Column(
                    children: [
                      InkWell(
                        onTap: kamera,
                        child: Image.asset(
                          "assets/icons/kamera.png",
                          height: 60,
                          width: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          "Kamera",
                          style: TextStyle(
                            color: Color(0XFF646161),
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Column(
                    children: [
                      InkWell(
                        onTap: galeri,
                        child: Image.asset(
                          "assets/icons/galeri.png",
                          height: 60,
                          width: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          "Galeri",
                          style: TextStyle(
                            color: Color(0XFF646161),
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Column(
                    children: [
                      InkWell(
                        onTap: hapus,
                        child: Image.asset(
                          "assets/icons/hapus.png",
                          height: 60,
                          width: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          "Hapus",
                          style: TextStyle(
                            color: Color(0XFF646161),
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      );
    },
  );
}

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
                    minimunSize: const Size(double.infinity, 41),
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
  showModalBottomSheet(
    context: context,
    builder: (context) => const SizedBox(),
  );
}
