import '../../core/providers/user_controller.dart';
import 'package:e_presence/ui/pages/page/akun_page.dart';
import 'package:e_presence/ui/shared/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../core/providers/api_controller.dart';
import 'page/ujian_page.dart';
import 'page/home_page.dart';
import 'page/mapel_page.dart';

class Beranda extends StatefulWidget {
  Beranda({super.key});
  static const routeName = "/home";

  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  Future<void> loadData() async {
    final api = context.read<ApiController>();
    await api.loadJadwal();
  }

  List<Widget> body = [
    Home(),
    Mapel(),
    JadwalPage(),
  ];
  final styleThemeData = StyleThemeData();

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
                  width: 360.w,
                  height: 400.h,
                  child: Image.asset(
                    "assets/wave/top-wave.png",
                    fit: BoxFit.cover,
                    colorBlendMode: BlendMode.darken,
                  ),
                ),
                SafeArea(
                  child: Stack(
                    children: [
                      index == 0
                          ? Container(
                              height: 82.h,
                              padding: EdgeInsets.only(
                                left: 11.2.r,
                                right: 11.2.r,
                                // top: 15.r,
                                bottom: 5.r,
                              ),
                              child: topBar(),
                            )
                          : Container(),
                      RefreshIndicator(
                        onRefresh: () => loadData(),
                        child: ListView(
                          padding:
                              EdgeInsets.only(top: index == 0 ? 82.r : 36.r),
                          children: [
                            Container(
                              width: 360.w,
                              constraints: BoxConstraints(
                                  minHeight: 530.h, maxHeight: double.infinity),
                              padding: const EdgeInsets.only(
                                top: 24,
                                // left: 20,
                                // right: 20,
                                bottom: 10,
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
                ),
              ],
            ),
      bottomNavigationBar: bottomNavBar(),
    );
  }

  Consumer<UserControlProvider> topBar() {
    String greeting() {
      var hour = DateTime.now().hour;
      if (hour < 10) {
        return 'Pagi';
      }
      if (hour < 14) {
        return 'Siang';
      }
      if (hour < 17) {
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
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  value.dataUser.kelas == ""
                      ? "Loading"
                      : "Kelas ${value.dataUser.kelas}",
                  style: TextStyle(fontSize: 12.6.sp, color: Colors.white),
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
      items: [
        BottomNavigationBarItem(
          icon: Image(
            width: 21.w,
            height: 21.h,
            image: const AssetImage("assets/bottom_navbar/home.png"),
          ),
          activeIcon: Image(
            image: const AssetImage("assets/bottom_navbar/home_active.png"),
            width: 23.w,
            height: 23.h,
          ),
          label: "Mapel",
        ),
        BottomNavigationBarItem(
          icon: Image(
            width: 21.w,
            height: 21.h,
            image: const AssetImage("assets/bottom_navbar/mapel.png"),
          ),
          activeIcon: Image(
            image: const AssetImage("assets/bottom_navbar/mapel_active.png"),
            width: 21.w,
            height: 21.h,
          ),
          label: "Mapel",
        ),
        BottomNavigationBarItem(
          icon: Image(
            width: 21.w,
            height: 21.h,
            image: const AssetImage("assets/bottom_navbar/ujian.png"),
          ),
          activeIcon: Image(
            image: const AssetImage("assets/bottom_navbar/ujian_active.png"),
            width: 21.w,
            height: 21.h,
          ),
          label: "Mapel",
        ),
        BottomNavigationBarItem(
          icon: Image(
            width: 21.w,
            height: 21.h,
            image: const AssetImage("assets/bottom_navbar/akun.png"),
          ),
          activeIcon: Image(
            image: const AssetImage("assets/bottom_navbar/akun_active.png"),
            width: 21.w,
            height: 21.h,
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
