import 'package:e_presence/core/providers/pelajaran_provider.dart';
import 'package:e_presence/core/providers/user_provider.dart';
import 'package:e_presence/ui/shared/constant/tab_bar.dart';
import 'package:e_presence/ui/shared/theme_data.dart';
import 'package:e_presence/utils/static.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class JadwalPage extends StatefulWidget {
  const JadwalPage({super.key});

  @override
  State<JadwalPage> createState() => _JadwalPageState();
}

class _JadwalPageState extends State<JadwalPage> {
  StyleThemeData styleThemeData = StyleThemeData();
  ScrollController scrollController = ScrollController();
  PageController pageController = PageController();
  List data = [];
  int selectedTab = 1;

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
        Navigator.pushReplacementNamed(context, "/login");
        user.userClearData();
      } else if (value == 200) {
        return;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
            });
            pageController.animateToPage(
              selected - 1,
              duration: const Duration(milliseconds: 500),
              curve: Curves.decelerate,
            );
          },
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
                  });
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
                    itemCount: pelProv.listMapel.length,
                    itemBuilder: (context, index) {
                      pelProv.listMapel
                          .sort((a, b) => a.jadwal.compareTo(b.jadwal));
                      return Container(
                        height: 56.6,
                        width: double.infinity,
                        padding: const EdgeInsets.only(left: 12.6, right: 12.6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              offset: const Offset(0, 1),
                              blurRadius: 5,
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
                              child: const CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            ),
                            const SizedBox(
                              width: 12.6,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  pelProv.listMapel[index].namaMapel,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Roboto",
                                  ),
                                ),
                                Text(
                                  DateFormat('EEEE dd,y', 'id_ID').format(
                                    DateTime.parse(
                                      pelProv.listMapel[index].jadwal,
                                    ),
                                  ),
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
    );
  }
}
