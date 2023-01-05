import 'dart:async';
import 'package:app_presensi/app/models/ujian.dart';
import 'package:app_presensi/app/providers/pelajaran.dart';
import 'package:app_presensi/app/providers/user.dart';
import 'package:app_presensi/resources/utils/days.dart';
import 'package:app_presensi/resources/utils/static.dart';
import 'package:app_presensi/resources/widgets/constant/tab_bar.dart';
import 'package:app_presensi/resources/widgets/shared/notifications/session.dart';
import 'package:app_presensi/resources/widgets/shared/theme.dart';
import 'package:app_presensi/views/pages/component/ujian/content.dart';
import 'package:app_presensi/views/pages/component/ujian/null.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

import 'component/mapel/skeleton.dart';

class JadwalPage extends StatefulWidget {
  const JadwalPage({super.key});

  @override
  State<JadwalPage> createState() => _JadwalPageState();
}

class _JadwalPageState extends State<JadwalPage> with TickerProviderStateMixin {
  late StreamSubscription<InternetConnectionStatus> listener;
  bool isOnline = false;
  void hasConnect() async {
    listener = InternetConnectionChecker().onStatusChange.listen(
      (InternetConnectionStatus status) {
        switch (status) {
          case InternetConnectionStatus.connected:
            getData();
            // setState(() {
            //   isOnline = true;
            // });
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
    if (check) {
      getData();
    }
  }

  StyleThemeData styleThemeData = StyleThemeData();
  ScrollController scrollController = ScrollController();
  PageController pageController = PageController();
  List<ModelUjian> data = [];
  int selectedTab = 1;
  String hari = "senin";

  @override
  void initState() {
    super.initState();
    hasConnect();
    init();
  }

  TickerProvider get vsync => this;

  @override
  void dispose() {
    listener.cancel();
    super.dispose();
  }

  getData() async {
    final dataMapel = Provider.of<PelajaranProvider>(context, listen: false);
    final user = Provider.of<UserProvider>(context, listen: false);
    dataMapel.allUjian(idKelasAjaran: user.dataUser.idKelasAjaran ?? "");
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
    setState(() {
      data.clear();
      data = dataMapel.listUjian
          .where((element) => element.days?.toLowerCase() == hari)
          .toList();
      // data.sort(
      //   (a, b) => a.jamAwal!.compareTo(b.jamAwal!),
      // );
      isOnline = true;
    });
  }

  handleTap() {
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return (isOnline)
        ? Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    child: Text(
                      "Jadwal Ujian",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Roboto",
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    child: Divider(
                      thickness: 1,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  CustomTabBar(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    tab: selectedTab,
                    scrollController: scrollController,
                    onChange: (selected) {
                      setState(() {
                        selectedTab = selected;
                        hari = validator(selectedTab);
                      });
                      // getData();
                      handleTap();
                      pageController.animateToPage(
                        selected - 1,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.decelerate,
                      );
                    },
                    count: days.length,
                    hari: days,
                  ),
                  Container(
                    height: 400,
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height - 197,
                    ),
                    child: Consumer<PelajaranProvider>(
                      builder: (context, pelProv, child) {
                        return PageView.builder(
                          controller: pageController,
                          onPageChanged: (value) {
                            setState(() {
                              selectedTab = value + 1;
                              hari = validator(selectedTab);
                            });
                            // getData();
                            handleTap();
                            if (selectedTab > 3) {
                              scrollController.animateTo(
                                100.00,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.decelerate,
                              );
                            } else if (selectedTab < 4) {
                              scrollController.animateTo(
                                0,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.decelerate,
                              );
                            }
                          },
                          itemCount: tabItems.length,
                          itemBuilder: (context, index) {
                            // if (data.isEmpty) {
                            //   return const NullJadwalUjian();
                            // }
                            // return FadeTransition(
                            //   opacity: Tween<double>(
                            //     begin: 0.0,
                            //     end: 1.0,
                            //   ).animate(
                            //     CurvedAnimation(
                            //       parent: AnimationController(
                            //         vsync: vsync,
                            //         duration: const Duration(seconds: 1),
                            //         reverseDuration:
                            //             const Duration(seconds: 1000),
                            //       ).drive(
                            //         Tween<double>(
                            //           begin: 1.0,
                            //           end: 0.8,
                            //         ),
                            //       ).drive(
                            //         CurveTween(
                            //           curve: Curves.decelerate,
                            //         ),
                            //       ),
                            //       curve: Curves.decelerate,
                            //     ),
                            //   ),
                            //   child: (data.isEmpty)
                            //       ? const NullJadwalUjian()
                            //       : ContentUjian(data: data),
                            // );
                            
                            // selain animasi diatas apakah ada yang lain?
                            // karena saya coba pakai animasi diatas, tapi tidak ada perubahan

                            return AnimatedSwitcher(
                              duration: const Duration(milliseconds: 500),
                              transitionBuilder: (child, animation) {
                                return FadeTransition(
                                  opacity: animation.drive(
                                    Tween<double>(
                                      begin: 0.0,
                                      end: 1.0,
                                    ),
                                  ),
                                  child: child,
                                );
                              },
                              layoutBuilder: (currentChild, previousChildren) {
                                return currentChild!;
                              },
                              child:  (data.isEmpty)
                                  ? const NullJadwalUjian()
                                  : ContentUjian(data: data),
                            );

                            // return ContentUjian(data: data);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          )
        : const SekeletonMapel();
  }

  String validator(int i) {
    switch (i) {
      case 1:
        return "senin";
      case 2:
        return "selasa";
      case 3:
        return "rabu";
      case 4:
        return "kamis";
      case 5:
        return "jumat";
      case 6:
        return "sabtu";
      default:
        return "minggu";
    }
  }
}
