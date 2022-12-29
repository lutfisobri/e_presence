import 'dart:async';
import 'package:animations/animations.dart';
import 'package:app_presensi/app/providers/informasi.dart';
import 'package:app_presensi/app/providers/pelajaran.dart';
import 'package:app_presensi/app/providers/user.dart';
import 'package:app_presensi/resources/widgets/shared/notification.dart';
import 'package:app_presensi/views/pages/component/home/absensi.dart';
import 'package:app_presensi/views/pages/component/home/informasi_akademik.dart';
// import 'package:app_presensi/views/pages/component/home/noconnection.dart';
import 'package:app_presensi/views/pages/component/home/null.dart';
import 'package:app_presensi/views/pages/component/home/skeleton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:ntp/ntp.dart';
import 'package:provider/provider.dart';

import '../../resources/widgets/shared/button.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late StreamSubscription<InternetConnectionStatus> listener;
  bool isOnline = false;
  bool isLoading = true;

  void hasConnect() async {
    listener = InternetConnectionChecker().onStatusChange.listen(
      (InternetConnectionStatus status) {
        switch (status) {
          case InternetConnectionStatus.connected:
            setState(() {
              isOnline = true;
              isLoading = false;
            });
            break;
          case InternetConnectionStatus.disconnected:
            if (!mounted) return;
            setState(() {
              isOnline = false;
              isLoading = true;
            });
            break;
        }
      },
    );
  }

  void init() async {
    bool check = await InternetConnectionChecker().hasConnection;
    if (!mounted) return;
    setState(() {
      isOnline = check;
    });
    if (isOnline) {
      final informasi = Provider.of<InformasiProvider>(context, listen: false);
      informasi.getData();
      loadPresensi();
    } else {
      isLoading = true;
      // NoConnection();
    }
  }

  loadPresensi() async {
    final loadPresen = Provider.of<PelajaranProvider>(context, listen: false);
    final user = Provider.of<UserProvider>(context, listen: false);
    loadPresen.allPresensi(
        idKelasAjaran: user.dataUser.idKelasAjaran ?? "",
        nis: user.dataUser.username);
    bool isLogin = await user.checkAccount().then((value) => value);
    if (!isLogin) {
      if (!mounted) return;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => WillPopScope(
          onWillPop: () async => false,
          child: DialogSession(
            onPress: () {
              Navigator.popUntil(context, (route) => route.isFirst);
              Navigator.pushReplacementNamed(context, "/login");
            },
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    hasConnect();
    init();
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    listener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? SkeletonHome()
        : isOnline
            ? Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Consumer<PelajaranProvider>(
                        builder: (context, value, child) => Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 20,
                                right: 20,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    "Mata Pelajaran",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "IBMPlex",
                                    ),
                                  ),
                                  Text(
                                    "Hari Ini",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                        fontFamily: "Roboto"),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 12.6,
                            ),
                            value.listPresensi.isEmpty
                                ? NullPresensi()
                                : ContentPresensi(),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 12.9, left: 19, right: 19, bottom: 6),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    "Informasi Akademik",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "IBMPlex"),
                                  ),
                                  Text(
                                    "Terbaru",
                                    style: TextStyle(
                                        fontSize: 12.6,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                        fontFamily: "Roboto"),
                                  ),
                                ],
                              ),
                            ),
                            InformasiAkademik(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              )
            : Container(
                color: Color.fromRGBO(250, 250, 250, 1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 152,
                    ),
                    Container(
                      width: 500,
                      margin: const EdgeInsets.only(
                        left: 1,
                        right: 1,
                      ),
                      child: Image.asset(
                        "assets/image/noInternet.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Text(
                      "Tidak Ada Koneksi Internet",
                      style: TextStyle(
                        color: Color.fromRGBO(114, 182, 108, 1),
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'poppins',
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      "Mohon Periksa Kembali Koneksi Internet Anda.",
                      style: TextStyle(
                        color: Color.fromRGBO(100, 97, 97, 1),
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'poppins',
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 19, right: 19),
                      child: Row(
                        children: [
                          Expanded(
                            child: Button(
                              onPres: () async {
                                hasConnect();
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
                  ],
                ),
              );
  }

  Future<DateTime> validationTime() async {
    final int offset = await NTP.getNtpOffset(
      localTime: DateTime.now(),
      lookUpAddress: "0.id.pool.ntp.org",
    );
    return DateTime.now().add(Duration(milliseconds: offset));
  }
}
