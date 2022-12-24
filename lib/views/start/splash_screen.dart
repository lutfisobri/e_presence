import 'dart:async';
import 'package:app_presensi/app/providers/user.dart';
import 'package:app_presensi/views/user/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    user.checkAccount();
    Timer(
      const Duration(seconds: 3),
      () => user.isLogin ? Navigator.pushReplacementNamed(context, "/home") : Navigator.pushReplacementNamed(context, Login.routeName),
    );
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Image(
                  width: 90,
                  height: 92.57,
                  fit: BoxFit.fill,
                  image: AssetImage("assets/image/logo.png"),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "E-PRESENSI\nSMAN PLUS SUKOWONO",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 114, 182, 108),
                  ),
                ),
              ],
            ),
          ),
          const Positioned(
            bottom: 105,
            left: 123,
            right: 123,
            child: Text(
              "Version 1.0.0\nCopyright Neko.ID",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                fontFamily: "Montserrat",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
