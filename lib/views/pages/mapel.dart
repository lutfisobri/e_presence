import 'dart:async';
import 'package:app_presensi/app/models/mapel.dart';
import 'package:app_presensi/app/providers/pelajaran.dart';
import 'package:app_presensi/app/providers/user.dart';
import 'package:app_presensi/resources/utils/days.dart';
import 'package:app_presensi/resources/utils/static.dart';
import 'package:app_presensi/resources/widgets/constant/tab_bar.dart';
import 'package:app_presensi/resources/widgets/shared/notification.dart';
import 'package:app_presensi/resources/widgets/shared/theme.dart';
import 'package:app_presensi/views/pages/component/mapel/content.dart';
import 'package:app_presensi/views/pages/skeleton.dart';
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
    Future.delayed(const Duration(seconds: 1), () {
      setState(() => isLoading = false);
    });
  }

  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && !isAlert) {
            isLoading = true;
            setState(() => isAlert = true);
          } else if (isDeviceConnected && isAlert) {
            isLoading = false;
            setState(() => isAlert = false);
          }
        },
      );

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  bool isLoading = true;

  // showDialogbox() => showCupertinoDialog<String>(
  //       context: context,
  //       builder: (BuildContext contex) => CupertinoAlertDialog(
  //         title: const Text("Peringatan"),
  //         content: const Text("Tidak ada koneksi internet"),
  //         actions: <Widget>[
  //           TextButton(
  //             onPressed: () async {
  //               Navigator.pop(context, 'cancel');
  //               setState(() => isAlert = false);
  //               isDeviceConnected =
  //                   await InternetConnectionChecker().hasConnection;
  //               if (!isDeviceConnected) {
  //                 showDialogbox();
  //                 setState(() => isAlert = true);
  //               }
  //             },
  //             child: const Text("Tutup"),
  //           ),
  //         ],
  //       ),
  //     );

  getData() {
    final dataMapel = Provider.of<PelajaranProvider>(context, listen: false);
    final user = Provider.of<UserProvider>(context, listen: false);
    dataMapel.allMapel(idKelasAjaran: user.dataUser.idKelasAjaran ?? "");
    user.checkAccount().then((value) {
      if (value) {
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
      } else {
        user.isLogin = false;
      }
    });
    setState(() {
      data = dataMapel.listMapel
          .where((element) => element.hari!.toLowerCase() == hari)
          .toList();
      data.sort(
        (a, b) => a.jamMulai!.compareTo(b.jamSelesai!),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(
                  left: 19,
                  right: 132,
                ),
                decoration: const BoxDecoration(),
                child: SkeletonContainer.square(
                  height: 21,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(
                  left: 19,
                  right: 19,
                  top: 30,
                ),
                decoration: const BoxDecoration(),
                child: SkeletonContainer.square(
                  height: 4,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(
                  left: 15,
                  right: 298,
                  top: 46,
                ),
                decoration: const BoxDecoration(),
                child: SkeletonContainer.square(
                  height: 15,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(
                  left: 116,
                  right: 224,
                  top: 46,
                ),
                decoration: const BoxDecoration(),
                child: SkeletonContainer.square(
                  height: 15,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(
                  left: 182,
                  right: 154,
                  top: 46,
                ),
                decoration: const BoxDecoration(),
                child: SkeletonContainer.square(
                  height: 15,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(
                  left: 266,
                  right: 76,
                  top: 46,
                ),
                decoration: const BoxDecoration(),
                child: SkeletonContainer.square(
                  height: 15,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(
                  left: 340,
                  right: 1,
                  top: 46,
                ),
                decoration: const BoxDecoration(),
                child: SkeletonContainer.square(
                  height: 15,
                  width: MediaQuery.of(context).size.width,
                ),
              ),

              //list
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(
                  left: 19,
                  right: 19,
                  top: 93,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 56.6,
                  color: Color.fromRGBO(240, 240, 240, 1),
                ),
              ),

              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(
                  right: 293.4,
                  left: 31.6,
                  top: 103.8,
                ),
                decoration: const BoxDecoration(),
                child: SkeletonContainer.square(
                  height: 35,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(
                  right: 199,
                  left: 107,
                  top: 104,
                ),
                decoration: const BoxDecoration(),
                child: SkeletonContainer.square(
                  height: 15,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(
                  right: 138,
                  left: 107,
                  top: 124,
                ),
                decoration: const BoxDecoration(),
                child: SkeletonContainer.square(
                  height: 15,
                  width: MediaQuery.of(context).size.width,
                ),
              ),

              //list
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(
                  left: 19,
                  right: 19,
                  top: 162.2,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 56.6,
                  color: Color.fromRGBO(240, 240, 240, 1),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(
                  right: 293.4,
                  left: 31.6,
                  top: 174,
                ),
                decoration: const BoxDecoration(),
                child: SkeletonContainer.square(
                  height: 35,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(
                  right: 199,
                  left: 107,
                  top: 174,
                ),
                decoration: const BoxDecoration(),
                child: SkeletonContainer.square(
                  height: 15,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(
                  right: 138,
                  left: 107,
                  top: 193,
                ),
                decoration: const BoxDecoration(),
                child: SkeletonContainer.square(
                  height: 15,
                  width: MediaQuery.of(context).size.width,
                ),
              ),

              //list
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(
                  left: 19,
                  right: 19,
                  top: 231.41,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 56.6,
                  color: Color.fromRGBO(240, 240, 240, 1),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(
                  right: 293.4,
                  left: 31.6,
                  top: 242,
                ),
                decoration: const BoxDecoration(),
                child: SkeletonContainer.square(
                  height: 35,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(
                  right: 199,
                  left: 107,
                  top: 242,
                ),
                decoration: const BoxDecoration(),
                child: SkeletonContainer.square(
                  height: 15,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(
                  right: 138,
                  left: 107,
                  top: 262,
                ),
                decoration: const BoxDecoration(),
                child: SkeletonContainer.square(
                  height: 15,
                  width: MediaQuery.of(context).size.width,
                ),
              ),

              //list
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(
                  left: 19,
                  right: 19,
                  top: 300.61,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 56.6,
                  color: Color.fromRGBO(240, 240, 240, 1),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(
                  right: 293.4,
                  left: 31.6,
                  top: 312,
                ),
                decoration: const BoxDecoration(),
                child: SkeletonContainer.square(
                  height: 35,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(
                  right: 199,
                  left: 107,
                  top: 312,
                ),
                decoration: const BoxDecoration(),
                child: SkeletonContainer.square(
                  height: 15,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(
                  right: 138,
                  left: 107,
                  top: 331,
                ),
                decoration: const BoxDecoration(),
                child: SkeletonContainer.square(
                  height: 15,
                  width: MediaQuery.of(context).size.width,
                ),
              ),

              // list
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(
                  left: 19,
                  right: 19,
                  top: 369.81,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 56.6,
                  color: Color.fromRGBO(240, 240, 240, 1),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(
                  right: 293.4,
                  left: 31.6,
                  top: 381,
                ),
                decoration: const BoxDecoration(),
                child: SkeletonContainer.square(
                  height: 35,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(
                  right: 199,
                  left: 107,
                  top: 381,
                ),
                decoration: const BoxDecoration(),
                child: SkeletonContainer.square(
                  height: 15,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(
                  right: 138,
                  left: 107,
                  top: 401,
                ),
                decoration: const BoxDecoration(),
                child: SkeletonContainer.square(
                  height: 15,
                  width: MediaQuery.of(context).size.width,
                ),
              ),

              // list
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(
                  left: 19,
                  right: 19,
                  top: 439.01,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 56.6,
                  color: Color.fromRGBO(240, 240, 240, 1),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(
                  right: 293.4,
                  left: 31.6,
                  top: 451,
                ),
                decoration: const BoxDecoration(),
                child: SkeletonContainer.square(
                  height: 35,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(
                  right: 199,
                  left: 107,
                  top: 451,
                ),
                decoration: const BoxDecoration(),
                child: SkeletonContainer.square(
                  height: 15,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(
                  right: 138,
                  left: 107,
                  top: 470,
                ),
                decoration: const BoxDecoration(),
                child: SkeletonContainer.square(
                  height: 15,
                  width: MediaQuery.of(context).size.width,
                ),
              ),

              // list
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(
                  left: 19,
                  right: 19,
                  top: 508.22,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 56.6,
                  color: Color.fromRGBO(240, 240, 240, 1),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(
                  right: 293.4,
                  left: 31.6,
                  top: 519.02,
                ),
                decoration: const BoxDecoration(),
                child: SkeletonContainer.square(
                  height: 35,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(
                  right: 199,
                  left: 107,
                  top: 519.02,
                ),
                decoration: const BoxDecoration(),
                child: SkeletonContainer.square(
                  height: 15,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(
                  right: 138,
                  left: 107,
                  top: 537.52,
                ),
                decoration: const BoxDecoration(),
                child: SkeletonContainer.square(
                  height: 15,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            ],
          )
        : Stack(
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
                                padding:
                                    const EdgeInsets.only(left: 19, right: 19),
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  separatorBuilder: (context, index) =>
                                      Container(
                                    height: 12.6,
                                  ),
                                  itemCount: data.length,
                                  itemBuilder: (context, i) {
                                    return ContentMapel(data: data, i: i);
                                  },
                                ));
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
      default:
        return "jumat";
    }
  }
}
