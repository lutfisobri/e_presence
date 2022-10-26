import 'package:e_presence/ui/pages/accounts/auth/login.dart';
import 'package:e_presence/ui/pages/accounts/change_password.dart';
import 'package:e_presence/ui/pages/accounts/edit_profile.dart';
import 'package:e_presence/ui/pages/accounts/forget_password/search_account.dart';
import 'package:e_presence/ui/pages/accounts/view_photo.dart';
import 'package:e_presence/ui/pages/details_pages/detail_presensi.dart';
import 'package:e_presence/ui/pages/main_page.dart';
import 'package:e_presence/ui/pages/splash_screen.dart';
import 'package:e_presence/ui/shared/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'api_controller.dart';
import 'user_controller.dart';

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  UserControlProvider userLocation = UserControlProvider();

  loadData() async {
    final api = context.read<ApiController>();
    // userLocation.determinePosition();
    api.loadJadwal();
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
            "/login": (context) => Login(),
            "/home": (context) => Beranda(),
            "/detailPresensi": (context) => const DetailPresensi(),
            "/ubahPassword": (context) => const ChangePassword(),
            "/editProfile": (context) => EditProfile(),
            "/lupaPassword": (context) => const LupaPassword(),
            "/viewPhoto":(context) => const ViewPhoto(),
          },
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
        );
      },
    );
  }
}
