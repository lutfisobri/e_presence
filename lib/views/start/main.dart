import 'dart:async';
import 'package:app_presensi/app/providers/pelajaran.dart';
import 'package:app_presensi/app/providers/user.dart';
import 'package:app_presensi/app/services/location.dart';
import 'package:app_presensi/resources/widgets/shared/button.dart';
import 'package:app_presensi/resources/widgets/shared/location.dart';
import 'package:app_presensi/resources/widgets/shared/notification.dart';
import 'package:app_presensi/views/pages/account.dart';
import 'package:app_presensi/views/pages/home.dart';
import 'package:app_presensi/views/pages/mapel.dart';
import 'package:app_presensi/views/pages/ujian.dart';
import 'package:app_presensi/views/start/component/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

class Beranda extends StatefulWidget {
  const Beranda({super.key});
  static const routeName = "/home";

  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  late StreamSubscription<InternetConnectionStatus> listener;
  bool isOnline = false;

  void hasConnect() async {
    listener = InternetConnectionChecker().onStatusChange.listen(
      (InternetConnectionStatus status) {
        switch (status) {
          case InternetConnectionStatus.connected:
            if (!mounted) return;
            loadData();
            if (!mounted) return;
            checkEmail();
            if (!mounted) return;
            setState(() {
              isOnline = true;
            });
            break;
          case InternetConnectionStatus.disconnected:
            if (!mounted) return;
            setState(() {
              isOnline = false;
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
      loadData();
      checkEmail();
    }
  }

  Future<void> loadData() async {
    if (!mounted) return;
    if (!isOnline) return;
    final loadPelajaran =
        Provider.of<PelajaranProvider>(context, listen: false);
    final user = Provider.of<UserProvider>(context, listen: false);
    await loadPelajaran.allMapel(
        idKelasAjaran: user.dataUser.idKelasAjaran ?? "");
    await loadPelajaran.allPresensi(
        idKelasAjaran: user.dataUser.idKelasAjaran ?? "",
        nis: user.dataUser.username);
    await loadPelajaran.allUjian(
        idKelasAjaran: user.dataUser.idKelasAjaran ?? "");
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
              if (!mounted) return;
              Navigator.popUntil(context, (route) => route.isFirst);
              Navigator.pushReplacementNamed(context, "/login");
            },
          ),
        ),
      );
    }
  }

  checkEmail() async {
    final user = Provider.of<UserProvider>(context, listen: false);
    if (user.dataUser.email == "" ||
        user.dataUser.email == null ||
        user.dataUser.email == "null") {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => WillPopScope(
            onWillPop: () async => false,
            child: DialogEmail(
              title: "E - Mail Belum Lengkap",
              subtitle: "Silahkan isi E-Mail Anda",
              image: "assets/icons/email.png",
              button: Button(
                onPres: () {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.pop(context);
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
          ),
        );
      });
    }
    await cekPermission();
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
    if (!mounted) return;
    hasConnect();
    init();
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
                                child: TopBarMain(),
                              )
                            : Container(),
                        RefreshIndicator(
                          onRefresh: () => loadData(),
                          child: ListView(
                            padding: EdgeInsets.only(top: index == 0 ? 91 : 44),
                            children: [
                              Container(
                                width: double.infinity,
                                // constraints: const BoxConstraints(
                                // minHeight: 530,
                                //     maxHeight: double.infinity),
                                padding: const EdgeInsets.only(
                                  top: 24,
                                ),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
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
          ViewPermissionLocation(
            onTap: () async {
              await determinePosition();
              await cekPermission();
            },
          ),
      ],
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
      backgroundColor: Colors.white,
      onTap: (value) {
        setState(() {
          index = value;
        });
      },
    );
  }
}
