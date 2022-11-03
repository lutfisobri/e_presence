import 'package:e_presence/core/providers/pelajaran_provider.dart';
import 'package:e_presence/core/providers/user_provider.dart';
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
    Future.delayed(Duration(seconds: 1));
    await loadPelajaran.loadMapel(user.dataUser.idKelas);
    await loadPelajaran.loadPresensi(user.dataUser.idKelas);
    await loadPelajaran.loadUjian(user.dataUser.idKelas);
    await user.loadProfile();
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: index == 3
          ? AkunPage()
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
                            height: 81,
                            padding: const EdgeInsets.only(
                              left: 13.62,
                              right: 13.62,
                              top: 25,
                            ),
                            child: topBar(),
                          )
                        : Container(),
                    RefreshIndicator(
                      onRefresh: () => loadData(),
                      child: ListView(
                        padding: EdgeInsets.only(top: index == 0 ? 81 : 36),
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
