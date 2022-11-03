import 'package:e_presence/core/providers/pelajaran_provider.dart';
import 'package:e_presence/core/providers/user_provider.dart';
import 'package:e_presence/ui/shared/constant/tab_bar.dart';
import 'package:e_presence/ui/shared/theme_data.dart';
import 'package:e_presence/utils/static.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
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
  List data = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() {
    final dataMapel = Provider.of<PelajaranProvider>(context, listen: false);
    final user = Provider.of<UserControlProvider>(context, listen: false);
    dataMapel.loadMapel(user.dataUser.idKelas);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
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
        SizedBox(
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
            });
            pageController.animateToPage(
              newSelected - 1,
              duration: Duration(milliseconds: 500),
              curve: Curves.decelerate,
            );
          },
          scrollController: scrollController,
        ),
        Container(
          height: 400,
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height - 150.h,
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
                      duration: Duration(milliseconds: 500),
                      curve: Curves.decelerate,
                    );
                  } else if (selectedTab < 4) {
                    scrollController.animateTo(
                      0,
                      duration: Duration(milliseconds: 500),
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
                      var date =
                          DateTime.parse(pelProv.listMapel[index].jadwal);
                      pelProv.listMapel
                          .sort((a, b) => a.jadwal.compareTo(b.jadwal));
                      return Container(
                        height: 56.6,
                        width: double.infinity,
                        padding: EdgeInsets.only(left: 12.6, right: 12.6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              offset: Offset(0, 1),
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
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            ),
                            SizedBox(
                              width: 12.6,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  pelProv.listMapel[index].namaMapel,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Roboto",
                                  ),
                                ),
                                Text(
                                  DateFormat('EEEE dd,y').format(date),
                                  style: TextStyle(
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
