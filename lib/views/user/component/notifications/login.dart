import 'package:flutter/material.dart';

class CustomDialogLogin extends StatelessWidget {
  const CustomDialogLogin({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        height: 320,
        color: Colors.transparent,
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 64.79),
              height: 171.46,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(14)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: Text(
                      "Nama Pengguna Atau Kata Sandi",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 3),
                    child: Text(
                      "Masukkan Kembali Nama Pengguna dan Kata Sandi Anda",
                      textAlign: TextAlign.center,
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
            Positioned.fill(
              top: -185,
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: 100,
                  height: 99.69,
                  padding: const EdgeInsets.symmetric(
                    vertical: 4.15,
                    horizontal: 4.17,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Image.asset(
                    "assets/icons/gagal.png",
                    width: 91.67,
                    height: 91.38,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}