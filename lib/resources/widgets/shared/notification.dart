import 'package:app_presensi/resources/widgets/shared/button.dart';
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
        height: 300,
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

class CustomDialogPresensi extends StatelessWidget {
  const CustomDialogPresensi({
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
                            "Bukti Foto Kosong",
                            textAlign: TextAlign.center,
                            style: TextStyle(
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
                        "Silahkan Ambil Bukti Foto",
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
                  "assets/icons/CameraPresensi.png",
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
        height: 290,
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

class DialogPasswordIsSame extends StatelessWidget {
  const DialogPasswordIsSame({
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
        color: Colors.transparent,
        child: Container(
          height: 171,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(14)),
          child: Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Stack(
                    children: [
                      Positioned(
                        left: 48,
                        top: 59.8,
                        child: Image.asset(
                          "assets/icons/gagal.png",
                          height: 21.92,
                          width: 21.97,
                        ),
                      ),
                      Container(
                        width: 70,
                        height: 99.69,
                        child: Image.asset(
                          "assets/icons/passwordSame.gif",
                          width: 74,
                          height: 74,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Text(
                              "Gagal Tersimpan",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 1.89,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          child: const Text(
                            "Sandi baru dan Sandi lama tidak boleh sama",
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
                        child: const Text("MASUKKAN ULANG"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DialogEmailIsSame extends StatelessWidget {
  const DialogEmailIsSame({
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
        color: Colors.transparent,
        child: Container(
          height: 171,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(14)),
          child: Column(
            children: [
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Image.asset(
                    "assets/icons/RobotEmail.png",
                    width: 74,
                    height: 74,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Gagal Tersimpan",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.89,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 3,
                          child: Text(
                            "Mohon maaf e-mail anda\ntelah digunakan",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Color(0XFFD3DAE0),
                              // overflow: TextOverflow.ellipsis,
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
              SizedBox(
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
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Roboto",
                          letterSpacing: 0.85,
                        ),
                        child: Text("MASUKKAN ULANG"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
