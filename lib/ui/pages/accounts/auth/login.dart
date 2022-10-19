import 'dart:async';
import 'package:e_presence/ui/shared/widgets/button_elevated.dart';
import 'package:e_presence/ui/shared/widgets/text_field.dart';
import 'package:e_presence/ui/shared/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Login extends StatefulWidget {
  Login({super.key});
  static const routeName = "/login";

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  final styleThemeData = StyleThemeData();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 360.w,
                height: 70.h,
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
                  Image(
                    width: 90.w,
                    height: 92.57.w,
                    fit: BoxFit.fill,
                    image: const AssetImage("assets/image/logo.png"),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "E-PRESENSI\nSMAN PLUS SUKOWONO",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 19.sp,
                      color: styleThemeData.colorGreen,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    padding: EdgeInsets.all(10.r),
                    margin: EdgeInsets.only(left: 20.r, right: 20.r),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.r),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0, 0),
                            blurRadius: 15,
                          ),
                        ]),
                    child: Container(
                      padding: EdgeInsets.all(20.r),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          WidgetTextField(
                            controller: email,
                            hintText: "Username",
                            label: Text("Username"),
                            hintStyle: TextStyle(
                              fontSize: 12.sp,
                              color: const Color(0XFF9F9F9F),
                            ),
                            prefixIcon: Icon(
                              Icons.account_box,
                              size: 20.sp,
                              color:const Color(0XFF9F9F9F),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7.r),
                              borderSide: BorderSide.none,
                            ),
                            contenV: 17.r,
                            fillColor: const Color(0xFFEFEFEF),
                            filled: true,
                            style: const TextStyle(
                              color: Color(0XFF9F9F9F),
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          WidgetTextField(
                            controller: password,
                            hintText: "Password",
                            hintStyle: TextStyle(
                              fontSize: 12.sp,
                              color: const Color(0XFF9F9F9F),
                            ),
                            obscure: true,
                            sufixIcon1: const Icon(
                              Icons.visibility_off,
                              color: Color(0XFF9F9F9F),
                            ),
                            sufixIcon2: const Icon(
                              Icons.visibility,
                              color: Color(0XFF9F9F9F),
                            ),
                            contenV: 17,
                            prefixIcon: Icon(
                              Icons.key,
                              size: 20.sp,
                              color: const Color(0XFF9F9F9F),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7.r),
                              borderSide: BorderSide.none,
                            ),
                            fillColor: const Color(0xFFEFEFEF),
                            filled: true,
                            focusColor: Colors.black,
                            style: const TextStyle(
                              color: Color(0XFF9F9F9F),
                            ),
                          ),
                          SizedBox(
                            height: 23.h,
                          ),
                          Row(
                            children: [
                              WidgetEleBtn(
                                onPres: () {
                                  Navigator.pushNamed(context, "/lupaPassword");
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7.r),
                                ),
                                child: const Icon(
                                  Icons.key,
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Expanded(
                                child: WidgetEleBtn(
                                  onPres: () {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    Timer(Duration(seconds: 1), () {
                                      Navigator.pushReplacementNamed(
                                        context,
                                        "/home",
                                      );
                                      setState(() {
                                        isLoading = false;
                                      });
                                    });
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7.r),
                                  ),
                                  textStyle: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  child: isLoading
                                      ? const SizedBox(
                                          height: 25,
                                          width: 25,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                        )
                                      : const Text("LOGIN"),
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
                width: 360.w,
                height: 64.h,
                image: const AssetImage("assets/wave/bottom-wave.png"),
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
