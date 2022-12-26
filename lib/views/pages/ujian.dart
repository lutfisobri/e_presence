import 'dart:async';
import 'package:app_presensi/app/models/ujian.dart';
import 'package:app_presensi/app/providers/pelajaran.dart';
import 'package:app_presensi/app/providers/user.dart';
import 'package:app_presensi/resources/utils/days.dart';
import 'package:app_presensi/resources/utils/static.dart';
import 'package:app_presensi/resources/widgets/constant/tab_bar.dart';
import 'package:app_presensi/resources/widgets/shared/notification.dart';
import 'package:app_presensi/resources/widgets/shared/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

import 'component/mapel/skeleton.dart';

class JadwalPage extends StatefulWidget {
  const JadwalPage({super.key});

  @override
  State<JadwalPage> createState() => _JadwalPageState();
}

class _JadwalPageState extends State<JadwalPage> {
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
              // isLoading = false;
            });
            break;
          case InternetConnectionStatus.disconnected:
            if (!mounted) return;
            setState(() {
              isOnline = false;
              // isLoading = true;
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
      getData();
    } else {
      // isLoading = true;
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

  // showDialogbox() => showCupertinoDialog<String>(
  //       context: context,
  //       builder: (BuildContext contex) => CupertinoAlertDialog(
  //         title: const Text("Peringatan"),
  //         content: const Text("Tidak ada koneksi internet"),
  //         actions: <Widget>[
  //           TextButton(
  //             onPressed: () async {
  //               Navigator.pop(context, 'cancel');
  //               if (!isOnline) showDialogbox();
  //             },
  //             child: const Text("Tutup"),
  //           ),
  //         ],
  //       ),
  //     );

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
      data = dataMapel.listUjian
          .where((element) => element.hari?.toLowerCase() == hari)
          .toList();
      data.sort(
        (a, b) => a.jamAwal!.compareTo(b.jamAwal!),
      );
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
                      getData();
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
                          itemBuilder: (context, index) => Padding(
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
                                          borderRadius:
                                              BorderRadius.circular(3.15),
                                        ),
                                        child: iconMapel(pelProv, i,
                                            jenis: Pelajaran.ujian),
                                      ),
                                      const SizedBox(
                                        width: 12.6,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data[i].namaMapel ?? "",
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
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          )
        : SekeletonMapel();
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
