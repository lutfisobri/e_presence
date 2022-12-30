import 'package:app_presensi/resources/utils/static.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({
    super.key,
    required this.tab,
    required this.onChange,
    required this.count,
    required this.hari,
    this.padding,
    this.scrollController,
    this.physics,
  });

  final int tab;
  final Function(int) onChange;
  final EdgeInsets? padding;
  final ScrollController? scrollController;
  final List hari;
  final int count;
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: ListView.builder(
        controller: scrollController,
        padding: padding,
        itemCount: count,
        physics: physics,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              onChange(hari[index]['id']);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              margin: const EdgeInsets.only(right: 7),
              decoration: BoxDecoration(
                color: tab == hari[index]['id']
                    ? colorGreen.withOpacity(0.7)
                    : const Color(0XFFD9F2E6),
                borderRadius: BorderRadius.circular(9),
              ),
              child: Text(
                hari[index]['day'],
                style: TextStyle(
                  color: tab == hari[index]['id']
                      ? Colors.black
                      : const Color(0XFF777777),
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  fontFamily: "Roboto",
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
