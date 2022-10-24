import 'package:e_presence/ui/shared/constant/tab_bar.dart';
import 'package:e_presence/ui/shared/theme_data.dart';
import 'package:e_presence/utils/static.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/api_controller.dart';

class JadwalPage extends StatefulWidget {
  const JadwalPage({super.key});

  @override
  State<JadwalPage> createState() => _JadwalPageState();
}

class _JadwalPageState extends State<JadwalPage> {
  StyleThemeData styleThemeData = StyleThemeData();
  List data = [];
  int selectedTab = 1;
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() {
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
          padding: const EdgeInsets.only(left: 20, right: 20),
          tab: selectedTab,
          onChange: (selected) {
            setState(() {
              selectedTab = selected;
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
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => Text(content[index]['mapel']),
            separatorBuilder: (context, index) => Container(),
            itemCount: data.length,
          ),
        ),
      ],
    );
  }
}
