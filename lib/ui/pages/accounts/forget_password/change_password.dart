import 'dart:async';
import 'dart:convert';
import 'package:e_presence/core/providers/user_provider.dart';
import 'package:e_presence/ui/shared/widgets/button_elevated.dart';
import 'package:e_presence/ui/shared/widgets/dialog.dart';
import 'package:e_presence/ui/shared/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgetChangePassword extends StatefulWidget {
  const ForgetChangePassword({super.key});

  @override
  State<ForgetChangePassword> createState() => _ForgetChangePasswordState();
}

class _ForgetChangePasswordState extends State<ForgetChangePassword> {
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
                  WidgetTextField(
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
                  WidgetTextField(
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
                  WidgetEleBtn(
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

  btnUbah() {
    loadData();
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
    final usr = Provider.of<UserControlProvider>(context, listen: false);
    usr
        .forgotChangePassword(
      dataUser['username'].toString(),
      password.text,
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
  }
}
