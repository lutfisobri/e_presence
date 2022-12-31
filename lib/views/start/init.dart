import 'package:app_presensi/app/providers/user.dart';
import 'package:app_presensi/resources/widgets/shared/theme.dart';
import 'package:app_presensi/views/pages/detail_informasi.dart';
import 'package:app_presensi/views/pages/presensi.dart';
import 'package:app_presensi/views/start/edit_profile.dart';
import 'package:app_presensi/views/start/main.dart';
import 'package:app_presensi/views/start/splash_screen.dart';
import 'package:app_presensi/views/user/change_password.dart';
import 'package:app_presensi/views/user/edit.dart';
import 'package:app_presensi/views/user/login.dart';
import 'package:app_presensi/views/user/search_account.dart';
import 'package:app_presensi/views/user/update_password.dart';
import 'package:app_presensi/views/user/verification_otp.dart';
import 'package:app_presensi/views/user/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  loadData() async {
    final user = Provider.of<UserProvider>(context, listen: false);
    // if (user.dataUser.username.isNotEmpty &&
    //     user.dataUser.password.isNotEmpty) {
    //   user.loadProfile();
    // }
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          theme: StyleThemeData.themeData(context),
          routes: {
            "/login": (context) => const Login(),
            "/home": (context) => const Beranda(),
            "/detailPresensi": (context) => const DetailPresensi(),
            "/detailInformasi": (context) => const DetailInformasi(),
            "/ubahPassword": (context) => const ChangePassword(),
            "/editProfile": (context) => const EditProfile(),
            "/lupaPassword": (context) => const LupaPassword(),
            "/viewPhoto": (context) => const ViewPhoto(),
            "/verificationOTP": (context) => const VerificationOTP(),
            "/forgotChangePassword": (context) => const ForgetChangePassword(),
            // "/EditProfileStart": (context) => const EditProfileStart(),
          },
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
        );
      },
    );
  }
}
