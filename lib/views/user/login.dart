import 'dart:async';
import 'package:app_presensi/app/providers/user.dart';
import 'package:app_presensi/resources/utils/static.dart';
import 'package:app_presensi/resources/widgets/shared/button.dart';
import 'package:app_presensi/resources/widgets/shared/button_connection.dart';
import 'package:app_presensi/resources/widgets/shared/notification.dart';
import 'package:app_presensi/resources/widgets/shared/text_fields.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:platform_device_id/platform_device_id.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  static const routeName = "/login";

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late StreamSubscription subscription;
  var isDeviceConnected = false;
  bool isAlert = false;

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  bool isLoading = false;
  String deviceId = "";

  @override
  void initState() {
    getConnectivity();
    super.initState();
    loadData();
  }

  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && !isAlert) {
            _showModalBottomSheet(context);
            setState(() => isAlert = true);
          }
        },
      );

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      )),
      builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.6,
          maxChildSize: 0.9,
          minChildSize: 0.6,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: Stack(
                children: [
                  Positioned(
                    top: -15,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Column(children: [
                    Container(
                      margin: const EdgeInsets.only(top: 11),
                      alignment: AlignmentDirectional.topCenter,
                      clipBehavior: Clip.none,
                      width: 60,
                      height: 3,
                      color: Color.fromRGBO(208, 211, 216, 1),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 28),
                      child: Image.asset(
                        'assets/image/no_internet1.png',
                        width: 240,
                        height: 234.86,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Text(
                        'Tidak Ada Koneksi Internet',
                        style: TextStyle(
                          color: Color.fromRGBO(114, 182, 108, 1),
                          fontSize: 18,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 6),
                      child: Text(
                        'Mohon Periksa Kembali Koneksi\nInternet Anda.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromRGBO(100, 97, 97, 1),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 19, right: 19),
                      child: Row(
                        children: [
                          Expanded(
                            child: Button(
                              onPres: () async {
                                Navigator.pop(context, 'cancel');
                                setState(() => isAlert = false);
                                isDeviceConnected =
                                    await InternetConnectionChecker()
                                        .hasConnection;
                                if (!isDeviceConnected) {
                                  _showModalBottomSheet(context);
                                }
                              },
                              minimunSize: const Size(248, 41),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7),
                              ),
                              textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                              child: const Text("COBA LAGI"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ])
                ],
              ),
            );
          }),
    );
  }

  loadData() async {
    String? deviceID = await PlatformDeviceId.getDeviceId;
    setState(() {
      deviceId = deviceID ?? "";
    });
  }

  closeWindow() {
    Navigator.pop(context);
  }

  actionBtnLogin(
    // BuildContext context,

    UserProvider userControlProvider,
  ) async {
    // isDeviceConnected = await InternetConnectionChecker().hasConnection;
    FocusManager.instance.primaryFocus?.unfocus();
    if (!isDeviceConnected) {
      _showModalBottomSheet(context);
      isLoading = false;
      return;
    }

    if (username.text == "" || password.text == "") {
      Timer(
        const Duration(milliseconds: 700),
        () => setState(() {
          isLoading = false;
        }),
      );
      Future.delayed(const Duration(milliseconds: 700));
      Timer(
        const Duration(milliseconds: 800),
        () {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => WillPopScope(
              onWillPop: () async {
                return false;
              },
              child: const CustomDialogLogin(),
            ),
          );
          Timer(
            const Duration(seconds: 2),
            () {
              Navigator.pop(context, false);
            },
          );
        },
      );
      return;
    } else {
      Timer(const Duration(milliseconds: 200), () async {
        await userControlProvider
            .login(
          username: username.text,
          password: password.text,
          deviceId: deviceId,
        )
            .then((value) {
          if (value) {
            Navigator.pushReplacementNamed(context, "/home");
          } else {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => WillPopScope(
                onWillPop: () async => false,
                child: const CustomDialogLogin(),
              ),
            );
            Timer(
              const Duration(seconds: 2),
              () {
                setState(() {
                  // back = true;
                });
                Navigator.pop(context);
              },
            );
          }
        });
        setState(() {
          isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userControlProvider =
        Provider.of<UserProvider>(context, listen: false);
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Stack(
        children: [
          Scaffold(
            resizeToAvoidBottomInset: false,
            body: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 120,
                    child: Image.asset(
                      "assets/wave/top-wave.png",
                      fit: BoxFit.cover,
                      colorBlendMode: BlendMode.darken,
                    ),
                  ),
                ),
                Center(
                  child: SingleChildScrollView(
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
                            border: Border.all(
                                color: Colors.black.withOpacity(0.10)),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                WtextField(
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
                                WtextField(
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
                                        Navigator.pushNamed(
                                            context, "/lupaPassword");
                                      },
                                      child: const Opacity(
                                        opacity: 0.5,
                                        child: Text(
                                          "Lupa Kata Sandi",
                                          style: TextStyle(
                                            color: Colors.black,
                                            letterSpacing: 0.2,
                                            decoration:
                                                TextDecoration.underline,
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
                                      child: Button(
                                        onPres: () async {
                                          setState(() {
                                            isLoading = true;
                                          });
                                          actionBtnLogin(
                                              // context,
                                              userControlProvider);
                                        },
                                        minimunSize: const Size(248, 41),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                        ),
                                        textStyle: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        child: const Text("MASUK"),
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
                ),
                Positioned(
                  bottom: 0,
                  // alignment: Alignment.bottomCenter,
                  child: Image(
                    width: MediaQuery.of(context).size.width,
                    height: 120,
                    image: const AssetImage("assets/wave/bottom-wave.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
          if (isLoading)
            Container(
              alignment: Alignment.center,
              color: Colors.white.withOpacity(0.3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/loading/sepeda.gif",
                    width: 100,
                    height: 100,
                  ),
                  // CircularProgressIndicator(),
                  const SizedBox(
                    height: 2.63,
                  ),
                  const Text(
                    "Tunggu Proses",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Poppins"),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
