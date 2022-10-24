import 'package:e_presence/core/providers/api_controller.dart';
import 'package:e_presence/core/providers/user_controller.dart';
import 'package:e_presence/ui/shared/constant/tab_bar.dart';
import 'package:e_presence/ui/shared/theme_data.dart';
import 'package:e_presence/utils/static.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class Mapel extends StatefulWidget {
  const Mapel({super.key});

  @override
  State<Mapel> createState() => _MapelState();
}

class _MapelState extends State<Mapel> with TickerProviderStateMixin {
  StyleThemeData styleThemeData = StyleThemeData();
  int selectedTab = 1;
  List data = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() {
    final dataMapel = Provider.of<UserControlProvider>(context, listen: false);
    // data = dataMapel.dataMapel.where((i) => i.hari == selectedTab).toList();
    data = content.where((i) => i['hari'] == selectedTab).toList();
  }

  @override
  Widget build(BuildContext context) {
    final api = Provider.of<ApiController>(context, listen: false);
    api.loadJadwal;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: Text(
            "Jadwal Mata Pelajaran",
            style: TextStyle(
              fontSize: 20.sp,
              color: Colors.black,
              fontWeight: FontWeight.w700,
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
          height: 13.r,
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
              getData();
            });
          },
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 12.6,
          ),
          child:
              Consumer<UserControlProvider>(builder: (context, value, child) {
            return ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              separatorBuilder: (context, index) => Container(),
              itemBuilder: (context, index) =>
                  Text(data[index]['mapel']),
              itemCount: data.length,
            );
          }),
        )
      ],
    );
  }
}
