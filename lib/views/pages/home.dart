import 'dart:async';
import 'package:animations/animations.dart';
import 'package:app_presensi/app/providers/informasi.dart';
import 'package:app_presensi/app/providers/pelajaran.dart';
import 'package:app_presensi/app/providers/user.dart';
import 'package:app_presensi/resources/widgets/shared/notification.dart';
import 'package:app_presensi/views/pages/component/home/absensi.dart';
import 'package:app_presensi/views/pages/component/home/informasi_akademik.dart';
import 'package:app_presensi/views/pages/component/home/null.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:ntp/ntp.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late StreamSubscription subscription;
  var isDeviceConnected = false;
  bool isAlert = false;

  loadPresensi() async {
    final loadPresen = Provider.of<PelajaranProvider>(context, listen: false);
    final user = Provider.of<UserProvider>(context, listen: false);
    // loadPresen.loadPresensi(user.dataUser.idKelas);
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
    getConnectivity();
    super.initState();
    loadPresensi();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<InformasiProvider>(context, listen: false).getData();
    });
  }

  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && !isAlert) {
            showDialogbox();
            setState(() => isAlert = true);
          }
        },
      );
  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  showDialogbox() => showModal<String>(
        context: context,
        builder: (BuildContext contex) => CupertinoAlertDialog(
          title: const Text("Peringatan"),
          content: const Text("Tidak ada koneksi internet"),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.pop(context, 'cancel');
                setState(() => isAlert = false);
                isDeviceConnected =
                    await InternetConnectionChecker().hasConnection;
                if (!isDeviceConnected) {
                  // showDialogbox();
                  setState(() => isAlert = true);
                }
              },
              child: const Text("Tutup"),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
