import 'package:flutter/material.dart';

Future<dynamic> serviceCamera(
  BuildContext context, {
  required String type,
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
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 25),
              child: Text(
                type,
                style: const TextStyle(
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
