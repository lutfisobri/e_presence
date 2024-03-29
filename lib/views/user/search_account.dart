import 'dart:async';
import 'package:app_presensi/app/providers/user.dart';
import 'package:app_presensi/app/services/validation.dart';
import 'package:app_presensi/resources/widgets/shared/button.dart';
import 'package:app_presensi/resources/widgets/shared/notification.dart';
import 'package:app_presensi/resources/widgets/shared/text_fields.dart';
import 'package:app_presensi/views/user/component/notifications/search_account.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

import 'component/login/is_online.dart';

class LupaPassword extends StatefulWidget {
  const LupaPassword({super.key});
  static const routeName = "/lupaPassword";

  @override
  State<LupaPassword> createState() => _LupaPasswordState();
}

class _LupaPasswordState extends State<LupaPassword> {
  late StreamSubscription<InternetConnectionStatus> listener;
  bool isOnline = false;

  void hasConnect() async {
    listener = InternetConnectionChecker().onStatusChange.listen(
      (InternetConnectionStatus status) {
        switch (status) {
          case InternetConnectionStatus.connected:
            setState(() {
              isOnline = true;
            });
            break;
          case InternetConnectionStatus.disconnected:
            if (!mounted) return;
            setState(() {
              isOnline = false;
            });
            break;
        }
      },
    );
  }

  void init() async {
    bool check = await InternetConnectionChecker().hasConnection;
    if (!mounted) return;
    setState(() {
      isOnline = check;
    });
    if (isOnline) {
    } else {
      _noInternet();
    }
  }

  @override
  void initState() {
    super.initState();
    init();
    hasConnect();
  }

