import 'package:e_presence/ui/shared/widgets/button_elevated.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.image,
  }) : super(key: key);
  final String title, subtitle, image;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        height: 219.31,
        color: Colors.transparent,
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 64.79),
              height: 171.46,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(14)),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                      child: Text(
                        subtitle,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0XFFD3DAE0),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
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
                    image,
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
        height: 219.31,
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
              top: -85,
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

class DialogButton extends StatelessWidget {
  const DialogButton({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.btnLeft,
    required this.btnRight,
    required this.onPresLeft,
    required this.onPresRight,
  }) : super(key: key);
  final String title, subtitle, btnLeft, btnRight;
  final void Function() onPresLeft, onPresRight;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14), color: Colors.white),
        height: 172,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              child: Text(
                title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(
              height: 9,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              child: Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0XFFD3DAE0),
                ),
              ),
            ),
            const SizedBox(
              height: 21,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 36,
                ),
                Expanded(
                  child: WidgetEleBtn(
                    onPres: onPresLeft,
                    minimunSize: const Size(double.infinity, 46),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.77),
                    ),
                    child: Text(btnLeft),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: OutlinedButton(
                    onPressed: onPresRight,
                    style: ButtonStyle(
                      minimumSize: const MaterialStatePropertyAll(
                        Size(double.infinity, 46),
                      ),
                      textStyle: const MaterialStatePropertyAll(
                        TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.77),
                        ),
                      ),
                    ),
                    child: Text(btnRight),
                  ),
                ),
                const SizedBox(
                  width: 36,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DialogEmail extends StatelessWidget {
  const DialogEmail({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.button,
  });
  final String title, subtitle, image;
  final Widget button;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        height: 219.31,
        color: Colors.transparent,
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 64.79),
              height: 171.46,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(14)),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(
                      height: 35.5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                      child: Text(
                        subtitle,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0XFFD3DAE0),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 19, right: 19),
                      child: Row(
                        children: [
                          Expanded(
                            child: button,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 15,
              left: 115.17,
              right: 115.17,
              child: Container(
                width: 91.67,
                height: 91.38,
                margin: const EdgeInsets.symmetric(
                  vertical: 4.15,
                  horizontal: 4.17,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Image.asset(
                  image,
                  width: 91.67,
                  height: 91.38,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
