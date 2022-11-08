import 'dart:async';
import 'package:e_presence/core/providers/user_provider.dart';
import 'package:e_presence/core/services/validation.dart';
import 'package:e_presence/ui/shared/theme_data.dart';
import 'package:e_presence/ui/shared/widgets/button_elevated.dart';
import 'package:e_presence/ui/shared/widgets/dialog.dart';
import 'package:flutter/material.dart';
import 'package:e_presence/ui/shared/widgets/text_field.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});
  static const routeName = "/changePassword";

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController pwLama = TextEditingController();
  final TextEditingController pwBaru = TextEditingController();
  final TextEditingController confpwBaru = TextEditingController();
  final styleThemeData = StyleThemeData();
  String deviceId = "";

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  loadProfile() async {
    String? deviceID = await PlatformDeviceId.getDeviceId;
    setState(() {
      deviceId = deviceID ?? "";
    });
    user().checkAccount();
    // .then((value) {
    //   if (value == 401) {
    //     if (!mounted) return;
    //     Navigator.pushReplacementNamed(context, "/login");
    //     user().userClearData();
    //   } else if (value == 200) {
    //     return;
    //   }
    // });
  }

  UserControlProvider user() {
    return Provider.of<UserControlProvider>(context, listen: false);
  }

  clearText() {
    pwLama.clear();
    pwBaru.clear();
    confpwBaru.clear();
  }

  @override
  void dispose() {
    pwLama.dispose();
    pwBaru.dispose();
    confpwBaru.dispose();
    super.dispose();
  }

  btnChange() async {
    final user = Provider.of<UserControlProvider>(context, listen: false);
    await user.changePassword(pwBaru.text).then((value) {
      if (value) {
        showDialog(
          context: context,
          builder: (context) => const CustomDialog(
            title: "Berhasil",
            subtitle: "Woah, Kata Sandi anda berhasil diubah",
            image: "assets/icons/sukses.png",
          ),
        );
        user.userLogin(user.dataUser.username, pwBaru.text, deviceId);
        Timer(
          const Duration(milliseconds: 500),
          () => clearText(),
        );
        // clearText();
      } else {
        showDialog(
          context: context,
          builder: (context) => const CustomDialog(
            title: "Gagal Tersimpan",
            subtitle: "Periksa Kembali Kata Sandi Anda",
            image: "assets/icons/gagal.png",
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Ubah Kata Sandi",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: false,
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  WidgetTextField(
                    controller: pwLama,
                    type: TextInputType.visiblePassword,
                    obscure: true,
                    label: const Text(
                      "Password Lama*",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    sufixIcon1: const Icon(
                      Icons.visibility_off,
                      color: Colors.black,
                    ),
                    sufixIcon2: const Icon(
                      Icons.visibility,
                      color: Colors.black,
                    ),
                    primaryColor: Colors.black,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  WidgetTextField(
                    controller: pwBaru,
                    obscure: true,
                    type: TextInputType.visiblePassword,
                    label: const Text(
                      "Password Baru*",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    sufixIcon1: const Icon(
                      Icons.visibility_off,
                      color: Colors.black,
                    ),
                    sufixIcon2: const Icon(
                      Icons.visibility,
                      color: Colors.black,
                    ),
                    primaryColor: Colors.black,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  WidgetTextField(
                    controller: confpwBaru,
                    obscure: true,
                    type: TextInputType.visiblePassword,
                    label: const Text(
                      "Konfirmasi Password Baru*",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    sufixIcon1: const Icon(
                      Icons.visibility_off,
                      color: Colors.black,
                    ),
                    sufixIcon2: const Icon(
                      Icons.visibility,
                      color: Colors.black,
                    ),
                    primaryColor: Colors.black,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 16.5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      WidgetEleBtn(
                        onPres: () {
                          FocusManager.instance.primaryFocus!.unfocus();
                          var check = passwordIsSame(
                            pwLama.text,
                            pwBaru.text,
                            confpwBaru.text,
                          );
                          if (!check) {
                            showDialog(
                              context: context,
                              builder: (context) => const CustomDialog(
                                title: "Gagal Tersimpan",
                                subtitle: "Periksa Kembali Kata Sandi Anda",
                                image: "assets/icons/gagal.png",
                              ),
                            );
                            return;
                          }
                          final user = Provider.of<UserControlProvider>(context,
                              listen: false);
                          if (pwLama.text != user.dataUser.password) {
                            showDialog(
                              context: context,
                              builder: (context) => const CustomDialog(
                                title: "Gagal Tersimpan",
                                subtitle: "Periksa Kembali Kata Sandi Anda",
                                image: "assets/icons/gagal.png",
                              ),
                            );
                            return;
                          }
                          btnChange();
                          // connectionError(context);
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.77),
                        ),
                        minimunSize: const Size(109, 46),
                        textStyle: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                        child: const Text("UBAH"),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
