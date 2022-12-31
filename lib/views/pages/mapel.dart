import 'dart:async';
import 'package:app_presensi/app/models/mapel.dart';
import 'package:app_presensi/app/providers/pelajaran.dart';
import 'package:app_presensi/app/providers/user.dart';
import 'package:app_presensi/resources/utils/days.dart';
import 'package:app_presensi/resources/utils/static.dart';
import 'package:app_presensi/resources/widgets/constant/tab_bar.dart';
import 'package:app_presensi/resources/widgets/shared/notifications/session.dart';
import 'package:app_presensi/resources/widgets/shared/theme.dart';
import 'package:app_presensi/views/pages/component/mapel/content.dart';
import 'package:app_presensi/views/pages/component/mapel/null.dart';
import 'package:app_presensi/views/pages/component/mapel/skeleton.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

class Mapel extends StatefulWidget {
  const Mapel({super.key});

  @override
  State<Mapel> createState() => _MapelState();
}

class _MapelState extends State<Mapel> with TickerProviderStateMixin {
  late StreamSubscription<InternetConnectionStatus> listener;
  bool isOnline = false;
  void hasConnect() async {
    listener = InternetConnectionChecker().onStatusChange.listen(
      (InternetConnectionStatus status) {
        switch (status) {
          case InternetConnectionStatus.connected:
            getData();
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
  int selectedTab = 1;
  String hari = "senin";
  List<ModelMapel> data = [];

  @override
  void initState() {
    super.initState();
    hasConnect();
    init();
  }

  @override
  void dispose() {
    listener.cancel();
    super.dispose();
  }

  getData() async {
    final dataMapel = Provider.of<PelajaranProvider>(context, listen: false);
    final user = Provider.of<UserProvider>(context, listen: false);
    dataMapel.allMapel(idKelasAjaran: user.dataUser.idKelasAjaran ?? "");
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
    if (!mounted) return;
    setState(() {
      data.clear();
      data = dataMapel.listMapel.where((element) {
        if (element.hari != null) {
          return element.hari!.toLowerCase() == hari;
        }
        return false;
      }).toList();
      if (data.isNotEmpty) {
        data.sort(
          (a, b) => a.jamMulai!.compareTo(b.jamSelesai!),
        );
      }
      setState(() {
        isOnline = true;
      });
    });
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
                      left: 19,
                      right: 19,
                    ),
                    child: Text(
                      "Jadwal Mata Pelajaran",
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
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    tab: selectedTab,
                    onChange: (newSelected) {
                      setState(() {
                        selectedTab = newSelected;
                        hari = validator(selectedTab);
                      });
                      getData();
                      pageController.animateToPage(
                        newSelected - 1,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.decelerate,
                      );
                    },
                    scrollController: scrollController,
                    count: days.length,
                    hari: days,
                  ),
                  Container(
                    height: 400,
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height - 197,
                    ),
                    child: PageView.builder(
                      controller: pageController,
                      onPageChanged: (value) {
                        setState(() {
                          selectedTab = value + 1;
                          hari = validator(selectedTab);
                        });
                        getData();
                        if (selectedTab >= 3) {
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
                        if (data.isEmpty) {
                          return const NullMatapelajaran();
                        }
                        return Padding(
                          padding: const EdgeInsets.only(left: 19, right: 19),
                          child: ContentMapel(hari: hari, tickerProvider: this),
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
      default:
        return "jumat";
    }
  }
}
