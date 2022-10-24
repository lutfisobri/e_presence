import 'package:e_presence/utils/static.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// class CustomTabBar {
//   activeBtn(String activeBtn, bool mapel) {
//     switch (activeBtn) {
//       case '1':
//         return content("senin", mapel);
//       case '2':
//         return content("selasa", mapel);
//       case '3':
//         return content("rabu", mapel);
//       case '4':
//         return content("kamis", mapel);
//       case '5':
//         return content("jumat", mapel);
//       case '6':
//         return content("sabtu", mapel);
//       default:
//     }
//   }

//   ListView content(String Hari, bool mapel) {
//     return mapel ? ListView.separated(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       itemBuilder: (context, index) => Container(
//         height: 48.6.h,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(6),
//         ),
//         padding: EdgeInsets.only(left: 12.6.r),
//         child: Row(
//           children: [
//             Text(Hari),
//             Container(
//               width: 25.2.w,
//               height: 25.2.h,
//               color: Colors.yellow,
//             ),
//             SizedBox(
//               width: 12.6.w,
//             ),
//             Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Matematika",
//                   style: TextStyle(
//                     fontSize: 12.6.sp,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 Text(
//                   "tanggal",
//                   style: TextStyle(
//                     fontSize: 11.03.sp,
//                     fontWeight: FontWeight.w500,
//                     color: const Color(0XFF333333),
//                   ),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//       separatorBuilder: (context, index) => Container(
//         height: 12.6.h,
//       ),
//       itemCount: 20,
//     ) : ListView.separated(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       itemBuilder: (context, index) => Container(
//         height: 48.6.h,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(6),
//           border: Border.all(color: Colors.black),
//         ),
//         padding: EdgeInsets.only(left: 12.6.r),
//         child: Row(
//           children: [
//             Container(
//               width: 25.2.w,
//               height: 25.2.h,
//               color: Colors.yellow,
//             ),
//             SizedBox(
//               width: 12.6.w,
//             ),
//             Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Ujian",
//                   style: TextStyle(
//                     fontSize: 12.6.sp,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 Text(
//                   "tanggal",
//                   style: TextStyle(
//                     fontSize: 11.03.sp,
//                     fontWeight: FontWeight.w500,
//                     color: const Color(0XFF333333),
//                   ),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//       separatorBuilder: (context, index) => Container(
//         height: 12.6.h,
//       ),
//       itemCount: 20,
//     );
//   }
// }

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