  void _noInternet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      )),
      builder: (context) => const NoInternet(),
    );
  }

  TextEditingController username = TextEditingController();
  FocusNode focusNode = FocusNode();
  Map<String, dynamic> dataUser = {};
  bool isAccount = false;
  bool isLoading = false;

  @override
  void dispose() {
    focusNode.dispose();
    username.dispose();
    FocusManager.instance.primaryFocus?.unfocus();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false);
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              title: const Text("Cari Akun"),
              elevation: 0,
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
            ),
            body: SafeArea(
              child: Container(
                padding: EdgeInsets.only(left: 20.r, right: 20.r, top: 24),
                child: isAccount
                    ? Column(
                        children: [
                          const Text(
                            "Akun anda telah ditemukan, kirim verifikasi melalui email*",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                fontFamily: "Roboto"),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          WtextField(
                            controller: username,
                            focusNode: focusNode,
                            enable: false,
                            contenH: 15,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                            ),
                            enableBorder: const OutlineInputBorder(),
                            primaryColor: const Color(0XFF0B0B0B),
                          ),
                          const SizedBox(
                            height: 6.03,
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) => WillPopScope(
                                      onWillPop: () async => false,
                                      child: DialogSearchAccount(
                                        onTapbtn: () {
                                          Navigator.pop(context);
                                        },
                                        childbtn: const Text(
                                          "LAPORKAN",
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "E-mail sudah tidak bisa diakses?",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 6.97,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Button(
                                  onPres: () {
                                    btnConfirm(user);
                                  },
                                  minimunSize: const Size(double.infinity, 41),
                                  textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Roboto",
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7)),
                                  child: const Text("KIRIM VERIFIKASI"),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutofillGroup(
                            child: WtextField(
                              controller: username,
                              autofillHints: const [AutofillHints.username],
                              focusNode: focusNode,
                              label: const Text(
                                "Masukkan Nama Pengguna Anda",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0XFF838383),
                                ),
                              ),
                              contenH: 15,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7.r),
                              ),
                              enableBorder: const OutlineInputBorder(),
                              primaryColor: const Color(0XFF0B0B0B),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Button(
                                  minimunSize: const Size(double.infinity, 41),
                                  onPres: () {
                                    btnSearch(user);
                                  },
                                  textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Roboto",
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  child: const Text("CARI"),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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
                      fontFamily: "Poppins",
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  btnConfirm(UserProvider user) async {
    bool check = await InternetConnectionChecker().hasConnection;
    if (!mounted) return;
    setState(() {
      isOnline = check;
    });
    setState(() {
      isLoading = true;
    });
    bool emailisValid = emailValidation(dataUser['email']);
    if (isOnline) {
      if (!emailisValid) {
        setState(() {
          isLoading = false;
        });
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => WillPopScope(
            onWillPop: () async => false,
            child: const CustomDialog(
                title: "Terjadi Kesalahan",
                subtitle: "Periksa kembali E-mail Anda",
                image: "assets/icons/gagal.png"),
          ),
        );
        Timer(
          const Duration(seconds: 2),
          () {
            Navigator.pop(context);
          },
        );
        return;
      }
      user.sendMail(dataUser['nis'], dataUser['email']).then((value) {
        if (value) {
          setState(() {
            isLoading = false;
          });
          Navigator.pushReplacementNamed(
            context,
            "/verificationOTP",
            arguments: dataUser,
          );
        } else {
          setState(() {
            isLoading = false;
          });
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => WillPopScope(
              onWillPop: () async => false,
              child: const CustomDialog(
                  title: "Terjadi Kesalahan",
                  subtitle: "Periksa kembali E-mail Anda",
                  image: "assets/icons/gagal.png"),
            ),
          );
          Timer(
            const Duration(seconds: 2),
            () {
              Navigator.pop(context);
            },
          );
        }
      });
    } else {
      _noInternet();
      setState(() {
        isLoading = false;
      });
    }
  }

  void btnSearch(UserProvider user) {
    setState(() {
      isLoading = true;
    });

    FocusManager.instance.primaryFocus?.unfocus();
    if (isOnline) {
      if (username.text == "" || username.text.isEmpty) {
        Timer(
          Duration.zero,
          () {
            setState(() {
              isLoading = false;
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => WillPopScope(
                  onWillPop: () async => false,
                  child: const CustomDialog(
                    title: "Username Tidak Ditemukan",
                    subtitle: "Masukkan Kembali Username Anda",
                    image: "assets/icons/gagal.png",
                  ),
                ),
              );
              Timer(
                const Duration(seconds: 2),
                () => Navigator.pop(context),
              );
            });
          },
        );
        return;
      }
      user.searchAccount(username.text).then(
        (value) {
          if (value['nis'] == "") {
            Timer(
              const Duration(milliseconds: 300),
              () {
                setState(() {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => WillPopScope(
                      onWillPop: () async => false,
                      child: const CustomDialog(
                        title: "Username Tidak Ditemukan",
                        subtitle: "Masukkan Kembali Username Anda",
                        image: "assets/icons/gagal.png",
                      ),
                    ),
                  );
                  isLoading = false;
                });
                Timer(
                  const Duration(seconds: 2),
                  () => Navigator.pop(context),
                );
              },
            );
            return;
          }
          if (value['email'] == null || value['email'] == "") {
            Timer(
              const Duration(milliseconds: 500),
              () {
                setState(() {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => WillPopScope(
                      onWillPop: () async => false,
                      child: const CustomDialog(
                        title: "Terjadi Kesalahan",
                        subtitle: "Usernmae Tidak Memiliki E-mail",
                        image: "assets/icons/gagal.png",
                      ),
                    ),
                  );
                  isLoading = false;
                });
                Timer(
                  const Duration(seconds: 2),
                  () => Navigator.pop(context),
                );
              },
            );
            return;
          } else {
            Timer(
              const Duration(milliseconds: 500),
              () {
                setState(() {
                  isAccount = true;
                  isLoading = false;
                  username.text = value['email'].toString();
                  dataUser = value;
                });
              },
            );
          }
        },
      );
    } else {
      _noInternet();
      setState(() {
        isLoading = false;
      });
    }
  }
}
