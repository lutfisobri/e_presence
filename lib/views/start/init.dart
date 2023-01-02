import 'package:app_presensi/app/providers/user.dart';
import 'package:app_presensi/resources/widgets/shared/theme.dart';
import 'package:app_presensi/utils/bridge.dart';
import 'package:app_presensi/utils/message.dart';
import 'package:app_presensi/views/pages/detail_informasi.dart';
import 'package:app_presensi/views/pages/presensi.dart';
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

class _MainState extends State<Main> with WidgetsBindingObserver {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      await handleDeeplink();
    }
    if (state == AppLifecycleState.inactive) {
      deleteAttributes();
    }
  }

  String? _url;
  Uri? _deepLink;
  String? _path;
  Map<String, String>? _queryParameters;

  deleteAttributes() {
    setState(() {
      _url = null;
      _deepLink = null;
      _path = null;
      _queryParameters = null;
    });
  }

  setAttributes() async {
    _url = await Bridge.url;
    if (_url != null) {
      setState(() {
        _deepLink = Uri.parse(_url!);
      });
    }
    if (_deepLink != null) {
      setState(() {
        _path = _deepLink!.path;
        _queryParameters = _deepLink!.queryParameters;
      });
    }
  }

  handleDeeplink() async {
    await deleteAttributes();
    await setAttributes();
    if (_path == "/otp") {
      if (_queryParameters!['token'] != null) {
        if (!mounted) return;
        final user = Provider.of<UserProvider>(context, listen: false);
        user.verifyToken(_queryParameters!['token']!).then((value) {
          if (value != null) {
            if (value['status'] == 200) {
              if (navigatorKey.currentState!.canPop()) {
                navigatorKey.currentState!.pop();
              }
              try {
                Log.i("OTP $value['data']");
                navigatorKey.currentState!.pushNamed(
                  "/forgotChangePassword",
                  arguments: value['data'],
                );
              } catch (e) {
                scaffoldMessengerKey.currentState!.showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.red.withOpacity(0.8),
                    content: const Text(
                      "Terjadi kesalahan, silahkan coba lagi",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              }
            }
          }
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
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
            "/": (context) => const SplashScreen(),
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
          },
          debugShowCheckedModeBanner: false,
          initialRoute: "/",
          navigatorKey: navigatorKey,
          scaffoldMessengerKey: scaffoldMessengerKey,
        );
      },
    );
  }
}
