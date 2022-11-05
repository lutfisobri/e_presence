import 'dart:async';

import 'package:e_presence/core/providers/user_provider.dart';
import 'package:e_presence/ui/shared/widgets/button_elevated.dart';
import 'package:e_presence/ui/shared/widgets/dialog.dart';
import 'package:e_presence/ui/shared/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class LupaPassword extends StatefulWidget {
  const LupaPassword({super.key});
  static const routeName = "/lupaPassword";

  @override
  State<LupaPassword> createState() => _LupaPasswordState();
}

class _LupaPasswordState extends State<LupaPassword> {
  TextEditingController username = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  void dispose() {
    focusNode.dispose();
    username.dispose();
    FocusManager.instance.primaryFocus?.unfocus();
    super.dispose();
  }

  bool isAccount = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserControlProvider>(context, listen: false);
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
                          WidgetTextField(
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
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: WidgetEleBtn(
                                  onPres: () {},
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
                          WidgetTextField(
                            controller: username,
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
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                child: WidgetEleBtn(
                                  minimunSize: const Size(double.infinity, 41),
                                  onPres: () {
                                    btnSearch(context, user);
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
      ),
    );
  }

  void btnSearch(BuildContext context, UserControlProvider user) {
    setState(() {
      isLoading = true;
    });

    FocusManager.instance.primaryFocus?.unfocus();
    if (username.text == "" || username.text.isEmpty) {
      Timer(
        Duration.zero,
        () {
          setState(() {
            isLoading = false;
            showDialog(
              context: context,
              builder: (context) => const CustomDialog(
                title: "Username Tidak Ditemukan",
                subtitle: "Masukkan Kembali Username Anda",
                image: "assets/icons/gagal.png",
              ),
            );
          });
        },
      );
      return;
    }
    user.searchAccount(username.text).then((value) {
      if (value['username'] == "") {
        Timer(
          const Duration(milliseconds: 300),
          () {
            setState(() {
              showDialog(
                context: context,
                builder: (context) => const CustomDialog(
                  title: "Username Tidak Ditemukan",
                  subtitle: "Masukkan Kembali Username Anda",
                  image: "assets/icons/gagal.png",
                ),
              );
              isLoading = false;
            });
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
                builder: (context) => const CustomDialog(
                  title: "Terjadi Kesalahan",
                  subtitle: "Periksa Kembali E-mail Anda",
                  image: "assets/icons/gagal.png",
                ),
              );
              isLoading = false;
            });
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
              username.text = value['email'];
            });
          },
        );
      }
    });
  }
}
