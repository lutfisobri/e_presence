import 'package:app_presensi/resources/widgets/shared/button.dart';
import 'package:flutter/material.dart';

class DialogSession extends StatelessWidget {
  const DialogSession({
    super.key,
    required this.onPress,
  });
  final void Function() onPress;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        // height: 210,
        color: Colors.transparent,
        child: Container(
          // height: 180,
          height: 171,

          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(14)),
          child: Column(
            children: [
              const SizedBox(
                height: 21.83,
              ),
              Row(
                children: [
                  Container(
                    width: 74,
                    height: 74,
                    padding: const EdgeInsets.symmetric(
                      vertical: 4.15,
                      horizontal: 4.17,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Image.asset(
                      "assets/icons/session.png",
                      width: 74,
                      height: 74,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Text(
                              "Peringatan ",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              "!!",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.red,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.46,
                          child: const Text(
                            "Perangkat Lain Telah Login di akun anda",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Color(0XFFD3DAE0),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 19),
                child: Row(
                  children: [
                    Expanded(
                      child: Button(
                        onPres: onPress,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.77),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Roboto",
                          letterSpacing: 0.85,
                        ),
                        child: const Text("KELUAR"),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 19.94,
              ),
            ],
          ),
        ),
      ),
    );
  }
}