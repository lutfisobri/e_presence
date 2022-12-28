import 'dart:async';
import 'dart:convert';
import 'package:app_presensi/app/providers/user.dart';
import 'package:app_presensi/resources/widgets/shared/button.dart';
import 'package:app_presensi/resources/widgets/shared/notification.dart';
import 'package:app_presensi/resources/widgets/shared/text_fields.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

import 'component/login/is_online.dart';

class ForgetChangePassword extends StatefulWidget {
  const ForgetChangePassword({super.key});

  @override
  State<ForgetChangePassword> createState() => _ForgetChangePasswordState();
}

class _ForgetChangePasswordState extends State<ForgetChangePassword> {
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
      loadData();
    } else {
      _noInternet();
    }
  }

  void _noInternet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      )),
      builder: (context) => NoInternet(),
    );
  }

  Map<String, dynamic> dataUser = {};
  TextEditingController password = TextEditingController();
  TextEditingController confPassword = TextEditingController();
  final _key = GlobalKey<FormState>();

  loadData() {
    final args = ModalRoute.of(context)!.settings.arguments;
    setState(() {
      dataUser = jsonDecode(jsonEncode(args));
    });
  }

  @override
  void initState() {
    super.initState();
    init();
    hasConnect();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Ubah Kata Sandi"),
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 19,
              right: 19,
            ),
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  WtextField(
                    controller: password,
                    label: const Text(
                      "Kata Sandi Baru*",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    type: TextInputType.visiblePassword,
                    primaryColor: Colors.black,
                    obscure: true,
                    sufixIcon1: const Icon(Icons.visibility_off),
                    sufixIcon2: const Icon(Icons.visibility),
                    errorStyle: TextStyle(
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
                    height: 19.5,
                  ),
                  WtextField(
                    controller: confPassword,
                    label: const Text(
                      "Konfirmasi Kata Sandi Baru*",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color(0XFF494949),
                      ),
                    ),
                    type: TextInputType.visiblePassword,
                    obscure: true,
                    sufixIcon1: const Icon(Icons.visibility_off),
                    sufixIcon2: const Icon(Icons.visibility),
                    primaryColor: Colors.black,
                    errorStyle: TextStyle(
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
                    height: 20.5,
                  ),
                  Button(
                    onPres: () {
                      btnUbah();
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.77)),
                    minimunSize: const Size(109, 46),
                    child: const Text("Ubah"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  btnUbah() async {
    bool check = await InternetConnectionChecker().hasConnection;
    if (!mounted) return;
    setState(() {
      isOnline = check;
    });
    if (isOnline) {
      FocusManager.instance.primaryFocus?.unfocus();
      if (!_key.currentState!.validate()) {
        return;
      }
      if (password.text != confPassword.text) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => WillPopScope(
            onWillPop: () async => false,
            child: const CustomDialog(
              title: "Gagal Tersimpan",
              subtitle: "Periksa kembali Kata Sandi Anda",
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
      if (confPassword.text.length < 8) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => WillPopScope(
            onWillPop: () async => false,
            child: const CustomDialog(
              title: "Gagal Tersimpan",
              subtitle: "Periksa kembali Kata Sandi Anda",
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
      print(dataUser);
      final usr = Provider.of<UserProvider>(context, listen: false);
      usr
          .forgotChangePassword(
        username: dataUser['nis'],
        password: password.text,
      )
          .then((value) {
        if (value) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => WillPopScope(
              onWillPop: () async => false,
              child: const CustomDialog(
                title: "Berhasil",
                subtitle: "Woah,  Kata Sandi anda berhasil diubah",
                image: "assets/icons/sukses.png",
              ),
            ),
          );
          Timer(
            const Duration(seconds: 2),
            () => Navigator.pop(context),
          );
          Timer(
            const Duration(seconds: 2),
            () => Navigator.pop(context),
          );
        } else {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => WillPopScope(
              onWillPop: () async => false,
              child: const CustomDialog(
                title: "Gagal Tersimpan",
                subtitle: "Periksa kembali Kata Sandi Anda",
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
    } else {
      _noInternet();
    }
  }
}
