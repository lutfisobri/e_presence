import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'accounts/auth/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
      () => Navigator.pushReplacementNamed(context, Login.routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
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
                  height: 10.r,
                ),
                Text(
                  "E-PRESENSI\nSMAN PLUS SUKOWONO",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 114, 182, 108),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 106.r,
            left: 126.r,
            right: 127.r,
            child: Text(
              "Version 1.0\nCopyright Neko.ID",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 11.3.sp),
            ),
          ),
        ],
      ),
    );
  }
}
