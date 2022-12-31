import 'package:app_presensi/resources/widgets/shared/button.dart';
import 'package:flutter/material.dart';

class DialogSearchAccount extends StatelessWidget {
  const DialogSearchAccount({
    Key? key,
    required this.childbtn,
    required this.onTapbtn,
  }) : super(key: key);

  final void Function() onTapbtn;
  final Widget childbtn;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        height: 265,
        color: Colors.transparent,
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 64.79),
              height: 217,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(14)),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 44,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "Peringatan",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            "!!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                      child: Text(
                        "Harap Lapor ke pihak admin jika e-mail anda tidak bisa di akses",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0XFFD3DAE0),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 19),
                      child: Row(
                        children: [
                          Expanded(
                            child: Button(
                              onPres: onTapbtn,
                              textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "Roboto",
                                  letterSpacing: 1.5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7.77),
                              ),
                              child: childbtn,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned.fill(
              top: 15,
              child: Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  "assets/icons/admin.png",
                  width: 100,
                  height: 100,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}