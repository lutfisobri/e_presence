import 'dart:async';
import 'package:e_presence/core/providers/user_controller.dart';
import 'package:e_presence/ui/shared/widgets/button_elevated.dart';
import 'package:e_presence/ui/shared/widgets/text_field.dart';
import 'package:e_presence/utils/static.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  Login({super.key});
  static const routeName = "/login";

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final userControlProvider =
        Provider.of<UserControlProvider>(context, listen: false);
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 70,
                child: Image.asset(
                  "assets/wave/top-wave.png",
                  fit: BoxFit.cover,
                  colorBlendMode: BlendMode.darken,
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Image(
                    width: 90,
                    height: 92.57,
                    fit: BoxFit.fill,
                    image: AssetImage("assets/image/logo.png"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "E-PRESENSI\nSMAN PLUS SUKOWONO",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 19,
                      color: colorGreen,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0, 0),
                            blurRadius: 15,
                          ),
                        ]),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          WidgetTextField(
                            controller: username,
                            hintText: "Nama Pengguna",
                            primaryColor: colorGreen,
                            hintStyle: const TextStyle(
                              fontSize: 14,
                              color: Color(0XFF9F9F9F),
                            ),
                            prefixIcon: const Icon(
                              Icons.account_box,
                              size: 20,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                              borderSide: BorderSide.none,
                            ),
                            contenV: 17,
                            fillColor: const Color(0xFFEFEFEF),
                            filled: true,
                            style: const TextStyle(
                              color: Color(0XFF9F9F9F),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          WidgetTextField(
                            controller: password,
                            hintText: "Kata sandi",
                            primaryColor: colorGreen,
                            hintStyle: const TextStyle(
                              fontSize: 14,
                              color: Color(0XFF9F9F9F),
                            ),
                            obscure: true,
                            sufixIcon1: const Icon(
                              Icons.visibility_off,
                              size: 19,
                            ),
                            sufixIcon2: const Icon(
                              Icons.visibility,
                              size: 19,
                            ),
                            contenV: 17,
                            prefixIcon: const Icon(
                              Icons.key,
                              size: 19,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                              borderSide: BorderSide.none,
                            ),
                            fillColor: const Color(0xFFEFEFEF),
                            filled: true,
                            focusColor: Colors.black,
                            style: const TextStyle(
                              color: Color(0XFF9F9F9F),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, "/lupaPassword");
                                },
                                child: const Opacity(
                                  opacity: 0.5,
                                  child: Text(
                                    "Lupa Kata Sandi",
                                    style: TextStyle(
                                      color: Colors.black,
                                      letterSpacing: 0.2,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: WidgetEleBtn(
                                  onPres: () async {
                                    actionBtnLogin(
                                        context, userControlProvider);
                                  },
                                  minimunSize: Size(248, 41),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  child: isLoading
                                      ? const SizedBox(
                                          height: 25,
                                          width: 25,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                        )
                                      : const Text("MASUK"),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Image(
                width: MediaQuery.of(context).size.width,
                height: 64,
                image: const AssetImage("assets/wave/bottom-wave.png"),
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void actionBtnLogin(
      BuildContext context, UserControlProvider userControlProvider) {
    FocusManager.instance.primaryFocus?.unfocus();
    if (username.text == "" || password.text == "") {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("error"),
          content: Text("Username atau password tidak boleh kosong"),
          actions: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Text("Ok"),
            )
          ],
        ),
      );
    } else {
      setState(() {
        isLoading = true;
      });
      Timer(
        Duration(seconds: 1),
        () {
          userControlProvider.userLogin(
            username.text,
            password.text,
            context,
          );
          setState(() {
            isLoading = false;
          });
        },
      );
    }
  }
}
