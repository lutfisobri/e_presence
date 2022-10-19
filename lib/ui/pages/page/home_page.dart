import 'package:e_presence/core/providers/api_controller.dart';
import 'package:e_presence/ui/shared/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  _refreshJadwal(ApiController api) async {
    await Future.delayed(
      Duration(seconds: 1),
    );
    api.loadJadwal();
  }

  loadData() {
    final api = context.read<ApiController>();
    api.loadJadwal();
    api.postUser();
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  final styleThemeData = StyleThemeData();

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();
    var time = DateFormat('EEEE, d MMMM y').format(date);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Consumer<ApiController>(
          builder: (context, value, child) => Wrap(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Hari ini",
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: styleThemeData.textColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    time,
                    style: TextStyle(
                      fontSize: 12.6.sp,
                      color: styleThemeData.textColor,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16.r,
              ),
              value.getJadwal.isEmpty ? nullContent(context) : content(value),
            ],
          ),
        ),
      ],
    );
  }

  Row nullContent(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
          child: Text(
            "Yeay, tidak ada mata pelajaran",
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ],
    );
  }

  ListView content(ApiController value) {
    return ListView.separated(
      separatorBuilder: (context, index) => Container(
        height: 16.h,
      ),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: value.getJadwal.length,
      itemBuilder: (context, index) {
        var dateTime = DateTime.parse(value.getJadwal[index].jam);
        return Container(
          height: 70,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 8),
                blurRadius: 20,
              ),
            ],
            borderRadius: BorderRadius.circular(11),
          ),
          child: ListTile(
            onTap: () {
              Navigator.pushNamed(
                context,
                "/detailPresensi",
                arguments: value.getJadwal[index].id,
              );
            },
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(11),
              child: Image(
                height: 50,
                width: 50,
                fit: BoxFit.cover,
                image: NetworkImage(value.getJadwal[index].logo),
              ),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  value.getJadwal[index].name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  DateFormat('hh.mm - hh.mm').format(dateTime),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
