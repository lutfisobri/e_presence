import 'dart:async';

import 'package:e_presence/core/providers/pelajaran_provider.dart';
import 'package:e_presence/core/providers/user_provider.dart';
import 'package:e_presence/core/services/locations.dart';
import 'package:e_presence/ui/shared/widgets/button_elevated.dart';
import 'package:e_presence/ui/shared/widgets/dialog.dart';
import 'package:e_presence/utils/static.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'page/akun_page.dart';
import 'page/home_page.dart';
import 'page/mapel_page.dart';
import 'page/ujian_page.dart';

class Beranda extends StatefulWidget {
  const Beranda({super.key});
  static const routeName = "/home";

  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  Future<void> loadData() async {
    final loadPelajaran =
        Provider.of<PelajaranProvider>(context, listen: false);
    final user = Provider.of<UserControlProvider>(context, listen: false);
    loadPelajaran.listMapel.clear();
    loadPelajaran.listPresensi.clear();
    loadPelajaran.listUjian.clear();
    Future.delayed(const Duration(seconds: 1));
    await loadPelajaran.loadMapel(user.dataUser.idKelas);
    await loadPelajaran.loadPresensi(user.dataUser.idKelas);
    await loadPelajaran.loadUjian(user.dataUser.idKelas);
    await user.loadProfile();
  }

  checkEmail() async {
    final user = Provider.of<UserControlProvider>(context, listen: false);
    if (user.dataUser.email == "" || user.dataUser.email.isEmpty) {
      // if (!mounted) return;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => DialogEmail(
            title: "E - Mail Belum Lengkap",
            subtitle: "Silahkan isi E-Mail Anda",
            image: "assets/icons/email.png",
            button: WidgetEleBtn(
              onPres: () {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.pushNamed(context, "/editProfile");
                });
              },
              minimunSize: const Size(double.infinity, 36.88),
              textStyle:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7.77),
              ),
              child: const Text("BUKA PROFIL"),
            ),
          ),
        );
      });
    }
  }

  cekPermission() {
    checkPermissionLocation().then((value) {
      setState(() {
        isEnable = value;
      });
    });
  }

  List<Widget> body = [
    const Home(),
    const Mapel(),
    const JadwalPage(),
  ];

  int index = 0;

  @override
  void initState() {
    super.initState();
    loadData();
    checkEmail();
    Timer(
      Duration(seconds: 1),
      () => cekPermission(),
    );
  }

  bool isEnable = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: index == 3
              ? const AkunPage()
              : Stack(
                  children: [
                    SizedBox(
                      height: 400,
                      child: Image.asset(
                        "assets/wave/top-wave.png",
                        fit: BoxFit.cover,
                        colorBlendMode: BlendMode.darken,
                      ),
                    ),
                    Stack(
                      children: [
                        index == 0
                            ? Container(
                                height: 91,
                                padding: const EdgeInsets.only(
                                  left: 13.62,
                                  right: 13.62,
                                  top: 35,
                                ),
                                child: topBar(),
                              )
                            : Container(),
                        RefreshIndicator(
                          onRefresh: () => loadData(),
                          child: ListView(
                            padding: EdgeInsets.only(top: index == 0 ? 91 : 44),
                            children: [
                              Container(
                                width: double.infinity,
                                constraints: const BoxConstraints(
                                    minHeight: 530, maxHeight: double.infinity),
                                padding: const EdgeInsets.only(
                                  top: 24,
                                ),
                                decoration: const BoxDecoration(
                                  color: Color(0XFFFAFAFA),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      offset: Offset(0, -1),
                                      blurRadius: 5,
                                    ),
                                    BoxShadow(
                                      color: Colors.white,
                                      offset: Offset(0, 5),
                                      blurRadius: 5,
                                    ),
                                  ],
                                ),
                                child: body[index],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
          bottomNavigationBar: bottomNavBar(),
        ),
        if (isEnable == false)
          Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset("assets/image/location.png"),
                SizedBox(
                  height: 80,
                ),
                Text(
                  "Lokasi",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    letterSpacing: 2,
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: colorGreen,
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  "Untuk Pengalaman yang terbaik. Izinkan Aplikasi E-Presensi untuk mengakses lokasi anda.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 18,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 19),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: WidgetEleBtn(
                          onPres: () async {
                            await determinePosition();
                            await cekPermission();
                          },
                          textStyle: TextStyle(
                            fontSize: 16,
                            letterSpacing: 1.36,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Roboto",
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: Text("BERIKAN IZIN"),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 61,
                ),
              ],
            ),
          ),
      ],
    );
  }

  Consumer<UserControlProvider> topBar() {
    String greeting() {
      var hour = DateTime.now().hour;
      if (hour > 4 && hour < 10) {
        return 'Pagi';
      }
      if (hour > 10 && hour < 14) {
        return 'Siang';
      }
      if (hour > 14 && hour < 18) {
        return 'Sore';
      }
      return 'Malam';
    }

    return Consumer<UserControlProvider>(
      builder: (context, value, child) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Selamat ${greeting()}, ${value.dataUser.nama}",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  value.dataUser.kelas == ""
                      ? "Loading"
                      : "Kelas ${value.dataUser.kelas}",
                  style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            )
          ],
        );
      },
    );
  }

  BottomNavigationBar bottomNavBar() {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Image(
            width: 21,
            height: 21,
            image: AssetImage("assets/bottom_navbar/home.png"),
          ),
          activeIcon: Image(
            image: AssetImage("assets/bottom_navbar/home_active.png"),
            width: 21,
            height: 21,
          ),
          label: "Mapel",
        ),
        BottomNavigationBarItem(
          icon: Image(
            width: 21,
            height: 21,
            image: AssetImage("assets/bottom_navbar/mapel.png"),
          ),
          activeIcon: Image(
            image: AssetImage("assets/bottom_navbar/mapel_active.png"),
            width: 21,
            height: 21,
          ),
          label: "Mapel",
        ),
        BottomNavigationBarItem(
          icon: Image(
            width: 21,
            height: 21,
            image: AssetImage("assets/bottom_navbar/ujian.png"),
          ),
          activeIcon: Image(
            image: AssetImage("assets/bottom_navbar/ujian_active.png"),
            width: 21,
            height: 21,
          ),
          label: "Mapel",
        ),
        BottomNavigationBarItem(
          icon: Image(
            width: 21,
            height: 21,
            image: AssetImage("assets/bottom_navbar/akun.png"),
          ),
          activeIcon: Image(
            image: AssetImage("assets/bottom_navbar/akun_active.png"),
            width: 21,
            height: 21,
          ),
          label: "Mapel",
        ),
      ],
      showSelectedLabels: false,
      currentIndex: index,
      onTap: (value) {
        setState(() {
          index = value;
        });
      },
    );
  }
}
