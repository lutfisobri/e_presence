import 'dart:async';
import 'package:app_presensi/app/providers/user.dart';
import 'package:app_presensi/views/user/login.dart';
import 'package:flutter/material.dart';
import 'package:platform_device_id/platform_device_id.dart';
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    autoLogin();
  }

  void autoLogin() async {
    final user = Provider.of<UserProvider>(context);
    String? deviceId = await PlatformDeviceId.getDeviceId;
    bool isLogin = await user.autoLogin(deviceId!);
    if (isLogin) {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, "/home");
    } else {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, Login.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserProvider>();
    Timer(const Duration(seconds: 3), () {
      if (!mounted) return;
      user.isLogin
          ? Navigator.pushReplacementNamed(context, "/home")
          : Navigator.pushReplacementNamed(context, "/login");
    });
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
