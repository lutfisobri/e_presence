import 'package:e_presence/utils/static.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTabBar extends StatelessWidget {
  final int tab;
  final Function(int) onChange;
  final EdgeInsets? padding;
  const CustomTabBar({
    super.key,
    required this.tab,
    required this.onChange,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: ListView.separated(
        padding: padding,
        separatorBuilder: (context, index) => Container(
          width: 31.w,
        ),
        itemCount: tabItems.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              onChange(tabItems[index]['id']);
              print(tabItems[index]);
            },
            child: Text(
              tabItems[index]['day'],
              style: TextStyle(
                color: tab == tabItems[index]['id']
                    ? Colors.black
                    : const Color(0XFF777777),
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          );
        },
      ),
    );
  }
}
