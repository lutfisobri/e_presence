import 'package:app_presensi/resources/widgets/shared/button.dart';
import 'package:flutter/material.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: 0.6,
        maxChildSize: 0.9,
        minChildSize: 0.6,
        expand: false,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: Stack(
              children: [
                Positioned(
                  top: -15,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.black,
                    ),
                  ),
                ),
                Column(children: [
                  Container(
                    margin: const EdgeInsets.only(top: 11),
                    alignment: AlignmentDirectional.topCenter,
                    clipBehavior: Clip.none,
                    width: 60,
                    height: 3,
                    color: Color.fromRGBO(208, 211, 216, 1),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 28),
                    child: Image.asset(
                      'assets/image/no_internet1.png',
                      width: 240,
                      height: 234.86,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: const Text(
                      'Tidak Ada Koneksi Internet',
                      style: TextStyle(
                        color: Color.fromRGBO(114, 182, 108, 1),
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 6),
                    child: const Text(
                      'Mohon Periksa Kembali Koneksi\nInternet Anda.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromRGBO(100, 97, 97, 1),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 19, right: 19),
                    child: Row(
                      children: [
                        Expanded(
                          child: Button(
                            onPres: () async {
                              Navigator.pop(context);
                            },
                            minimunSize: const Size(248, 41),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                            ),
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                            child: const Text("COBA LAGI"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ])
              ],
            ),
          );
        });
  }
}
