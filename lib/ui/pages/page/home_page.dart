import 'package:e_presence/core/providers/api_controller.dart';
import 'package:e_presence/utils/static.dart';
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
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();
    var time = DateFormat('EEEE, d MMMM y').format(date);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Consumer<ApiController>(
          builder: (context, value, child) => Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Mata Pelajaran",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Hari Ini",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 12.6,
              ),
              value.getJadwal.isEmpty ? nullContent(context) : content(value),
              Padding(
                padding: const EdgeInsets.only(
                    top: 12.9, left: 19, right: 19, bottom: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Informasi Akademik",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Terbaru",
                      style: TextStyle(
                        fontSize: 12.6,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              inforAkademik(value),
            ],
          ),
        ),
      ],
    );
  }

  SizedBox inforAkademik(ApiController value) {
    return SizedBox(
      height: 129,
      child: ListView.separated(
        separatorBuilder: (context, index) => Container(
          width: 14,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: 2,
        shrinkWrap: true,
        padding: const EdgeInsets.only(left: 19, right: 19, top: 8, bottom: 8),
        itemBuilder: (context, index) => Container(
          width: 246,
          height: 119,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 1),
                  blurRadius: 5,
                  color: Color(0XFF000000).withOpacity(0.25),
                ),
              ]),
          child: Center(
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 12.6, right: 12.6),
                  width: 57,
                  height: 57,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(3.15),
                    child: Image.network(value.getJadwal[0].logo),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Title",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0XFF193D28),
                      ),
                    ),
                    Text(
                      "Subtitle",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0XFF193D28),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
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
        height: 12.6,
      ),
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(
        left: 19,
        right: 19,
      ),
      shrinkWrap: true,
      itemCount: value.getJadwal.length,
      itemBuilder: (context, index) {
        var dateTime = DateTime.parse(value.getJadwal[index].jam);
        return Container(
          height: 56.6,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color(0XFF000000).withOpacity(0.25),
                offset: const Offset(0, 1),
                blurRadius: 5,
              ),
            ],
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            children: [
              Container(
                margin:
                    const EdgeInsets.only(top: 10.8, left: 12.6, bottom: 10.8),
                height: 35,
                width: 35,
                child: Image.network(value.getJadwal[index].logo),
              ),
              const SizedBox(
                width: 12.6,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value.getJadwal[index].name,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    DateFormat('MMMM d,y').format(dateTime),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
