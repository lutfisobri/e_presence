import 'package:e_presence/ui/shared/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/api_controller.dart';

class Mapel extends StatefulWidget {
  Mapel({super.key});

  @override
  State<Mapel> createState() => _MapelState();
}

class _MapelState extends State<Mapel> with TickerProviderStateMixin {
  StyleThemeData styleThemeData = StyleThemeData();
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 6, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final api = Provider.of<ApiController>(context, listen: false);
    api.loadJadwal;
    api.postUser();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Jadwal Mata Pelajaran",
          style: TextStyle(
            fontSize: 20.sp,
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
        const Divider(
          thickness: 1,
          color: Colors.black,
        ),
        // SizedBox(
        //   height: 13.r,
        // ),
        DefaultTabController(
          length: 6, // length of tabs
          initialIndex: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                child: TabBar(
                  isScrollable: true,
                  labelColor: Colors.green,
                  unselectedLabelColor: Colors.black,
                  tabs: [
                    Tab(text: 'Senin'),
                    Tab(text: 'Selasa'),
                    Tab(text: 'Rabu'),
                    Tab(text: 'Kamis'),
                    Tab(text: 'Jumat'),
                    Tab(text: 'Sabtu'),
                  ],
                  indicatorColor: Colors.transparent,
                ),
              ),
              Container(
                height: 400, //height of TabBarView
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.grey, width: 0.5),
                  ),
                ),
                child: TabBarView(
                  children: <Widget>[
                    Container(
                      child: Center(
                        child: Text(
                          'Display Tab 1',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      child: Center(
                        child: Text(
                          'Display Tab 2',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      child: Center(
                        child: Text(
                          'Display Tab 3',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      child: Center(
                        child: Text(
                          'Display Tab 4',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      child: Center(
                        child: Text(
                          'Display Tab 4',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      child: Center(
                        child: Text(
                          'Display Tab 4',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  TextStyle style(Color colors) {
    return TextStyle(
      color: colors,
      fontWeight: FontWeight.w600,
      fontSize: 12.6.sp,
    );
  }
}
