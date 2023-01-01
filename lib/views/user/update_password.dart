import 'dart:async';
import 'package:app_presensi/app/providers/user.dart';
import 'package:app_presensi/app/services/validation.dart';
import 'package:app_presensi/resources/widgets/shared/button.dart';
import 'package:app_presensi/resources/widgets/shared/notification.dart';
import 'package:app_presensi/resources/widgets/shared/notifications/session.dart';
import 'package:app_presensi/resources/widgets/shared/text_fields.dart';
import 'package:app_presensi/resources/widgets/shared/theme.dart';
import 'package:app_presensi/views/user/component/UpdatePassword/skeleton.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:provider/provider.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});
  static const routeName = "/changePassword";

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  late StreamSubscription<InternetConnectionStatus> listener;
  bool isOnline = false;

  void hasConnect() async {
    listener = InternetConnectionChecker().onStatusChange.listen(
      (InternetConnectionStatus status) {
        switch (status) {
          case InternetConnectionStatus.connected:
            if (!mounted) return;
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
      loadProfile();
    }
  }

  final TextEditingController pwLama = TextEditingController();
  final TextEditingController pwBaru = TextEditingController();
  final TextEditingController confpwBaru = TextEditingController();
  final styleThemeData = StyleThemeData();
  String deviceId = "";

  @override
  void initState() {
    super.initState();
    hasConnect();
    init();
  }

  loadProfile() async {
    final user = Provider.of<UserProvider>(context, listen: false);
    String? deviceID = await PlatformDeviceId.getDeviceId;
    setState(() {
      deviceId = deviceID ?? "";
    });
    bool isLogin = await user.checkAccount().then((value) => value);
    if (!isLogin) {
      if (!mounted) return;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => WillPopScope(
          onWillPop: () async => false,
          child: DialogSession(
            onPress: () {
              Navigator.popUntil(context, (route) => route.isFirst);
              Navigator.pushReplacementNamed(context, "/login");
            },
          ),
        ),
      );
    }
  }

  UserProvider user() {
    return Provider.of<UserProvider>(context, listen: false);
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
    final user = Provider.of<UserProvider>(context, listen: false);
    await user
        .changePassword(password: pwLama.text, newPassword: pwBaru.text)
        .then((value) {
      if (value) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => WillPopScope(
            onWillPop: () async => false,
            child: const CustomDialog(
              title: "Berhasil",
              subtitle: "Woah, Kata Sandi anda berhasil diubah",
              image: "assets/icons/sukses.png",
            ),
          ),
        );
        user.login(
            username: user.dataUser.username,
            password: pwBaru.text,
            deviceId: deviceId);
        Timer(
          const Duration(seconds: 2),
          () {
            clearText();
            Navigator.pop(context);
            Navigator.pop(context);
          },
        );
        // clearText();
      } else {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => WillPopScope(
            onWillPop: () async => false,
            child: const CustomDialog(
              title: "Gagal Tersimpan",
              subtitle: "Periksa Kembali Kata Sandi Anda",
              image: "assets/icons/gagal.png",
            ),
          ),
        );
        Timer(
          const Duration(seconds: 2),
          () => Navigator.pop(context),
        );
      }
    });
  }

  FocusNode pwbaru = FocusNode();
  FocusNode pwlama = FocusNode();
  FocusNode confpw = FocusNode();
  final _key = GlobalKey<FormState>();

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
        body: (isOnline)
            ? SafeArea(
                child: Container(
                  padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                  child: Form(
                    key: _key,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        WtextField(
                          controller: pwLama,
                          type: TextInputType.visiblePassword,
                          focusNode: pwlama,
                          obscure: true,
                          label: const Text(
                            "Kata Sandi Lama*",
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
                          errorStyle: const TextStyle(
                            color: Color(0XFFC4C4C4),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (password) {
                            if (password!.isEmpty) {
                              FocusScope.of(context).requestFocus(pwlama);
                              return "wajib di isi";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        WtextField(
                          controller: pwBaru,
                          obscure: true,
                          focusNode: pwbaru,
                          type: TextInputType.visiblePassword,
                          label: const Text(
                            "Kata Sandi Baru*",
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
                          errorStyle: const TextStyle(
                            color: Color(0XFFC4C4C4),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (password) {
                            if (password!.isEmpty) {
                              return "wajib di isi";
                            }
                            if (password.length < 8) {
                              return "minimal 8 karakter";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        WtextField(
                          controller: confpwBaru,
                          obscure: true,
                          focusNode: confpw,
                          type: TextInputType.visiblePassword,
                          label: const Text(
                            "Konfirmasi Kata Sandi Baru*",
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
                          errorStyle: const TextStyle(
                            color: Color(0XFFC4C4C4),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (password) {
                            if (password!.isEmpty) {
                              return "wajib di isi";
                            }
                            if (password.length < 8) {
                              return "minimal 8 karakter";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 16.5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Button(
                              onPres: () async {
                                bool check = await InternetConnectionChecker()
                                    .hasConnection;
                                if (!mounted) return;
                                setState(() {
                                  isOnline = check;
                                });
                                if (isOnline) {
                                  validationPW();
                                } else if (!isOnline) {
                                  const SkeletonUpadatePassword();
                                  return;
                                }
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
              )
            : const SkeletonUpadatePassword(),
      ),
    );
  }

  validationPW() {
    if (!_key.currentState!.validate()) {
      return;
    }
    FocusManager.instance.primaryFocus!.unfocus();
    var check = passwordIsSame(
      pwLama.text,
      pwBaru.text,
      confpwBaru.text,
    );
    if (check == 5) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => WillPopScope(
          onWillPop: () async => false,
          child: const CustomDialog(
            title: "Gagal Tersimpan",
            subtitle: "Periksa Kembali Kata Sandi Anda",
            image: "assets/icons/gagal.png",
          ),
        ),
      );
      Timer(
        const Duration(seconds: 2),
        () => Navigator.pop(context),
      );
      return;
    }
    if (check == 1) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => WillPopScope(
          onWillPop: () async => false,
          child: DialogPasswordIsSame(
            onPress: () {
              Navigator.pop(context);
            },
          ),
        ),
      );
      return;
    }
    if (check > 1) {
      if (check == 2) {
        pwbaru.requestFocus();
      }
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => WillPopScope(
          onWillPop: () async => false,
          child: const CustomDialog(
            title: "Gagal Tersimpan",
            subtitle: "Periksa Kembali Kata Sandi Anda",
            image: "assets/icons/gagal.png",
          ),
        ),
      );
      Timer(
        const Duration(seconds: 2),
        () => Navigator.pop(context),
      );
      return;
    }
    btnChange();
  }
}
