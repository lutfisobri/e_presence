import 'dart:async';

import 'package:app_presensi/app/models/mapel.dart';
import 'package:app_presensi/app/providers/pelajaran.dart';
import 'package:app_presensi/app/providers/user.dart';
import 'package:app_presensi/resources/utils/days.dart';
import 'package:app_presensi/resources/utils/static.dart';
import 'package:app_presensi/resources/widgets/constant/tab_bar.dart';
import 'package:app_presensi/resources/widgets/shared/notification.dart';
import 'package:app_presensi/resources/widgets/shared/theme.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

class Mapel extends StatefulWidget {
  const Mapel({super.key});

  @override
  State<Mapel> createState() => _MapelState();
}

class _MapelState extends State<Mapel> with TickerProviderStateMixin {
  late StreamSubscription subscription;
  var isDeviceConnected = false;
  bool isAlert = false;
  StyleThemeData styleThemeData = StyleThemeData();
  ScrollController scrollController = ScrollController();
  PageController pageController = PageController();
  int selectedTab = 1;
  String hari = "senin";
  List<ModelMapel> data = [];
  @override
  void initState() {
    getConnectivity();
    super.initState();
    getData();
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

  showDialogbox() => showCupertinoDialog<String>(
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
                  showDialogbox();
                  setState(() => isAlert = true);
                }
              },
              child: const Text("Tutup"),
            ),
          ],
        ),
      );

  getData() {
    final dataMapel = Provider.of<PelajaranProvider>(context, listen: false);
    final user = Provider.of<UserProvider>(context, listen: false);
    dataMapel.allMapel(idKelas: user.dataUser.idKelas);
    user.checkAccount().then((value) {
      if (value == 401) {
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
                user.isLogin = false;
              },
            ),
          ),
        );
      } else if (value == 203) {
        return;
      } else {
        user.isLogin = false;
      }
    });
    setState(() {
      data = dataMapel.listMapel
          .where((element) => element.hari.toLowerCase() == hari)
          .toList();
      data.sort(
        (a, b) => a.jamAwal.compareTo(b.jamAwal),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
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
              child: Consumer<PelajaranProvider>(
                builder: (context, pelProv, child) {
                  return PageView.builder(
                    controller: pageController,
                    onPageChanged: (value) {
                      setState(() {
                        selectedTab = value + 1;
                        hari = validator(selectedTab);
                      });
                      getData();
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
                      return Padding(
                        padding: const EdgeInsets.only(left: 19, right: 19),
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) => Container(
                            height: 12.6,
                          ),
                          itemCount: data.length,
                          itemBuilder: (context, i) {
                            return Container(
                              height: 56.6,
                              width: double.infinity,
                              padding: const EdgeInsets.only(
                                  left: 12.6, right: 12.6),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0XFF909090)
                                        .withOpacity(0.20),
                                    offset: const Offset(0, 1),
                                    blurRadius: 2,
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3.15),
                                    ),
                                    child: iconMapel(pelProv, i,
                                        jenis: Pelajaran.mapel),
                                  ),
                                  const SizedBox(
                                    width: 12.6,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data[i].namaMapel,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "Roboto",
                                        ),
                                      ),
                                      Text(
                                        "Jam ${data[i].jamAwal} - ${data[i].jamAkhir} WIB",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Roboto",
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
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
