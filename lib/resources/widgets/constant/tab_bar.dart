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
  });

  final int tab;
  final Function(int) onChange;
  final EdgeInsets? padding;
  final ScrollController? scrollController;
  final List hari;
  final int count;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: ListView.separated(
        controller: scrollController,
        padding: padding,
        separatorBuilder: (context, index) => Container(
          width: 31.w,
        ),
        itemCount: count,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              onChange(hari[index]['id']);
            },
            child: Text(
              hari[index]['day'],
              style: TextStyle(
                color: tab == hari[index]['id']
                    ? Colors.black
                    : const Color(0XFF777777),
                fontWeight: FontWeight.w600,
                fontSize: 15,
                decoration: tab == hari[index]['id']
                    ? TextDecoration.underline
                    : TextDecoration.none,
                fontFamily: "Roboto",
              ),
            ),
          );
        },
      ),
    );
  }
}
