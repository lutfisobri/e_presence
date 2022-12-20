import 'dart:async';
import 'dart:convert';
import 'package:app_presensi/app/providers/user.dart';
import 'package:app_presensi/resources/widgets/shared/button.dart';
import 'package:app_presensi/resources/widgets/shared/notification.dart';
import 'package:app_presensi/resources/widgets/shared/text_fields.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VerificationOTP extends StatefulWidget {
  const VerificationOTP({super.key});

  @override
  State<VerificationOTP> createState() => _VerificationOTPState();
}

class _VerificationOTPState extends State<VerificationOTP> {
  TextEditingController otp1 = TextEditingController();
  TextEditingController otp2 = TextEditingController();
  TextEditingController otp3 = TextEditingController();
  TextEditingController otp4 = TextEditingController();
  @override
  void initState() {
    super.initState();
    timeSendBack();
  }

  @override
  void dispose() {
    otp1.dispose();
    otp2.dispose();
    otp3.dispose();
    otp4.dispose();
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        timer.cancel();
      },
    );
    super.dispose();
  }

  int detik = 0;
  int counter = 1;

  timeSendBack() {
    var times = 60 * counter;
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        timer.tick;
        times--;
        if (!mounted) return;
        setState(() {
          detik = times;
        });
        if (times == 0) {
          timer.cancel();
        }
      },
    );
  }

  Map<String, dynamic> dataUser = {};
  bool isLoading = false;

  loadData() {
    final args = ModalRoute.of(context)!.settings.arguments;
    Map<String, dynamic> user = jsonDecode(jsonEncode(args));
    String email = user['email'];
    var splitted = email.split("@");
    var part1 = splitted[0];
    var avg = part1.length / 2;
    part1 = part1.substring(0, (part1.length - avg).toInt());
    var part2 = splitted[1];
    var bintang = "";
    for (var i = 0; i < avg.toInt(); i++) {
      bintang += '*';
    }
    setState(() {
      dataUser = user;
    });
    return "$part1$bintang@$part2";
  }

  dialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => WillPopScope(
        onWillPop: () async => false,
        child: const DialogOTP(),
      ),
    );
  }

  verification(String otp) async {
    print(dataUser);
    if (otp.isEmpty) {
      dialog();
      setState(() {
        isLoading = false;
      });
      Timer(
        Duration(seconds: 2),
        () => Navigator.pop(context),
      );
      return;
    }
    final userProv = Provider.of<UserProvider>(context, listen: false);
    await userProv.verificationOTP(otp, dataUser['nis']).then((value) {
      print(value);
      if (value == 200) {
        setState(() {
          isLoading = false;
        });
        Navigator.pushReplacementNamed(context, "/forgotChangePassword",
            arguments: dataUser);
      } else if (value == 401) {
        dialog();
        setState(() {
          isLoading = false;
        });
        Timer(
          const Duration(seconds: 2),
          () {
            Navigator.pop(context);
          },
        );
        return;
      } else if (value == 410) {
        dialog();
        setState(() {
          isLoading = false;
        });
        Timer(
          const Duration(seconds: 2),
          () {
            Navigator.pop(context);
          },
        );
        return;
      } else {
        dialog();
        setState(() {
          isLoading = false;
        });
        Timer(
          const Duration(seconds: 2),
          () {
            Navigator.pop(context);
          },
        );
        return;
      }
    });
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text("Cari Akun"),
            elevation: 0,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Text(
                  "Isi dengan kode OTP yang dikirim ke: ${loadData()}",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Roboto",
                  ),
                ),
                const SizedBox(
                  height: 34,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 45,
                      child: WtextField(
                        type: TextInputType.number,
                        controller: otp1,
                        counterText: "",
                        maxlenght: 1,
                        onChanged: (value) {
                          if (value.length > 1 || value.isNotEmpty) {
                            FocusManager.instance.primaryFocus!.nextFocus();
                          }
                        },
                        textalign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      width: 45,
                      child: WtextField(
                        type: TextInputType.number,
                        controller: otp2,
                        counterText: "",
                        maxlenght: 1,
                        onChanged: (value) {
                          if (value.length > 1 || value.isNotEmpty) {
                            FocusManager.instance.primaryFocus!.nextFocus();
                          } else if (value.length <= 1) {
                            FocusManager.instance.primaryFocus!.previousFocus();
                          }
                        },
                        textalign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      width: 45,
                      child: WtextField(
                        type: TextInputType.number,
                        controller: otp3,
                        counterText: "",
                        maxlenght: 1,
                        onChanged: (value) {
                          if (value.length > 1 || value.isNotEmpty) {
                            FocusManager.instance.primaryFocus!.nextFocus();
                          } else if (value.length <= 1) {
                            FocusManager.instance.primaryFocus!.previousFocus();
                          }
                        },
                        textalign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      width: 45,
                      child: WtextField(
                        type: TextInputType.number,
                        controller: otp4,
                        counterText: "",
                        maxlenght: 1,
                        onChanged: (value) {
                          if (value.length > 1 || value.isNotEmpty) {
                            FocusManager.instance.primaryFocus!.unfocus();
                          } else if (value.length <= 1) {
                            FocusManager.instance.primaryFocus!.previousFocus();
                          }
                        },
                        textalign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 36.03,
                ),
                Row(
                  children: const [
                    Text(
                      "Tidak menerima kode OTP?",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0XFF999999),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    counter > 3
                        ? Text(
                            "Kirim Ulang kode OTP",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0XFF999999),
                            ),
                          )
                        : detik == 0
                            ? GestureDetector(
                                onTap: () {
                                  setState(() {
                                    counter++;
                                  });
                                  FocusManager.instance.primaryFocus!.unfocus();
                                  final user = Provider.of<UserProvider>(
                                      context,
                                      listen: false);
                                  user.sendMail(
                                    dataUser['nis'],
                                    dataUser['email'],
                                  );
                                  timeSendBack();
                                },
                                child: Text(
                                  "Kirim Ulang kode OTP",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.blue,
                                  ),
                                ),
                              )
                            : Text(
                                "Kirim Ulang kode OTP dalam $detik detik lagi",
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0XFF999999),
                                ),
                              ),
                  ],
                ),
                const SizedBox(
                  height: 10.97,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Button(
                        minimunSize: const Size(double.infinity, 42),
                        onPres: () {
                          setState(() {
                            isLoading = true;
                          });
                          verification(
                            otp1.text + otp2.text + otp3.text + otp4.text,
                          );
                        },
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.53125,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: const Text("KONFIRMASI OTP"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (isLoading)
          Container(
            alignment: Alignment.center,
            color: Colors.white.withOpacity(0.3),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/loading/sepeda.gif",
                  width: 100,
                  height: 100,
                ),
                // CircularProgressIndicator(),
                const SizedBox(
                  height: 2.63,
                ),
                const Text(
                  "Tunggu Proses",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Poppins"),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
