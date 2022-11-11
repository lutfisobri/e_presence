import 'package:e_presence/core/model/model_mapel.dart';
import 'package:e_presence/core/providers/pelajaran_provider.dart';
import 'package:e_presence/core/providers/user_provider.dart';
import 'package:e_presence/ui/shared/constant/tab_bar.dart';
import 'package:e_presence/ui/shared/theme_data.dart';
import 'package:e_presence/ui/shared/widgets/dialog.dart';
import 'package:e_presence/utils/static.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Mapel extends StatefulWidget {
  const Mapel({super.key});

  @override
  State<Mapel> createState() => _MapelState();
}

class _MapelState extends State<Mapel> with TickerProviderStateMixin {
  StyleThemeData styleThemeData = StyleThemeData();
  ScrollController scrollController = ScrollController();
  PageController pageController = PageController();
  int selectedTab = 1;
  String hari = "senin";
  List<ModelMapel> data = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() {
    final dataMapel = Provider.of<PelajaranProvider>(context, listen: false);
    final user = Provider.of<UserControlProvider>(context, listen: false);
    dataMapel.loadMapel(user.dataUser.idKelas);
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
